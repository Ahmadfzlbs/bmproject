import 'package:bmproject/page/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom/custom_image.dart';
import '../theme/color.dart';

class AllPage extends StatefulWidget {
  const AllPage({Key? key}) : super(key: key);

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  late final data;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Restoran',
        style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
