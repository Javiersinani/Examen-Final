//import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ffi';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Future<List<Comment>> getData() async {
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments"),
        headers: {"Accept": "aplication/json"});
    var data = json.decode(response.body);
    print(data);
    List<Comment> comments = [];
    for (var p in data) {
      Comment comment = Comment(p["name"], p["email"]);
      comments.add(comment);
    }
    print(comments.length);
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Javier App")),
        body: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Cargando..."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int name) {
                    Center(
                      child: Text("Javier Siñani Lijeron"),
                    );
                    Image.asset('assets/1.jpeg');
                    return ListTile(
                      title: Text(snapshot.data[name].email),
                      subtitle: Text(snapshot.data[name].email.toString()),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}

class Comment {
  final String name;
  final String email;

  Comment(this.name, this.email);
}
//Widget build(BuildContext context) {
 //   return Scaffold(
  //      appBar: AppBar(title: Text("Javier App")),
 //       body: Column(
 //         children: <Widget>[
  //          Center(
   //           child: Text("Javier Siñani Lijeron"),
  //          ),
   //         Image.asset('assets/1.jpeg')
  //        ],
  //      ));
 //       
//  }
//}