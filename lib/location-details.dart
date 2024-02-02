import 'package:aspenproject/models/locations.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LocationDetails extends StatefulWidget {
  const LocationDetails({super.key, required this.loc});

  final LocationsModel loc;

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
    bool isLiked = widget.loc.isLiked;
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
                        fit: BoxFit.fill, image: NetworkImage(widget.loc.src))),
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
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
                      onPressed: () {
                        setState(() {
                          widget.loc.isLiked = !widget.loc.isLiked;
                        });
                      },
                      child: Image.asset(
                        'assets/heartIcon.png',
                        color: widget.loc.isLiked == false
                            ? Colors.grey.shade400
                            : Colors.pink.shade200,
                      )))
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
              height: 6.h,
              width: 95.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Expanded(child:
                  AutoSizeText(
                    minFontSize: 10,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.loc.title,
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  )),
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
          SizedBox(
              width: 87.w,
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade700,
                    size: 18,
                  ),
                  Text(" ${widget.loc.ratings.toString()} "),
                  Text("(${widget.loc.reviews})")
                ],
              )),
          SizedBox(
            height: 1.h,
          ),
          Container(
              height: 12.h,
              width: 85.w,
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: ReadMoreText(
                    widget.loc.description,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Read More ",
                    trimExpandedText: " Read Less ",
                    lessStyle: TextStyle(color: Colors.blue.shade300),
                    moreStyle: TextStyle(color: Colors.blue.shade300),
                    style: TextStyle(fontSize: 12.sp),
                    trimLines: 4,
                  ))),
          Container(
              width: 95.w,
              child: Text(
                "Facilities",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              )),
          SizedBox(
            height: 1.h,
          ),
          Container(
              height: 10.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _getFacilities("assets/Heater.png", "Heater"),
                  _getFacilities("assets/Cutlery.png", "Dinner"),
                  _getFacilities("assets/Tub.png", "Tub"),
                  _getFacilities("assets/Pool.png", "Pool"),
                ],
              )),
          SizedBox(
            height: 10.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 7.h,
                  width: 20.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      Expanded(child:AutoSizeText(minFontSize: 10.sp,
                        "  \$${widget.loc.price}",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.greenAccent.shade200,
                            fontWeight: FontWeight.bold),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                    height: 7.h,
                    width: 60.w,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Stack(clipBehavior: Clip.none, children: [
                          Text(
                            "Book Now",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Positioned(
                              left: 20.w,
                              top: -0.7.h,
                              child: const Icon(
                                Icons.arrow_right_outlined,
                                size: 30,
                              )),
                        ])))
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _getFacilities(String src, String Name) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.grey.shade100),
    width: 20.w,
    height: 9.h,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(src, width: 9.w, color: Colors.grey.shade400),
        SizedBox(
          height: 1.h,
        ),
        Text(
          Name,
          style: TextStyle(color: Colors.grey.shade400, fontSize: 8.sp),
        )
      ],
    ),
  );
}
