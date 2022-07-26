import 'package:bmproject/model/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page/menu.dart';

class DetailPage extends StatefulWidget {
  final data;
  final dataId;
  const DetailPage({Key? key, required this.data, this.dataId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
      body: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ]),
                    child: Hero(
                      tag: data["image"],
                      child: Image.network(data["image"],
                        fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Positioned(
                      top: 30,
                      left: 20,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 20),
                child: Text(data["name"],
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(data['description']),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Lokasi',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700,),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.place_outlined, color: Colors.red, size: 13,),
                              SizedBox(width: 3,),
                              Text(data["location"]),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Reviews',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(data["rating"].toString()),
                              Icon(Icons.star,size: 12,color: Colors.deepPurpleAccent,),
                              Icon(Icons.star,size: 12,color: Colors.deepPurpleAccent),
                              Icon(Icons.star,size: 12,color: Colors.deepPurpleAccent),
                              Icon(Icons.star,size: 12,color: Colors.deepPurpleAccent),
                              Icon(Icons.star_half,size: 12,color: Colors.deepPurpleAccent),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,left: 20),
                child: Text('Fasilitas',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0,2.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6
                              )]
                          ),
                          child: Center(
                            child: IconButton(
                              icon: new Icon(
                                CupertinoIcons.car_detailed,
                                size: 25,
                              ),
                              color: Colors.deepPurpleAccent, onPressed: () {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('Parkir',
                          style: TextStyle(
                              color: Colors.deepPurpleAccent
                          ),)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0,2.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6
                              )]
                          ),
                          child: Center(
                            child: IconButton(
                              icon: new Icon(
                                Icons.alt_route,
                                size: 25,
                              ),
                              color: Colors.deepPurpleAccent, onPressed: () {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('Rute',
                          style: TextStyle(
                              color: Colors.deepPurpleAccent
                          ),)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0,2.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6
                              )]
                          ),
                          child: Center(
                            child: IconButton(
                              icon: new Icon(
                                CupertinoIcons.book_solid,
                                size: 25,
                              ),
                              color: Colors.deepPurpleAccent,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => MenuPage(data: menupopulars, dataId: data['id'],)));
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('Menu',
                          style: TextStyle(
                              color: Colors.deepPurpleAccent
                          ),)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0,2.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6
                              )]
                          ),
                          child: Center(
                            child: IconButton(
                              icon: new Icon(
                                CupertinoIcons.wifi,
                                size: 25,
                              ),
                              color: Colors.deepPurpleAccent, onPressed: () {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('WiFi',
                          style: TextStyle(
                              color: Colors.deepPurpleAccent
                          ),)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0,2.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6
                              )]
                          ),
                          child: Center(
                            child: IconButton(
                              icon: new Icon(
                                CupertinoIcons.table_fill,
                                size: 25,
                              ),
                              color: Colors.deepPurpleAccent, onPressed: () {  },
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('Meja',
                          style: TextStyle(
                              color: Colors.deepPurpleAccent
                          ),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
      ),
      bottomNavigationBar: SizedBox(
        height: 73,
        child: BottomAppBar(
          color: Colors.white,
          elevation: 0.0,
          child: FittedBox(
            fit: BoxFit.none,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  _popup(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 6.0),
                  height: 46,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Text(
                    "Pesan Meja Sekarang",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _popup(context) {
  String dropdownValue = 'Satu';
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Pesan Meja",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Nama Lengkap",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Masukan nama anda");
                  }
                  // reg expression for email validation
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  focusColor: Colors.deepPurpleAccent,
                  prefixStyle: TextStyle(
                      decorationColor: Colors.deepPurpleAccent,
                      color: Colors.black, fontWeight: FontWeight.w500),
                  hintText: "Masukan nama lengkap",
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w200),
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Pilih Meja",
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      'Satu',
                      'Dua',
                      'Tiga',
                      'Empat',
                      'Lima',
                      'Enam',
                      'Tujuh',
                      'Delapan',
                      'Sembilan',
                      'Sepuluh'
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                },
              )
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Pilih Tanggal",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Masukan nama anda");
                  }
                  // reg expression for email validation
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  focusColor: Colors.deepPurpleAccent,
                  prefixStyle: TextStyle(
                      decorationColor: Colors.deepPurpleAccent,
                      color: Colors.black, fontWeight: FontWeight.w500),
                  hintText: "Masukan nama lengkap",
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w200),
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            child: MaterialButton(
              color: Colors.deepPurpleAccent,
              child: Text(
                "Pesan Sekarang",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      );
    },
  );
}

void setState(Null Function() param0) {
}
