import 'package:flutter/material.dart';
import 'package:prawitama_care_admin/common/utils.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: buttonColor,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(
            icon: Icon(Icons.request_page_sharp), label: 'Donasi'),
        BottomNavigationBarItem(
            icon: Icon(Icons.domain_verification_outlined), label: 'Laporan'),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Hubungi Kami'),
      ],
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
        // Navigator.pushNamed(context, routeList[index]);
      },
    );
  }
}
