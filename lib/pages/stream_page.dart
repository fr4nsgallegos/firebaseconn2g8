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

  @override
  void initState() {
    print("inicio de stream");
    Stream<String> myStream = Stream.fromFuture(getData());
    print("Stream creado");
    myStream.listen((data) {
      print("la data es: $data");
    }, onDone: () {
      print("Task Done");
    });
    print("FINISH");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
