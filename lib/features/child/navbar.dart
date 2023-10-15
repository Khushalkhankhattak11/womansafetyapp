import 'package:flutter/material.dart';
import 'package:safetyapp/features/child/bottom_nav/add_contact/add_contact.dart';
import 'package:safetyapp/features/child/bottom_nav/pages/childchat.dart';
import 'package:safetyapp/features/child/bottom_nav/pages/childcontact.dart';
import 'package:safetyapp/features/child/bottom_nav/pages/childhome.dart';
import 'package:safetyapp/features/child/bottom_nav/pages/childprofile.dart';
import 'package:safetyapp/features/child/bottom_nav/pages/childrating.dart';

class NavBarBottom extends StatefulWidget {
  const NavBarBottom({super.key});

  @override
  State<NavBarBottom> createState() => _NavBarBottomState();
}

class _NavBarBottomState extends State<NavBarBottom> {
  int currentIndex =0;
  List<Widget> pages = [
    const HomeView(),
    const AddContact(),
    const ChildChat(),
    const ChildProfile(),
    const ChildRating(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTaped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.contacts),label: "Contact"),
          BottomNavigationBarItem(icon: Icon(Icons.chat),label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: "Rating"),
        ],
      ),
      body: pages[currentIndex],
    );
  }

  onTaped(int index){
    setState(() {
      currentIndex =index;
    });
  }
}
