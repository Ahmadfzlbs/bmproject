import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page/home_page.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController search = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50.0,
      elevation: 0.0,
      title:
      Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          cursorColor: Color(0xFF000000),
          controller: search,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: "Cari tempat makan...",
            border: InputBorder.none,
          ),
        ),
      ),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(
            CupertinoIcons.person_crop_circle,
            color: Colors.white,
            size: 35,
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
        ),
      ],
      backgroundColor: Colors.deepPurpleAccent,
    );
  }
}
