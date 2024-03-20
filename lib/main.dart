import 'package:aspenproject/DatabaseManager/DatabaseManager.dart';
import 'package:aspenproject/Global%20Variables/Variables.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:aspenproject/models/locations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:aspenproject/aspen-splashscreen.dart';
import 'package:aspenproject/location-details.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PagesContainer());
}

class PagesContainer extends StatefulWidget {
  const PagesContainer({super.key});

  @override
  State<PagesContainer> createState() => _PagesContainerState();
}

String location = "Aspen, USA";
int index = 0;

List<TabModel> _tabs = [
  TabModel(title: "Home", view: _HomeScreen()),
  TabModel(title: "Tickets", view: Container()),
  TabModel(title: "Likes", view: Container()),
  TabModel(title: "Profile", view: Container()),
];

class _PagesContainerState extends State<PagesContainer> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(
          title: "Aspen", debugShowCheckedModeBanner: false, home: splashScreen());
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Explore", style: TextStyle(fontSize: 15.sp)),
              Text("Aspen", style: TextStyle(fontSize: 30.sp))
            ]),
        actions: [_customDropDownButton()],
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black),
        toolbarHeight: 10.h,
        elevation: 0,
      ),
      body: _NavBar(),
    );
  }

  Widget _customDropDownButton() {
    return Row(children: [
      Icon(
        Icons.location_on,
        color: Colors.blue.shade400,
        size: 20,
      ),
      DropdownButton<String>(
        underline: Container(color: Colors.white),
        value: location,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.blue.shade400,
        ),
        onChanged: (String? loc) {
          setState(() {
            location = loc!;
            GlobalVariables.id=loc;
            //change global list
          });
        },
        items: const [
          DropdownMenuItem<String>(
            value: "Aspen, USA",
            child: Text("Aspen, USA"),
          ),
          DropdownMenuItem<String>(
              value: "Amman, Jordan", child: Text("Amman, Jordan"))
        ],
      )
    ]);
  }
}

class TabModel {
  String title;
  Widget view;
  Widget? icon;

  TabModel({required this.title, required this.view, this.icon});
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({super.key});

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextInputAction _search = TextInputAction.search;
  final FocusNode _searchFocus = FocusNode();
  String selected = "Locations";
  List _locations = [];
  List _rLocations = [];
  final DatabaseManager _db = DatabaseManager();

  @override
  void initState() {
    _addLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
            width: 90.w,
            child: TextFormField(
              controller: _searchController,
              focusNode: _searchFocus,
              textInputAction: _search,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(20)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                ),
                hintText: "Find things to do",
                fillColor: Colors.grey.shade100,
                filled: true,
              ),
            )),
        SizedBox(
          height: 4.h,
        ),
        SizedBox(
            width: 90.w,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _customRadio("Locations"),
                    _customRadio("Hotels"),
                    _customRadio("Food"),
                    _customRadio("Adventure"),
                    _customRadio("Sea"),
                  ],
                ))),
        SizedBox(
          height: 3.h,
        ),
        Container(
          height: 40.h,
          width: 90.w,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Popular",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade50,
                        onPrimary: Colors.blue.shade400,
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: Text("See all"))
                ],
              ),
              _getListViewBuilder(),
            ],
          ),
        ),
        Container(
          height: 33.h,
          width: 90.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recomended",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              _getListViewBuilderRecommended(),
            ],
          ),
        )
      ]),
    );
  }

  Widget _getListViewBuilder() {
    return Container(
        height: 32.h,
        child: FutureBuilder(
            future: _addLocations(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: SpinKitCircle(
                  color: Colors.blue.shade400,
                ));
              }
              else {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _locations.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _popularLocationCard(_locations[index]);
                    });
              }}));
  }

  Widget _getListViewBuilderRecommended() {
    return Container(
        height: 25.h,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: _rLocations.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _recomendedLocationCard(_rLocations[index]);
            }));
  }

  Widget _customRadio(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selected = text;
          GlobalVariables.type=(text);
        });
      },
      style: ElevatedButton.styleFrom(
          elevation: 0,
          onPrimary:
              selected == text ? Colors.blue.shade400 : Colors.grey.shade300,
          primary: selected == text ? Colors.grey.shade200 : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(text),
    );
  }

  Widget _popularLocationCard(LocationsModel loc) {
    return InkWell(
        onTap: () {
          PersistentNavBarNavigator.pushNewScreen(context,
              screen: LocationDetails(loc: loc), withNavBar: false);
        },
        child: Card(
            elevation: 0,
            color: Colors.grey.shade50,
            child: Stack(children: [
              Container(
                height: 32.h,
                width: 60.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(scale: 12, loc.src))),
              ),
              Positioned(
                top: 170,
                left: 20,
                child: Container(
                    height: 4.h,
                    width: 25.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.shade600),
                    child: Center(
                        child: AutoSizeText(
                      style: TextStyle(color: Colors.white),
                      loc.title,
                      maxFontSize: 20.sp,
                      minFontSize: 10,
                    ))),
              ),
              Positioned(
                  top: 204,
                  left: 20,
                  child: Container(
                    height: 4.h,
                    width: 18.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.shade600),
                    child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text(
                              style: const TextStyle(color: Colors.white),
                              loc.ratings.toString())
                        ])),
                  )),
              Positioned(
                  top: 190,
                  left: 150,
                  child: Container(
                      child: SizedBox(
                          height: 5.h,
                          width: 14.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Image.asset(
                                color: loc.isLiked == false
                                    ? Colors.grey.shade400
                                    : Colors.pink.shade200,
                                'assets/heartIcon.png'),
                            onPressed: () {
                              setState(() {
                                loc.isLiked = !loc.isLiked;
                              });
                            },
                          ))))
            ])));
  }

  Widget _recomendedLocationCard(LocationsModel loc) {
    return Card(
      color: Colors.grey.shade50,
      elevation: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 20.h,
            width: 70.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(loc.src))),
          ),
          Positioned(
              top: 140,
              left: 160,
              child: Container(
                height: 4.h,
                width: 18.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Center(
                    child: Container(
                        width: 15.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green.shade700),
                        child: Center(
                            child: Text(
                          loc.duration,
                          style: const TextStyle(color: Colors.white),
                        )))),
              )),
          Positioned(
              top: 160,
              left: 20,
              child: Text(
                loc.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ))
        ],
      ),
    );
  }

  Future<void> _addLocations() async {
    _rLocations.add(LocationsModel(
        title: "Explore Aspin",
        reviews: 0,
        ratings: 0,
        description: "",
        price: 0,
        id: "Aspen, USA",
        src:
            "https://www.planetware.com/wpimages/2021/11/colorado-aspen-top-attractions-things-to-do-browse-downtown-aspen.jpg",
        type: "",
        duration: "4N/5D",
        isLiked: false));

    _rLocations.add(LocationsModel(
        title: "Luxurious Aspen",
        reviews: 0,
        ratings: 0,
        description: "",
        price: 0,
        id: "Aspen, USA",
        src:
            "https://coveteur.com/media-library/aspen-travel-guide.jpg?id=25424789&width=1245&height=700&quality=90&coordinates=0%2C0%2C0%2C0",
        type: "",
        duration: "4N/5D",
        isLiked: false));

    _locations = await _db.getLocations(
      GlobalVariables.type,
      GlobalVariables.id,
    );
  }
}

class _NavBar extends StatefulWidget {
  const _NavBar({super.key});

  @override
  State<_NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<_NavBar> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _tabs.map((e) => e.view).toList(),
      navBarHeight: 60,
      navBarStyle: NavBarStyle.style6,
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.home,
          ),
          title: "Home",
          activeColorPrimary:
              index == 0 ? Colors.blue.shade400 : Colors.grey.shade400,
        ),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.airplane_ticket),
            title: "Tickets",
            activeColorPrimary:
                index == 1 ? Colors.blue.shade400 : Colors.grey.shade400),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.heart_broken),
            title: "Likes",
            activeColorPrimary:
                index == 2 ? Colors.blue.shade400 : Colors.grey.shade400),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.person),
            title: "Profile",
            activeColorPrimary:
                index == 3 ? Colors.blue.shade400 : Colors.grey.shade400),
      ],
      onItemSelected: (selectedIndex) {
        setState(() {
          index = selectedIndex;
        });
      },
    );
  }
}
