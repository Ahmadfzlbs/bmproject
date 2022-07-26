import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom/custom_image.dart';
import '../theme/color.dart';

class MenuPage extends StatefulWidget {
  final data;
  final dataId;
  const MenuPage( {Key? key, this.dataId, required this.data}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Map<String, dynamic> data = {};

  @override
  void initState(){
    var dataGet = widget.data.indexWhere((value) => value['id'] == widget.dataId);
    print(dataGet);
    data = widget.data[dataGet];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Menu",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child:  Container(
          width: 3000,
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              CustomImage(data["image"],
                radius: 20,
                width: 130,
              ),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data["nama"], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3,),
                        Expanded(child: Text(data["harga"], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12,),)),
                      ],
                    ),SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.deepPurpleAccent, size: 13,),
                        SizedBox(width: 5,),
                        Text(data["rating"], style: TextStyle(fontSize: 13, color: darker, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
