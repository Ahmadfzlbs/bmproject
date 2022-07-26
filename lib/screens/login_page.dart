import 'dart:convert';

import 'package:bmproject/model/session.dart';
import 'package:bmproject/navigation/bottomnavbar.dart';
import 'package:bmproject/screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // form key
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  // boolean
  bool _isHidePassword = true;
  bool isloading = true;

  void _togglePassword(){
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: true,
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

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.deepPurpleAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Masuk",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          )
      ),
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
                        )
                    ),
                    SizedBox(height: 35),
                    emailField,
                    SizedBox(height: 15),
                    passwordField,
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Belum punya akun? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context){
                                    return SignUpScreen();}
                                  ), (Route<dynamic> route) => false);
                            },
                            child: Text(
                              "Daftar dulu",
                              style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid){
              String dataBatch = jsonEncode({
                'email': uid.user!.email,
              });
              SessionSet.instant.setSession("user", dataBatch);
          Fluttertoast.showToast(msg: "Selamat datang di Boomeran",
          toastLength: Toast.LENGTH_LONG);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context){
                    return BottomNavBar();}
                  ), (Route<dynamic> route) => false);
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
            errorMessage = "Terlalu banyak permintaan";
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
}