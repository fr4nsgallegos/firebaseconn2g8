import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconn2g8/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();
  Widget fieldCuenta(
    String titulo,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 60,
          child: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.08),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        )
      ],
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> login(BuildContext context) async {
    try {
      _auth
          .signInWithEmailAndPassword(
              email: correo.text, password: contrasena.text)
          .then((value) {
        print(value);
        print("inicio sesión");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          behavior: SnackBarBehavior.floating,
          content: Text(
            error.toString(),
          ),
        ),
      );
    }
  }

  Future<User?> singnInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication?.accessToken,
          idToken: googleSignInAuthentication?.idToken);

      User? user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      print(user?.displayName.toString());
      return user;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          behavior: SnackBarBehavior.floating,
          content: Text(
            error.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),

        body: Container(
          padding: EdgeInsets.all(32),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff012f3d),
                Color(0xff0a4f64),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 26,
                ),
                FlutterLogo(
                  size: 200,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Inicia sesión ",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                fieldCuenta("Correo", correo),
                fieldCuenta("Contraseña", contrasena),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      login(context);
                    },
                    child: Text("Iiniciar")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "o inicia sesión con",
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          singnInWithGoogle(context).then((user) {
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }
                          });
                        },
                        icon: Icon(
                          Icons.g_mobiledata,
                          color: Colors.white,
                          size: 40,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
