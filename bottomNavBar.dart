

import 'package:apneapp/src/pages/history.dart';
import 'package:apneapp/src/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'index.dart';
import 'profile.dart';
import 'hof.dart';
 
class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreen createState() => _BottomNavBarScreen();
}

class _BottomNavBarScreen extends State<BottomNavBarScreen> {
  
  var padding = EdgeInsets.symmetric(horizontal: 18,vertical: 5);
  double gap =10;
  int _index = 0;
   List<Color> colors = [
    Colors.white,
    Colors.blue[300],
    Colors.blue[300],
    Colors.blue[300],
    
  ];
   List<Widget> text = [
    
    IndexPage(),
    HistoryScreen(),
    HOFScreen(),
    ProfileScreen(),
  ];
 
  PageController controller = PageController();
   

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        body: PageView.builder(
          itemCount: 4,
            controller: controller,
            onPageChanged: (page){
              setState(() {
                _index= page;
              });
            },  
          itemBuilder:(context , position){
          return Container(
        
             color: colors[position],
             child:Center(child: text[position]),
          );
        }),
        
        bottomNavigationBar: SafeArea(
          child: Flexible(
                      child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: -10,
                      blurRadius: 60,
                      color: Colors.black.withOpacity(0.4),
                      offset: Offset(0,25),
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 7),
                child: GNav(
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(milliseconds: 500),
                  
                  tabs: [
                    GButton(
                      gap: gap,
                      icon: LineIcons.home,
                      iconColor: Colors.black,
                      iconActiveColor: Colors.purple,
                      text: 'Home',
                      textColor: Colors.purple,
                      backgroundColor: Colors.purple.withOpacity(0.2),
                      iconSize: 24,
                      padding: padding,
                    ),
                    GButton(
                      gap: gap,
                      icon: LineIcons.history,
                      iconColor: Colors.black,
                      iconActiveColor: Colors.pink,
                      text: 'History',
                      textColor: Colors.pink,
                      backgroundColor: Colors.pink.withOpacity(0.2),
                      iconSize: 24,
                      padding: padding,
                    ),
                    GButton(
                      gap: gap,
                      icon: LineIcons.gift,
                      iconColor: Colors.black,
                      iconActiveColor: Colors.blue,
                      text: 'Hall of Fame',
                      textColor: Colors.blue,
                      backgroundColor: Colors.blue.withOpacity(0.2),
                      iconSize: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 5),
                    ),
                    GButton(
                      gap: gap,
                      icon: LineIcons.user,
                      iconColor: Colors.black,
                      iconActiveColor: Colors.teal,
                      text: 'Account',
                      textColor: Colors.teal,
                      backgroundColor: Colors.teal.withOpacity(0.2),
                      iconSize: 24,
                      padding: padding,
                    ),
                  ],
                                  selectedIndex: _index,
                  onTabChange: (index){
                    setState(() {
                      _index =index;
                    });
                    controller.jumpToPage(index);
                  },
                ),
               ),
              ),
          ),
          ),
        ),

    );
  }
}