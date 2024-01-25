import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,orientation,deviceType){
        return MaterialApp(title: "Aspen",
          debugShowCheckedModeBanner: false,
        home:Scaffold(appBar: AppBar(title:const Column(children:[
          Text("Explore"),
          Text("Aspen")
            ]) ,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color:Colors.black),)
          )
        );
      }
    ) ;
  }
}

