import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseconn2g8/pages/list_future_page.dart';
import 'package:firebaseconn2g8/pages/stream_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  CollectionReference usersReference =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  usersReference.get().then((value) {
                    value.docs.forEach((e) {
                      print(e.data());
                    });
                  });
                },
                child: Text("Get data"),
              ),
              ElevatedButton(
                onPressed: () {
                  usersReference
                      .where("nombre", isEqualTo: "Pedro")
                      .where("estatura", isGreaterThan: 175)
                      .get()
                      .then(
                    (value) {
                      QuerySnapshot userCollection = value;
                      List<QueryDocumentSnapshot> docs = userCollection.docs;
                      docs.forEach((e) {
                        print(e.id);
                        print(e.data());
                      });
                    },
                  );
                },
                child: Text("Traer Data FILTRADA"),
              ),
              ElevatedButton(
                onPressed: () {
                  usersReference.add({
                    'nombre': "Pedro",
                    "apellido": "Fernandez",
                    "estatura": 178,
                    "esPeruano": true,
                  }).then((value) {
                    print(value.id);
                  });
                },
                child: Text("Agregar usuario"),
              ),
              ElevatedButton(
                onPressed: () {
                  usersReference.doc("idNoExiste").set(
                    {
                      'nombre': "Javier",
                      "apellido": "Mader",
                      "estatura": 198,
                      "esPeruano": false,
                    },
                  );
                },
                child: Text("Inserción 2"),
              ),
              ElevatedButton(
                onPressed: () {
                  usersReference.doc("idNoExiste").update(
                    {
                      "nombre": "Anastacio",
                    },
                  );
                },
                child: Text("Actualización"),
              ),
              ElevatedButton(
                onPressed: () {
                  usersReference.doc("idNoExiste").delete();
                },
                child: Text("Eliminar"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StreamPage(),
                    ),
                  );
                },
                child: Text("Stream page"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListFuturePage(),
                    ),
                  );
                },
                child: Text("List Future  page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
