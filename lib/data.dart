import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_estate/models/property_model.dart';

class Property {
  String? label;
  String? name;
  String? price;
  String? location;
  String? sqm;
  String? review;
  String? description;
  String? frontImage;
  String? ownerImage;
  List<String>? images;

  Property(
      {this.label,
      this.name,
      this.price,
      this.location,
      this.sqm,
      this.review,
      this.description,
      this.frontImage,
      this.ownerImage,
      this.images});

  Property.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    price = json['price'];
    frontImage = json['frontImage'];
  }
}

// List<Property> getPropertyList() {
//   return <Property>[
//     Property(
//       "SALE",
//       "Clinton Villa",
//       "3,3500.00",
//       "Los Angeles",
//       "2,456",
//       "4.4",
//       "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
//       "assets/images/house_01.jpg",
//       "assets/images/owner.jpg",
//       [
//         "assets/images/kitchen.jpg",
//         "assets/images/bath_room.jpg",
//         "assets/images/swimming_pool.jpg",
//         "assets/images/bed_room.jpg",
//         "assets/images/living_room.jpg",
//       ],
//     ),
//     Property(
//       "RENT",
//       "Salu House",
//       "3,500.00",
//       "Miami",
//       "3,300",
//       "4.6",
//       "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
//       "assets/images/house_04.jpg",
//       "assets/images/owner.jpg",
//       [
//         "assets/images/kitchen.jpg",
//         "assets/images/bath_room.jpg",
//         "assets/images/swimming_pool.jpg",
//         "assets/images/bed_room.jpg",
//         "assets/images/living_room.jpg",
//       ],
//     ),
//     Property(
//       "RENT",
//       "Hilton House",
//       "3,100.00",
//       "California",
//       "2,100",
//       "4.1",
//       "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
//       "assets/images/house_02.jpg",
//       "assets/images/owner.jpg",
//       [
//         "assets/images/kitchen.jpg",
//         "assets/images/bath_room.jpg",
//         "assets/images/swimming_pool.jpg",
//         "assets/images/bed_room.jpg",
//         "assets/images/living_room.jpg",
//       ],
//     ),
//     Property(
//       "SALE",
//       "Ibe House",
//       "4,500.00",
//       "Florida",
//       "4,100",
//       "4.5",
//       "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
//       "assets/images/house_03.jpg",
//       "assets/images/owner.jpg",
//       [
//         "assets/images/kitchen.jpg",
//         "assets/images/bath_room.jpg",
//         "assets/images/swimming_pool.jpg",
//         "assets/images/bed_room.jpg",
//         "assets/images/living_room.jpg",
//       ],
//     ),
//     Property(
//       "SALE",
//       "Aventura",
//       "5,200.00",
//       "New York",
//       "3,100",
//       "4.2",
//       "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
//       "assets/images/house_05.jpg",
//       "assets/images/owner.jpg",
//       [
//         "assets/images/kitchen.jpg",
//         "assets/images/bath_room.jpg",
//         "assets/images/swimming_pool.jpg",
//         "assets/images/bed_room.jpg",
//         "assets/images/living_room.jpg",
//       ],
//     ),
//     Property(
//       "SALE",
//       "North House",
//       "3,500.00",
//       "Florida",
//       "3,700",
//       "4.0",
//       "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
//       "assets/images/house_06.jpg",
//       "assets/images/owner.jpg",
//       [
//         "assets/images/kitchen.jpg",
//         "assets/images/bath_room.jpg",
//         "assets/images/swimming_pool.jpg",
//         "assets/images/bed_room.jpg",
//         "assets/images/living_room.jpg",
//       ],
//     ),
//     Property(
//       "RENT",
//       "Rasmus Resident",
//       "2,900.00",
//       "Detroit",
//       "2,700",
//       "4.3",
//       "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
//       "assets/images/house_07.jpg",
//       "assets/images/owner.jpg",
//       [
//         "assets/images/kitchen.jpg",
//         "assets/images/bath_room.jpg",
//         "assets/images/swimming_pool.jpg",
//         "assets/images/bed_room.jpg",
//         "assets/images/living_room.jpg",
//       ],
//     ),
//     Property(
//       "RENT",
//       "Simone House",
//       "3,900.00",
//       "Florida",
//       "3,700",
//       "4.4",
//       "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
//       "assets/images/house_08.jpg",
//       "assets/images/owner.jpg",
//       [
//         "assets/images/kitchen.jpg",
//         "assets/images/bath_room.jpg",
//         "assets/images/swimming_pool.jpg",
//         "assets/images/bed_room.jpg",
//         "assets/images/living_room.jpg",
//       ],
//     ),
//   ];
// }

Future<List<PropertyModel>> getPropertyListFromFirebase() async {
  List<PropertyModel> list = [];
  await FirebaseFirestore.instance
      .collection('Property')
      .get()
      .then((querySnapshot) {
    for (var result in querySnapshot.docs) {
      list.add(PropertyModel.fromJson(result.data()));
    }
  });
  return list;
}
Future<List<DocumentSnapshot>> getPropertySnapshotsListFromFirebase() async {
  List<DocumentSnapshot> list = [];
  await FirebaseFirestore.instance
      .collection('Property')
      .get()
      .then((querySnapshot) {
    for (var result in querySnapshot.docs) {
      list.add(result);
    }
  });
  return list;
}