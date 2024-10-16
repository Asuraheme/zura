import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_estate/data.dart';
import 'package:real_estate/filter.dart';
import 'package:real_estate/detail.dart';
import 'package:real_estate/models/property_model.dart';
import 'package:real_estate/setings/setup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Property> properties = getPropertyList();
  List<PropertyModel> propertyFirebaseList = [];
  String categorte = "All";
  final CollectionReference categortiesItem =
      FirebaseFirestore.instance.collection('categories-label');
  Query get filtered => FirebaseFirestore.instance
      .collection('Property')
      .where('label', isEqualTo: categorte);
  Query get allinfo => FirebaseFirestore.instance.collection('Property');
  Query get selectedfilter => categorte == "All" ? allinfo : filtered;
  @override
  void initState() async {
    super.initState();
    propertyFirebaseList = await getPropertyListFromFirebase();

    
    //this code will
    /// Listens to changes in the `selectedfilter` Firestore collection and updates
    /// the `propertyFirebaseList` with the new data. The data is mapped to a list
    /// of `PropertyModel` objects using the `fromJson` method. The `setState`
    /// method is called to ensure the UI is updated with the new list.
    selectedfilter.snapshots().listen((event) {
      setState(() {
        propertyFirebaseList = event.docs
            .map(
                (e) => PropertyModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primerycolor,
        title: const Text(
          'Find you\'re space',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1,
              color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Iconsax.filter,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24, top: 5),
              child: Text(
                "categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: Stack(
                        children: [
                          ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              const SizedBox(
                                width: 24,
                              ),
                              buildFilter(),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 15, left: 24, right: 24),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: buildProperties(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilter() {
    return StreamBuilder(
      stream: categortiesItem.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                snapshot.data!.docs.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      categorte = snapshot.data!.docs[index]['label'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                        color: categorte == snapshot.data!.docs[index]['label']
                            ? primerycolor
                            : Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                          color: primerycolor,
                          width: 1,
                        )),
                    child: Center(
                      child: Text(
                        snapshot.data!.docs[index]['label'],
                        style: TextStyle(
                          color:
                              categorte == snapshot.data!.docs[index]['label']
                                  ? Colors.white
                                  : Colors.grey.shade600,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  List<Widget> buildProperties() {
    List<Widget> list = [];
    for (var i = 0; i < properties.length; i++) {
      list.add(Hero(
          tag: properties[i].frontImage,
          child: buildProperty(properties[i], i)));
    }
    return list;
  }

  Widget buildProperty(Property property, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(property: property)),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 24),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(property.frontImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  width: 80,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: Center(
                    child: Text(
                      "FOR ${property.label}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          property.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          r"$" + property.price,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              property.location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.zoom_out_map,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${property.sqm} sq/m",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${property.review} Reviews",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return const Wrap(
            children: [
              Filtr(),
            ],
          );
        });
  }
}
