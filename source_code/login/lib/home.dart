import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar(
        leading: IconButton(
            onPressed: ()=> Navigator.pop(context),
            icon: Icon(Icons.login_outlined)),
        backgroundColor: HexColor("#091945"),
      ),
      body:Center(child: Text("Welcome to Flutter",style: TextStyle(fontSize: 15,color: HexColor("#091945"),fontWeight: FontWeight.bold)))
    );
  }
}
