// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bmproject/navigation/appbar.dart';
import 'package:bmproject/page/all_page.dart';
import 'package:bmproject/page/promo_page.dart';
import 'package:bmproject/screens/akun_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

import '../custom/custom_image.dart';
import '../custom/property_item.dart';
import '../custom/recent_item.dart';
import '../custom/recommend_item.dart';
import '../model/data.dart';
import '../theme/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController search = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.deepPurpleAccent,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                CupertinoIcons.person_crop_circle,
                color: Colors.white,
                size: 35,
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AkunPage()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
            ),
          ],
          pinned: true,
          snap: true,
          floating: true,
          title: getHeader(),
        ),
        SliverToBoxAdapter(
            child: getBody()
        )
      ],
    );
  }
  getHeader(){
    return
      Container(
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
      );
  }
  getBody(){
    return
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tempat Terlaris", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                  InkWell(
                    child: Text("Lihat semua", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.deepPurpleAccent),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllPage()));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            listRecommended(),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Banyak resto enak, loh!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                  InkWell(
                    child: Text("Lihat semua", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.deepPurpleAccent),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllPage()));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            listPopulars(),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Spesial untuk kamu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                  InkWell(
                    child: Text("Lihat semua", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.deepPurpleAccent),),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AllPage()));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            listRecent(),
            SizedBox(height: 20,),
          ],
        ),
      );
  }
  listPopulars(){
    return
      CarouselSlider(
          options: CarouselOptions(
            height: 240,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: .8,
          ),
          items: List.generate(populars.length, (index) => PropertyItem(data: populars[index]))
      );
  }

  listRecommended(){
    List<Widget> lists = List.generate(recommended.length,
            (index) => RecommendItem(data: recommended[index])
    );

    return
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 5, left: 15),
        child: Row(
            children: lists
        ),
      );
  }

  listRecent(){
    List<Widget> lists = List.generate(recents.length,
            (index) => RecentItem(data: recents[index])
    );

    return
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(bottom: 5, left: 15),
        child: Row(
            children: lists
        ),
      );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   FirebaseStorage storage = FirebaseStorage.instance;
//
//   // Select and image from the gallery or take a picture with the camera
//   // Then upload to Firebase Storage
//   Future<void> _upload(String inputSource) async {
//     final picker = ImagePicker();
//     XFile? pickedImage;
//     try {
//       pickedImage = await picker.pickImage(
//           source: inputSource == 'camera'
//               ? ImageSource.camera
//               : ImageSource.gallery,
//           maxWidth: 1920);
//
//       final String fileName = path.basename(pickedImage!.path);
//       File imageFile = File(pickedImage.path);
//
//       try {
//         // Uploading the selected image with some custom meta data
//         await storage.ref(fileName).putFile(
//             imageFile,
//             SettableMetadata(customMetadata: {
//               'uploaded_by': 'Ahmad',
//               'description': 'Some description...'
//             }));
//
//         // Refresh the UI
//         setState(() {});
//       } on FirebaseException catch (error) {
//         if (kDebugMode) {
//           print(error);
//         }
//       }
//     } catch (err) {
//       if (kDebugMode) {
//         print(err);
//       }
//     }
//   }
//
//   // Retriew the uploaded images
//   // This function is called when the app launches for the first time or when an image is uploaded or deleted
//   Future<List<Map<String, dynamic>>> _loadImages() async {
//     List<Map<String, dynamic>> files = [];
//
//     final ListResult result = await storage.ref().list();
//     final List<Reference> allFiles = result.items;
//
//     await Future.forEach<Reference>(allFiles, (file) async {
//       final String fileUrl = await file.getDownloadURL();
//       final FullMetadata fileMeta = await file.getMetadata();
//       files.add({
//         "url": fileUrl,
//         "path": file.bucket,
//         "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
//         "description":
//         fileMeta.customMetadata?['description'] ?? 'No description'
//       });
//     });
//
//     return files;
//   }
//
//   // Delete the selected image
//   // This function is called when a trash icon is pressed
//   Future<void> _delete(String ref) async {
//     await storage.ref(ref).delete();
//     // Rebuild the UI
//     setState(() {});
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(50), child: CustomAppBar()),
//       body: Padding(
//         padding: const EdgeInsets.all(5),
//         child: Column(
//           children: <Widget>[
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //   children: [
//             //     ElevatedButton.icon(
//             //         onPressed: () => _upload('camera'),
//             //         icon: const Icon(Icons.camera),
//             //         label: const Text('Camera')),
//             //     ElevatedButton.icon(
//             //         onPressed: () => _upload('gallery'),
//             //         icon: const Icon(Icons.library_add),
//             //         label: const Text('Gallery')),
//             //   ],
//             // ),
//             SizedBox(height: 20,),
//             Container(
//               margin: EdgeInsets.only(left: 15, right: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Tempat Terlaris", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
//                   Text("Lihat semua", style: TextStyle(fontSize: 14, color: Colors.deepPurpleAccent),),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder(
//                 future: _loadImages(),
//                 builder: (context,
//                     AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return ListView.builder(
//                       itemCount: snapshot.data?.length ?? 0,
//                       itemBuilder: (context, index) {
//                         final Map<String, dynamic> image =
//                         snapshot.data![index];
//
//                         return Card(
//                           margin: const EdgeInsets.all(10),
//                           child: SingleChildScrollView(
//                             child: Material(
//                               child: Container(
//                                 height: 300,
//                                 width: 350,
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                       width: 350,
//                                       height: 220,
//                                       child: Card(
//                                         color: Colors.transparent,
//                                         elevation: 0.0,
//                                         child: InkWell(
//                                           // onTap: (() => Navigator.push(
//                                           //     context,
//                                           //     MaterialPageRoute(
//                                           //       builder: (context) =>
//                                           //           DetailPage(selectedHouse: houses[index]),
//                                           //     ))),
//                                           child: ClipRRect(
//                                             borderRadius: BorderRadius.circular(10),
//                                             child: Image.network(image['url'],
//                                                 fit: BoxFit.cover),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding:
//                                       const EdgeInsets.only(left: 30.0, right: 8.0, top: 10.0),
//                                       child: Column(
//                                         children: [
//                                           SizedBox(
//                                             width: 350,
//                                             height: 20,
//                                             child: Text(image['uploaded_by'],
//                                                 style:TextStyle(
//                                                   fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w600,
//                                                   fontSize: 18
//                                                 )
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 5,
//                                           ),
//                                           Padding(
//                                             padding:
//                                             const EdgeInsets.only(left: 10.0, right: 4.0, top: 8.0),
//                                             child: Column(
//                                               children: [
//                                                 SizedBox(
//                                                   width: 350,
//                                                   height: 24,
//                                                   child:Text(image['uploaded_by'],
//                                                       style:TextStyle(
//                                                           fontFamily: 'Inter',
//                                                           fontSize: 15
//                                                       )
//                                                     ),
//                                                   ),
//                                                 SizedBox(
//                                                   height: 5,
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }