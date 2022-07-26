import 'package:bmproject/navigation/bottomnavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth/auth_login.dart';
import '../page/home_page.dart';
import 'login_page.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();
  String nama = '';
  String number = '';
  String email = '';
  String status = '';
  String password = '';

  bool _isHidePassword = true;
  bool isloading = false;

  void _togglePassword(){
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    // final namaField = TextFormField(
    //     autofocus: true,
    //     keyboardType: TextInputType.name,
    //     validator: (value) {
    //       if (value!.isEmpty) {
    //         return ("Masukan nama anda");
    //       }
    //       return null;
    //     },
    //     onSaved: (value) {
    //       emailController.text = value!;
    //     },
    //     textInputAction: TextInputAction.next,
    //     decoration: InputDecoration(
    //       focusedBorder: OutlineInputBorder(
    //         borderSide: BorderSide (color: Colors.deepPurpleAccent),
    //       ),
    //       focusColor: Colors.deepPurpleAccent,
    //       prefixIcon: Icon(
    //         Icons.person,
    //         color: Colors.deepPurpleAccent,
    //       ),
    //       prefixStyle: TextStyle(
    //           decorationColor: Colors.deepPurpleAccent,
    //           color: Colors.black, fontWeight: FontWeight.w500),
    //       labelText: "Nama",
    //       hintText: "Nama",
    //       hintStyle: TextStyle(
    //           color: Colors.black, fontWeight: FontWeight.w200),
    //       labelStyle: TextStyle(
    //           color: Colors.black, fontWeight: FontWeight.w500),
    //       contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     )
    // );

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Masukan email anda");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[gmail]+.[com]")
              .hasMatch(value)) {
            return ("Masukan email yang valid");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide (color: Colors.deepPurpleAccent),
          ),
          focusColor: Colors.deepPurpleAccent,
          prefixIcon: Icon(
            Icons.mail,
            color: Colors.deepPurpleAccent,
          ),
          prefixStyle: TextStyle(
              decorationColor: Colors.deepPurpleAccent,
              color: Colors.black, fontWeight: FontWeight.w500),
          labelText: "Email",
          hintText: "Email",
          hintStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w200),
          labelStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: _isHidePassword,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{8,}$');
          if (value!.isEmpty) {
            return ("Masukan kata sandi anda");
          }
          if (!regex.hasMatch(value)) {
            return ("Masukan kata sandi (Minimal 8 karakter)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide (color: Colors.deepPurpleAccent),
          ),
          suffixIcon: GestureDetector(
            onTap: (){
              _togglePassword();
            },
            child: Icon(
              _isHidePassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: _isHidePassword ? Colors.grey : Colors.deepPurpleAccent,
            ),
          ),
          focusColor: Colors.deepPurpleAccent,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.deepPurpleAccent,
          ), prefixStyle: TextStyle(
            decorationColor: Colors.deepPurpleAccent,
            color: Colors.black, fontWeight: FontWeight.w500),
          labelText: "Kata sandi",
          hintText: "Kata sandi",
          hintStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w200),
          labelStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    final confirmField = TextFormField(
        autofocus: false,
        controller: confirmController,
        obscureText: _isHidePassword,
        validator: (value)
        {
          if (confirmController.text.length >6 && passwordController.text != value)
          {
            return "Kata sandi harus sama";
          }
        },
        onSaved: (value) {
          confirmController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide (color: Colors.deepPurpleAccent),
          ),
          suffixIcon: GestureDetector(
            onTap: (){
              _togglePassword();
            },
            child: Icon(
              _isHidePassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: _isHidePassword ? Colors.grey : Colors.deepPurpleAccent,
            ),
          ),
          focusColor: Colors.deepPurpleAccent,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.deepPurpleAccent,
          ), prefixStyle: TextStyle(
            decorationColor: Colors.deepPurpleAccent,
            color: Colors.black, fontWeight: FontWeight.w500),
          labelText: "Konfirmasi Kata sandi",
          hintText: "Konfirmasi Kata sandi",
          hintStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w200),
          labelStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.deepPurpleAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailController.text, passwordController.text);
          },
          child: Text(
            "Daftar",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 250,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.contain,
                        )),
                    SizedBox(height: 35),
                    SizedBox(height: 15),
                    emailField,
                    SizedBox(height: 15),
                    passwordField,
                    SizedBox(height: 15),
                    confirmField,
                    SizedBox(height: 35),
                    signupButton,
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Sudah punya akun? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context){
                                    return LoginPage();}
                                  ), (Route<dynamic> route) => false);
                            },
                            child: Text(
                              "Masuk",
                              style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Email tidak terdaftar";
            break;
          case "wrong-password":
            errorMessage = "Kata Sandi anda salah";
            break;
          case "user-not-found":
            errorMessage = "Pengguna dengan email ini tidak ada";
            break;
          case "user-disabled":
            errorMessage = "Pengguna dengan email ini telah dinonaktifkan.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Masuk dengan Email dan Kata Sandi tidak diaktifkan.";
            break;
          default:
            errorMessage = "Tidak ada koneksi internet";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.password = passwordController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Selamat datang di Book Ma");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => BottomNavBar()),
            (route) => false);
  }
}
