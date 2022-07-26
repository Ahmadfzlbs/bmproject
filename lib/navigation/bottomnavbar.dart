import 'package:bmproject/page/chat_page.dart';
import 'package:bmproject/page/promo_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmproject/page/home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  final List<Widget> screens = <Widget>[
    HomePage(),
    HomePage(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/homeicon2.png"),
                size: 24,
              ),
              label: 'Beranda',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(CupertinoIcons.bag),
            //   label: 'Promo',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              label: 'Pesanan',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/chaticon2.png"),
              ),
              label: 'chat',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurpleAccent,
          unselectedItemColor: Colors.black,
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}
