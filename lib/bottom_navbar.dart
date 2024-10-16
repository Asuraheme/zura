import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_estate/search.dart';
import 'package:real_estate/setings/setup.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedindex = 0;
  late final List<Widget> pages;
  @override
  void initState() {
    // TODO: implement initState
    pages = [
      const Search(),
      navBarIem(Iconsax.home5),
      navBarIem(Iconsax.heart5),
      navBarIem(Iconsax.message5),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        iconSize: 25,
        currentIndex: selectedindex,
        onTap: (value) {
          setState(() {
            selectedindex = value;
          });
        },
        selectedItemColor: primerycolor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          color: primerycolor,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(selectedindex == 0 ? Iconsax.home5 : Iconsax.home_1),
            label: "Residential",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedindex == 1 ? Iconsax.home : Iconsax.home_1),
            label: "office",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedindex == 2 ? Iconsax.heart5 : Iconsax.heart),
            label: "Favoite",
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedindex == 3 ? Iconsax.message5 : Iconsax.message),
            label: "Messages",
          ),
        ],
      ),
      body: pages[selectedindex],
    );
  }

  navBarIem(icaonName) {
    return Center(
      child: Icon(
        icaonName,
        size: 100,
        color: primerycolor,
      ),
    );
  }
}
