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

String location = "Aspen, USA";

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          title: "Aspen",
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              appBar: AppBar(
            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Explore", style: TextStyle(fontSize: 15.sp)),
                  Text("Aspen", style: TextStyle(fontSize: 30.sp))
                ]),
            actions: [
              _customDropDownButton(),
            ],
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black),
            toolbarHeight: 10.h,
            elevation: 0,
          )));
    });
  }

  Widget _customDropDownButton() {
    return Row(children:[Icon(Icons.location_on,color: Colors.blue.shade400,size: 20,),DropdownButton<String>(
        padding: const EdgeInsets.symmetric(vertical: 20),
        value: location,
        icon: const Icon(Icons.arrow_drop_down),
        onChanged: (String? loc) {
          setState(() {
            location = loc!;
          });
        },
        items: const [
          DropdownMenuItem<String>(
            child: Text("Aspen, USA"),
            value: "Aspen, USA",
          ),
          DropdownMenuItem<String>(
              child: Text("Amman, Jordan"), value: "Amman, Jordan")
        ],
      )
    ]
    );
  }
}
