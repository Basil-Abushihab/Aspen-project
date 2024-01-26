import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LocationDetails extends StatefulWidget {
  const LocationDetails({super.key});

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(children: [
          SizedBox(
            height: 3.h,
          ),
          _locationDescriptionCard()
        ]),
      ),
    );
  }

  Widget _locationDescriptionCard() {
    return Card(
      elevation: 0,
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 45.h,
                width: 90.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/AlleyPalace.png'))),
              ),
              Positioned(
                  top: 2.h,
                  left: 3.w,
                  height: 5.h,
                  width: 15.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {},
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.grey.shade400,
                      ))),
              Positioned(
                  top: 42.h,
                  left: 70.w,
                  height: 5.h,
                  width: 15.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {},
                      child: Image.asset('assets/heartIcon.png')))
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
              height: 6.h,
              width: 95.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coeurdes Alpes",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Colors.grey.shade50),
                      onPressed: () {},
                      child: Text(
                        "Show Map",
                        style: TextStyle(
                            color: Colors.blue.shade400,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )),
          const Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text(" 4.5 "),
              Text("(355 Reviews)")
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
              height: 10.h,
              child: AutoSizeText(
                  minFontSize: 12,
                  maxFontSize: 20.sp,
                  "This romantic castle lies directly on Lake Thun in the midst of a beautiful park. Within its main building, is a museum telling the story of the former owners. A tour of the kitchen and servants' quarters reveals how the castle lords and servants lived during the 19th century.")),
          SizedBox(
            height: 3.h,
          ),
          Container(
              width: 95.w,
              child: Text(
                "Facilities",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              )),
          SizedBox(height: 2.h,),
          
        ],
      ),
    );
  }
}
