import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:aspenproject/models/locations.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String location = "Aspen, USA";
int index = 0;

List<TabModel> _tabs = [
  TabModel(title: "Home", view: _HomeScreen()),
  TabModel(title: "Tickets", view: Container()),
  TabModel(title: "Likes", view: Container()),
  TabModel(title: "Profile", view: Container()),
];

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
              actions: [_customDropDownButton()],
              backgroundColor: Colors.white,
              titleTextStyle: const TextStyle(color: Colors.black),
              toolbarHeight: 10.h,
              elevation: 0,
            ),
            body: _NavBar(),
          ));
    });
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
  int selected = 0;
  List _locations = [];

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
                    _customRadio("Location", 0),
                    _customRadio("Hotels", 1),
                    _customRadio("Food", 2),
                    _customRadio("Adventure", 3),
                    _customRadio("Sea", 4),
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
        )
      ]),
    );
  }

  Widget _getListViewBuilder() {
    return Container(height: 32.h,child:ListView.builder(scrollDirection: Axis.horizontal,
        itemCount: _locations.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _popularLocationCard(_locations[index]);
        }));
  }

  Widget _customRadio(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selected = index;
        });
      },
      style: ElevatedButton.styleFrom(
          elevation: 0,
          onPrimary:
              selected == index ? Colors.blue.shade400 : Colors.grey.shade300,
          primary: selected == index ? Colors.grey.shade200 : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(text),
    );
  }

  Widget _popularLocationCard(LocationsModel loc) {
    return Card(
        elevation: 0,
        color: Colors.grey.shade50,
        child: Stack(children: [
          Container(
            height: 32.h,
            width: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(scale: 12,loc.src))),
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
                    child: Text(
                        style: const TextStyle(color: Colors.white),
                        loc.title)),
              )),
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
        ]));
  }

  void _addLocations() {
    _locations.add(LocationsModel(
        title: "Alley Palace",
        reviews: 355,
        ratings: 4.1,
        description:
            "This romantic castle lies directly on Lake Thun in the midst of a beautiful park. Within its main building, is a museum telling the story of the former owners. A tour of the kitchen and servants' quarters reveals how the castle lords and servants lived during the 19th century.",
        price: 30,
        id: "Aspen, USA",
        src: "https://myswitzerlandvisit.com/wp-content/uploads/2022/05/samuel-ferrara-_wfjeANNuNE-unsplash.jpg",
        type: "Locations"));

    _locations.add(LocationsModel(
        title: "Aspen Highlands Ski Resort",
        reviews: 250,
        ratings: 4.5,
        description:
            "Aspen Highlands is the second largest mountain of the four mountains at Aspen Snowmass, including Buttermilk, Snowmass, and Aspen Mountain. It is known for its expert terrain, including the challenging Highland Bowl, and offers some of the most intense in-bounds skiing in the United States. It also has the best view of the Maroon Bells.",
        price: 199,
        id: "Aspen, USA",
        src:
            "https://s3.amazonaws.com/hines-images/aspen-highlands/Aspen-Highlands-2_hres.jpg",
        type: "Locations"));

    _locations.add(LocationsModel(
        title: "The St. Regis Aspen Resort",
        reviews: 355,
        ratings: 4.1,
        description:
            "This upscale resort hotel is set in a grand redbrick building that's a 3-minute walk from the gondolas of Aspen Mountain and 2 miles from Aspen Golf & Tennis Club.",
        price: 999,
        id: "Aspen, USA",
        src:
            "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/14/76/85/the-beautiful-st-regis.jpg?w=700&h=-1&s=1",
        type: "Hotels"));

    _locations.add(LocationsModel(
        title: "Hotel Jerome, Auberge Resorts Collection",
        reviews: 875,
        ratings: 4.7,
        description:
            "At the foot of Aspen Mountain and a 7-minute walk from Downtown, this refined, stately hotel in a circa 1889 redbrick property is 3 miles from Buttermilk ski resort.",
        price: 1099,
        id: "Aspen, USA",
        src:
            "https://lh3.googleusercontent.com/p/AF1QipOxiJ2L7FmmPaRddTrgcJoHXN6Eb-KeRO9kf6aD=s680-w680-h510",
        type: "Hotels"));
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
