import 'package:apneapp/src/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'login.dart';

final String bullet = "\u2022";
final pages = [
        Material(
          color: Colors.blue[700],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Image.asset('assets/logos/logo.png'),
              ),
              Text(
                'Welcome to ApneApp!',
                style: kOnBoardingHeadingStyle,
                textAlign: TextAlign.center,

              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Swipe left to get started',
                style: kOnBoardingSubHeadingStyle,
                textAlign: TextAlign.center,
              ),

            ],
            
          ),

        ),
        Material(
          color: Color(0xFF6CA8F1),
          child: SafeArea(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50.0,
                ),
                Text(
                    'Want to help \n  someone?',
                    style: kOnBoardingSuperHeadingStyle,
                    textAlign: TextAlign.start,
                    
                  ),
                
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: <Widget>[
                    Text(
                      '→ Treat the other individual with respect.',
                      style: kOnBoardingHeadingStyle,
                      textAlign: TextAlign.justify,
                      

                    ),
                    Text(
                      '→ Your account will get banned if you have a lot of reports.',
                      style: kOnBoardingHeadingStyle,
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '→ If possible, Switch to a better network connection if your internet speed is less than 0.5 Mb/s.',
                      style: kOnBoardingHeadingStyle,
                      textAlign: TextAlign.justify,
                    ),
                      ],
                    ),
                  ),
                ),

              ],
              
            ),
          ),
          ),
        Material(
          color: Color(0xFF6CA8F1),
          child: SafeArea(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50.0,
                ),
                Text(
                    'Need help ?',
                    style: kOnBoardingSuperHeadingStyle,
                    textAlign: TextAlign.start,
                    
                  ),
                
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: <Widget>[
                    Text(
                      '→ Try to request a call from an isolated room with decent illumination if possible.',
                      style: kOnBoardingHeadingStyle,
                      textAlign: TextAlign.justify,

                    ),
                    Text(
                      '→ Keep your device steady so that the helper can get a better view of the situation.',
                      style: kOnBoardingHeadingStyle,
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      '→ Explain the problem briefly and show the available tools to helper at the start of the call to help them to better help you.',
                      style: kOnBoardingHeadingStyle,
                      textAlign: TextAlign.justify,
                    ),
                      ],
                    ),
                  ),
                ),

              ],
              
            ),
          ),
          ),
        LoginScreen(),
];

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LiquidSwipe(
      pages:pages,
      enableSlideIcon: true,
      enableLoop: false,
      );
  }
}