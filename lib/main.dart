import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
        SizedBox(height: 4.h,),
        SizedBox(width: 90.w,child:SingleChildScrollView(scrollDirection: Axis.horizontal,child:Row(children: [
          _customRadio("Location", 0),
          _customRadio("Hotels", 1),
          _customRadio("Food", 2),
          _customRadio("Adventure", 3),
          _customRadio("Sea", 4),

        ],)))
        ]),
    );
  }

  Widget _customRadio(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selected = index;
        });

      },
      style: ElevatedButton.styleFrom(elevation: 0,
          onPrimary: selected == index
                  ? Colors.blue.shade400
                  : Colors.grey.shade300,
          primary:
              selected == index ? Colors.grey.shade200 : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(text),
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
