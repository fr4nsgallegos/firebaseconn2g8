import 'dart:async';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 5));
    return "Esta es la data";
  }

  StreamController<String> streamController = StreamController.broadcast();

  @override
  void initState() {
    print("creando stream controller");

    //primera subscripcion
    streamController.stream.listen((data) {
      print("data recibida $data");
    }, onDone: () {
      print("Doneeee");
    });

    //segunda suscripcion
    streamController.stream.listen((data) {
      print("data recibidda 2: $data");
    });

    streamController.add("testeo de data");
    print("finish");
    // TODO: implement initState
    super.initState();
  }

  // @override
  // void initState() {
  //   print("Creando un stream controller");
  //   streamController.stream.listen(
  //     (data) {
  //       print("Data recibida: $data");
  //     },
  //     onDone: () => print("Doneeeee "),
  //   );
  //   // TODO: implement initState

  //   streamController.add("Este es el evento de String");
  //   print("Finishhh");
  //   super.initState();
  // }

  @override
  void dispose() {
    streamController.close();
    // TODO: implement dispose
    super.dispose();
  }
  // @override
  // void initState() {
  //   print("inicio de stream");
  //   Stream<String> myStream = Stream.fromFuture(getData());
  //   print("Stream creado");
  //   myStream.listen((data) {
  //     print("la data es: $data");
  //   }, onDone: () {
  //     print("Task Done");
  //   });
  //   print("FINISH");
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
