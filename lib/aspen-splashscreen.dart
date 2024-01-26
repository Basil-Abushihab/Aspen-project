import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:aspenproject/main.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Container(
                height: 100.h,
                width: 100.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/Aspen-Splash.png"),
                    ))),
            Positioned(
                top: 100,
                left: 70,
                child: Container(
                  height: 13.h,
                  width: 60.w,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/Aspen.png"),
                      )),
                )),
            Positioned(
                top: 65.h,
                left: 14.w,
                child: Container(
                  height: 20.h,
                  width: 60.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Plan your",
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
                      ),
                      Text("Luxurious",
                          style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Text("Vacation",
                          style: TextStyle(
                              fontSize: 30.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                )),
            Positioned(top: 85.h,
                left: 15.w,
                child: Container(height: 7.h,
                    width: 75.w,
                    child: ElevatedButton(style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15))),
                        onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

                        },
                        child: Text("Explore", style: TextStyle(
                            color: Colors.white, fontSize: 15.sp)))))
          ],
        ),
      ),
    );
  }
}
