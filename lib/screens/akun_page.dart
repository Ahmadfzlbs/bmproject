import 'package:bmproject/model/session.dart';
import 'package:bmproject/page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../page/all_page.dart';
import 'login_page.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({Key? key}) : super(key: key);

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  late String imageUrl;

  int _pilihNavbar = 0;

  // uploadImage() async {
  //   final _firebaseStorage = FirebaseStorage.instance;
  //   final _imagePicker = ImagePicker();
  //   PickedFile? image;
  //   //Check Permissions
  //   await Permission.photos.request();
  //
  //   var permissionStatus = await Permission.photos.status;
  //
  //   if (permissionStatus.isGranted){
  //     //Select Image
  //     image = await _imagePicker.getImage(source: ImageSource.gallery);
  //     var file = File(image!.path);
  //
  //     if (image != null){
  //       //Upload to Firebase
  //       var snapshot = await _firebaseStorage.ref()
  //           .child('images/imageName')
  //           .putFile(file).onComplete;
  //       var downloadUrl = await snapshot.ref.getDownloadURL();
  //       setState(() {
  //         imageUrl = downloadUrl;
  //       });
  //     } else {
  //       print('No Image Path Received');
  //     }
  //   } else {
  //     print('Permission not granted. Try Again with permission access');
  //   }
  // }
  //
  // void _showPicker(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.photo_library),
  //                     title: new Text('Gallery'),
  //                     onTap: () {
  //                       imgFromGallery();
  //                       Navigator.of(context).pop();
  //                     }),
  //                 new ListTile(
  //                   leading: new Icon(Icons.photo_camera),
  //                   title: new Text('Camera'),
  //                   onTap: () {
  //                     imgFromCamera();
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Profile',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 15),
        children: <Widget>[
          // Column(
          //   children: <Widget>[
          //     SizedBox(
          //       height: 20,
          //     ),
          //     Center(
          //       child: GestureDetector(
          //         onTap: () {
          //           uploadImage();
          //         },
          //         child: CircleAvatar(
          //           radius: 55,
          //           backgroundColor: Color(0xfff1f0ed),
          //           child: (imageUrl != null)
          //             ? Image.network(imageUrl) != null
          //               ? ClipRRect(
          //             borderRadius: BorderRadius.circular(50),
          //             child: Image.file(
          //               imageUrl!,
          //               width: 150,
          //               height: 150,
          //               fit: BoxFit.cover,
          //             ),
          //           )
          //               : Container(
          //             decoration: BoxDecoration(
          //                 color: Colors.grey[200],
          //                 borderRadius: BorderRadius.circular(50)),
          //             width: 100,
          //             height: 100,
          //             child: Icon(
          //               Icons.camera_alt,
          //               color: Colors.grey[800],
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Aktivitas saya',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment_outlined),
            title: Text('Daftar Transaksi'),
            selected: _pilihNavbar == 1,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AllPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_outline),
            title: Text('Wishlist'),
            selected: _pilihNavbar == 2,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
          ListTile(
            leading: Icon(Icons.star_outline),
            title: Text('Ulasan'),
            selected: _pilihNavbar == 3,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
          ListTile(
            leading: Icon(Icons.store_outlined),
            title: Text('Toko yang Di-follow'),
            selected: _pilihNavbar == 4,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Semua Kategori',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category_outlined),
            title: Text('Kategori'),
            selected: _pilihNavbar == 5,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
          ListTile(
            leading: Icon(Icons.attach_money_outlined),
            title: Text('Keuangan'),
            selected: _pilihNavbar == 6,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Pusat Bantuan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.attach_email_outlined),
            title: Text('Kepuasan Pelanggan'),
            selected: _pilihNavbar == 7,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Bantuan Boomeran'),
            selected: _pilihNavbar == 8,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Keluar Aplikasi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Keluar'),
              selected: _pilihNavbar == 9,
              onTap: () {
                logout(context);
              }
          ),
        ],
      ),
    );
  }
}
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  await SessionSet.instant.logout();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context){
        return LoginPage();}
      ), (Route<dynamic> route) => false);
}
