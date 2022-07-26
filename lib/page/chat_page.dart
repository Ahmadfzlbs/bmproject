import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  TextEditingController _searchController = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: ListView(
              children: [
                Text(
                  " Pesan",
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFFe9eaec),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    cursorColor: Color(0xFF000000),
                    controller: _searchController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF000000).withOpacity(0.5),
                        ),
                        hintText: "Cari Toko",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _stories(),
              ],
            ),
          )
      ),
    );
  }
}
List storyList = [
  {
    "name": "Darmaga Sunda",
    "imageUrl": "https://4.bp.blogspot.com/-Z087_jJe-LA/Ws7YibwhzcI/AAAAAAAABX4/EIreHZxiML8QSg9YsFLYs1eTGU0hvcJMACLcBGAs/s1600/1.jpg",
    "isOnline": true,
    "hasStory": true,
  },
  {
    "name": "Woody Kitchen",
    "imageUrl": "https://media-cdn.tripadvisor.com/media/photo-s/1a/c4/0f/a2/photo3jpg.jpg",
    "isOnline": false,
    "hasStory": false,
  },
  {
    "name": "Up Normal",
    "imageUrl": "https://koropak.co.id/storage/img/cover/warunk-upnormal.JPG",
    "isOnline": true,
    "hasStory": false,
  },
  {
    "name": "Saung Ranggon",
    "imageUrl": "https://3.bp.blogspot.com/-uFiQjk_wUfA/XNC3dOeNarI/AAAAAAAALRc/J7R3H7wxCdYUVPY0QYj813HCmtKbqe2MwCLcBGAs/s640/Rumah%2BMakan%2BKhas%2BSunda%2BSaung%2BRanggon%2BTasik.jpg",
    "isOnline": true,
    "hasStory": true,
  },
  {
    "name": "Giggle Box",
    "imageUrl": "https://4.bp.blogspot.com/--29SdbMLvg0/WJc_625ljOI/AAAAAAAAN0I/LGj9FM8qog8fheaO2IKQiAT-SQmMstpBgCLcB/s1600/IMG_7903%255B1%255D.JPG",
    "isOnline": true,
    "hasStory": true,
  }
];
_stories() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Column(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFe9eaec)),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 33,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 75,
                child: Align(
                    child: Text(
                      'Tambah Pesan',
                      overflow: TextOverflow.ellipsis,
                    )
                ),
              ),
              // InkWell(
              //   onTap: (){
              //
              //   },
              // ),
            ],
          ),
        ),
        Row(
            children: List.generate(storyList.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      child: Stack(
                        children: <Widget>[
                          storyList[index]['hasStory']
                              ? Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.blueAccent, width: 3)),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            storyList[index]['imageUrl']),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          )
                              : Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        storyList[index]['imageUrl']),
                                    fit: BoxFit.cover)),
                          ),
                          storyList[index]['isOnline']
                              ? Positioned(
                            top: 38,
                            left: 42,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Color(0xFF66BB6A),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(0xFFFFFFFF), width: 3)),
                            ),
                          )
                              : Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 75,
                      child: Align(
                          child: Text(
                            storyList[index]['name'],
                            overflow: TextOverflow.ellipsis,
                          )),
                    )
                  ],
                ),
              );
            }))
      ],
    ),
  );
}
