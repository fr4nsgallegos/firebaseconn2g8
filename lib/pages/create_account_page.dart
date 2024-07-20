import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateAccountPage extends StatelessWidget {
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
  Future<void> createAccount() async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: correo.text,
      password: contrasena.text,
    );
    print(userCredential.user);
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
          child: Column(
            children: [
              Text(
                "App de votacioness",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
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
                "Crea una cuenta ",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              fieldCuenta("Correo", correo),
              fieldCuenta("Contraseña", contrasena),
              ElevatedButton(
                  onPressed: () {
                    createAccount();
                  },
                  child: Text("Crear cuenta "))
            ],
          ),
        ),
      ),
    );
  }
}
