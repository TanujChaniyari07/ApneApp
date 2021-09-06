import 'package:apneapp/src/pages/hof.dart';
import 'package:apneapp/src/pages/chat.dart';
import 'package:apneapp/src/pages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:apneapp/src/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './index.dart';
import 'package:apneapp/src/pages/bottomNavBar.dart';
import 'package:apneapp/src/pages/login.dart';
import 'package:apneapp/src/pages/onBoarding.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:floating_pullup_card/floating_pullup_card.dart';
import 'package:share/share.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flip_card/flip_card.dart';
//import 'package:apne_app/src/pages/index.dart';
class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final ScrollController listScrollController = ScrollController();
  bool _rememberMe = false;
  var error1 = 0;
  int _limit = 20;
  int _limitIncrement = 20;
  bool isLoading = false;
  int counter = 1;
  final _auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
 CollectionReference users = FirebaseFirestore.instance.collection("Users");
 CollectionReference vc = FirebaseFirestore.instance.collection("VC");
 CollectionReference msgs = FirebaseFirestore.instance.collection("messages");
final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmpasswordController = TextEditingController();
String name;
User result = FirebaseAuth.instance.currentUser;
  String text = "Hey, I got featured in the Hall of Fame page of ApneApp by helping more than 5 people. Check out the app on Google play store and App store.";
  String subject = "ApneApp";
 String id;
 String peerid1;
 String groupChatId1;
  share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    Share.share(text,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
 
 String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Email is empty';
    } 
    else if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
 if (value.isEmpty) {
   error1 = 1;
      return 'Password is empty';
    } 
   
    
    else {
      
      return null;
    }
  }

  Widget _buildEmailTF() {

    
  

    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
   
      
   
StreamBuilder(
      stream: users.doc(result.uid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        String nam = userDocument["name"];
        int noh2 = userDocument["noofhelps"];
        if(noh2 < 5)
        {
        return 
      Row( 
        children: <Widget>[
           SizedBox(width: 6,), 
           Icon(Icons.person, color: Colors.lightBlue,),
           SizedBox(width: 6,),  
        Text('Name : $nam', style: kOnBoardingHeadingStyle3,
        
        ),
        ],
);
      }
       else 
       {
               return 
      Row( 
        children: <Widget>[
           SizedBox(width: 6,), 
           Icon(Icons.person, color: Colors.lightBlue,),
           SizedBox(width: 6,),  
        Text('Name : $nam ', style: kOnBoardingHeadingStyle3,
        
        ),
        
        Icon(Icons.verified, color: Colors.amber, size: 21,),
        ],
);  
       } 
      }
  ),
       
    
        
      ],
    );
  }

  Widget _buildPasswordTF() {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
           Align(
      alignment: Alignment.centerLeft,
      child: Container(
        color: Colors.red,
        child: Text(
          "",
        ),
      ),
    ),
      


  StreamBuilder(
      stream: users.doc(result.uid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        String emai = userDocument["email"];
        return 
      Row( 
        children: <Widget>[
           SizedBox(width: 6,), 
           Icon(Icons.email, color: Colors.lightBlue,),
           SizedBox(width: 6,), 
           
        Text('Email : ', style: kOnBoardingHeadingStyle3,),
        Text('$emai', style: kOnBoardingHeadingStyle3,),
       
        ],
);
        
      }
  ),
    
        
    
        
      ],
    );
  }
  Widget _buildPasswordTF1() {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
           Align(
      alignment: Alignment.centerLeft,
      child: Container(
        color: Colors.red,
        child: Text(
          "",
        ),
      ),
    ),
    

  StreamBuilder(
      stream: users.doc(result.uid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
       var userDocument = snapshot.data;
        int noh = userDocument["noofhelps"];
        return 
      Row( 
        children: <Widget>[
           SizedBox(width: 6,),  
           Icon(Icons.videocam, color: Colors.lightBlue,),
           SizedBox(width: 6,), 
        Text('No. of people helped : $noh', style: kOnBoardingHeadingStyle3,),
        ],
);
        
      }
  ),
        
    
        
      ],
    );
  }
   Widget _buildPasswordTF2() {
     return Column(
       
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
           Align(
      alignment: Alignment.centerLeft,
      child: Container(
        color: Colors.red,
        child: Text(
          "",
        ),
      ),
    ),
       

  StreamBuilder(
      stream: users.doc(result.uid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
       var userDocument = snapshot.data;

        double rat = userDocument["rating"];
        String step2 = rat.toStringAsFixed(2); 
        double rat1 = double.parse(step2);
        return 
      Row( 
        children: <Widget>[
           SizedBox(width: 6,),  
           Icon(Icons.star, color: Colors.lightBlue,),
           SizedBox(width: 6,), 
        Text('Rating : $rat1\/5', style: kOnBoardingHeadingStyle3,),
        ],
);
        
      }
  ),
     
        
    
        
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
            
                           Fluttertoast.showToast(
                    
        msg: 'Successfully Logged out',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 16.0
    );
              FirebaseAuth.instance
                  .signOut()
                  .then((result) =>
                      Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => LoginScreen())
          ))
                  .catchError((err) => print(err));
           
                  
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: 
        Row(
          
          children: <Widget>[
           SizedBox(width: 110,),  
        Text(
          'Logout',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
          
        ),
        SizedBox(width: 10,),
        Icon(Icons.logout, color: Color(0xFF527DAA),),
          ],
      ),
     
      ),
    );

     
  }

  // Widget _buildSignInWithText() {
  //   return Column(
  //     children: <Widget>[
  //       Text(
  //         '- OR -',
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       SizedBox(height: 20.0),
  //       Text(
  //         'Sign in with',
  //         style: kLabelStyle,
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildSocialBtn(Function onTap, AssetImage logo) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       height: 60.0,
  //       width: 60.0,
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.white,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black26,
  //             offset: Offset(0, 2),
  //             blurRadius: 6.0,
  //           ),
  //         ],
  //         image: DecorationImage(
  //           image: logo,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildSocialBtnRow() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 30.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         _buildSocialBtn(
  //           () => print('Login with Facebook'),
  //           AssetImage(
  //             'assets/logos/facebook.jpg',
  //           ),
  //         ),
  //         _buildSocialBtn(
  //           () => print('Login with Google'),
  //           AssetImage(
  //             'assets/logos/google.jpg',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => SignUpScreen())
          );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
   Widget _buildName() {
     _nameController.text = result.displayName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row( 
        children: <Widget>[
           SizedBox(width: 7,), 
        Text(
          'Name',
          style: kLabelStyle1,
        ),
      ],
    ),
        SizedBox(height: 10.0),
       TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
              validator: (value) {
                 if (value.isEmpty) {
      return 'Name is empty';
    } 
                     else  if (value.length < 3) {
                        return "Please enter a valid name.";
                      }
                    },
            style: TextStyle(
              color: Colors.lightBlue,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
             
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.lightBlue,
              ),
              hintText: 'Edit your Name',
              hintStyle: kHintTextStyle1,
            ),
          ),
          
        
      ],
    );
  }
    Widget _buildEmail() {
      _emailController.text = result.email;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
  Row( 
        children: <Widget>[
          SizedBox(width: 7,), 
        Text(
          'Email',
          style: kLabelStyle1,
        ),
      ],
    ),
        SizedBox(height: 10.0),
       TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: emailValidator,
            style: TextStyle(
              color: Colors.lightBlue,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
             
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.lightBlue,
              ),
              hintText: 'Edit your Email',
              hintStyle: kHintTextStyle1,
            ),
          
        ),
      ],
    );
  }
 Widget _buildEditBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 50),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
      
         result.updateEmail(_emailController.text).then((value6) => 
         {
           users
    .doc(result.uid)
      .update({
        'email': _emailController.text, 
        
        
      }).then((value) => 
      {
                    Fluttertoast.showToast(
                    
        msg: 'Profile updated',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    ),
      }
      ),
   
     
                                    
         }
         );
         result.updateProfile(displayName: _nameController.text).then((value7) =>
                {
           users
    .doc(result.uid)
      .update({
        'name': _nameController.text, 
        
        
      })
          
         });     
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        color: Colors.lightBlue,
        child: 
        Row(
          
          children: <Widget>[
           SizedBox(width: 65,),  
           Icon(Icons.edit, color: Colors.white,),
        
        SizedBox(width: 4,),
       
         Text(
          'Edit',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
         ),
          ],
      ),
     
      ),
    );

     
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            // List
            Container(
               height: double.infinity,
                width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue[300],
                      Colors.blue[400],
                      Colors.blue[500],
                      Colors.blue[600],
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
            ),
            FlipCard(front: 
            Container(
                
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 100.0,
                  ),
              child: 
              
              Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Connected Helpers',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       SizedBox(
                        height: 60.0,
                     ),
              StreamBuilder<QuerySnapshot>(
                stream: vc.where('Helpee', isEqualTo: result.uid).where('Done_helper', isEqualTo: 1).where('Done_helpee', isEqualTo: 1).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ),
                    );
                  } else {
                    return 
                    
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) => buildItem(context, snapshot.data.docs[index]),
                      itemCount: snapshot.data.docs.length,
                      controller: listScrollController,
                    );
                    
                  }
                },
              ),
          ],
            ),
            ),
            ),
            back:       Container(
                
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 100.0,
                  ),
              child: 
              
              Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Connected Helpees',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       SizedBox(
                        height: 60.0,
                     ),
              StreamBuilder<QuerySnapshot>(
                stream: vc.where('Helper', isEqualTo: result.uid).where('Done_helper', isEqualTo: 1).where('Done_helpee', isEqualTo: 1).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ),
                    );
                  } else {
                    return 
                    
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) => buildItem1(context, snapshot.data.docs[index]),
                      itemCount: snapshot.data.docs.length,
                      controller: listScrollController,
                    );
                    
                  }
                },
              ),
          ],
            ),
            ),
            ),
      ),
            // Loading
            Positioned(
              child: Container(),
            )
          ],
        ),
      
    );
  }
    Widget buildItem(BuildContext context, DocumentSnapshot document) {
          id = result.uid;
          peerid1 =  document.data()['Helper'];         
    if (id.hashCode <= peerid1.hashCode) {
      groupChatId1 = '$id-$peerid1';
    } else {
      groupChatId1 = '$peerid1-$id';
    }



      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
               new Stack(
            children: <Widget>[
              Material(
                child: Icon(
                        Icons.chat,
                        size: 50.0,
                        color: Colors.lightBlue,
                      ),
                      
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
                counter != 0 ? new Positioned(
                right: 0,
                bottom: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: 
                        StreamBuilder<QuerySnapshot>(
                stream:
                
                 msgs.doc(groupChatId1).collection(groupChatId1).where("read", isEqualTo : 0).where("idTo", isEqualTo: result.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return    Text(
                    "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  );
                  } else {
                    counter = snapshot.data.size;
                    return 
                    
                   Text(
                    '$counter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  );
                    
                  }
                },
              ),
               
                ),
              ) : new Container()
                ],
          ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                    
                      Container(
                        child: 
                        
                        StreamBuilder(
      stream: users.doc(peerid1).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("");
        }
        var userDocument = snapshot.data;
        String nam = userDocument["name"];
        int noh2 = userDocument["noofhelps"];
        if(noh2 < 5)
        {
        return 
      Row( 
        children: <Widget>[
          
        Text('Name : $nam', style: kLabelStyle1,
        
        ),
        ],
);
      }
       else if (noh2 >=5 && noh2<=10) 
       {
               return 
      Row( 
        children: <Widget>[
          
        Text('Name : $nam ', style: kLabelStyle1,
        
        ),
        
        Icon(Icons.verified, color: Color(0xFF941701), size: 17,),
        ],
);  
       } 
           else if (noh2 >10 && noh2<=15) 
       {
               return 
      Row( 
        children: <Widget>[
       
        Text('Name : $nam ', style: kLabelStyle1,
        
        ),
        
        Icon(Icons.verified, color: Color(0xFF918989), size: 17,),
        ],
);  
       } 
             else 
       {
               return 
      Row( 
        children: <Widget>[
           
        Text('Name : $nam ', style: kLabelStyle1,
        
        ),
        
        Icon(Icons.verified, color: Colors.amber, size: 17,),
        ],
);  
       } 
      }
  ),
                        
                       
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                    ],
                  ),
                      Container(
                        child: Text(
                          'Category :  ${document.data()['Category']}',
                          style: kLabelStyle1,
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'Language :  ${document.data()['Language']}',
                          style: kLabelStyle1,
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'Date / Time :  ${
                      DateFormat('dd MMM (kk:mm)')
                          .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document.data()['timestamp'])))
                      
                    }',
                          style: kLabelStyle1,
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chat(
                         peerId: document.data()['Helper'],
                         peerAvatar: 'a',
                         helperhelpee : 'helpee',
                         cat: document.data()['Category'],
                         lang: document.data()['Language'],
                        )));
          },
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    
  }
      Widget buildItem1(BuildContext context, DocumentSnapshot document) {
   
         id = result.uid;
          peerid1 =  document.data()['Helpee'];         
    if (id.hashCode <= peerid1.hashCode) {
      groupChatId1 = '$id-$peerid1';
    } else {
      groupChatId1 = '$peerid1-$id';
    }



      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
               new Stack(
            children: <Widget>[
              Material(
                child: Icon(
                        Icons.chat,
                        size: 50.0,
                        color: Colors.lightBlue,
                      ),
                      
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                clipBehavior: Clip.hardEdge,
              ),
                counter != 0 ? new Positioned(
                right: 0,
                bottom: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: 
                        StreamBuilder<QuerySnapshot>(
                stream:
                
                 msgs.doc(groupChatId1).collection(groupChatId1).where("read", isEqualTo : 0).where("idTo", isEqualTo: result.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return    Text(
                    "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  );
                  } else {
                    counter = snapshot.data.size;
                    return 
                    
                   Text(
                    '$counter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  );
                    
                  }
                },
              ),
               
                ),
              ) : new Container()
                ],
          ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                    
                      Container(
                        child: 
                        
                        StreamBuilder(
      stream: users.doc(peerid1).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("");
        }
        var userDocument = snapshot.data;
        String nam = userDocument["name"];
        int noh2 = userDocument["noofhelps"];
        if(noh2 < 5)
        {
        return 
      Row( 
        children: <Widget>[
          
        Text('Name : $nam', style: kLabelStyle1,
        
        ),
        ],
);
      }
       else if (noh2 >=5 && noh2<=10) 
       {
               return 
      Row( 
        children: <Widget>[
          
        Text('Name : $nam ', style: kLabelStyle1,
        
        ),
        
        Icon(Icons.verified, color: Color(0xFF941701), size: 17,),
        ],
);  
       } 
           else if (noh2 >10 && noh2<=15) 
       {
               return 
      Row( 
        children: <Widget>[
       
        Text('Name : $nam ', style: kLabelStyle1,
        
        ),
        
        Icon(Icons.verified, color: Color(0xFF918989), size: 17,),
        ],
);  
       } 
             else 
       {
               return 
      Row( 
        children: <Widget>[
           
        Text('Name : $nam ', style: kLabelStyle1,
        
        ),
        
        Icon(Icons.verified, color: Colors.amber, size: 17,),
        ],
);  
       } 
      }
  ),
                        
                       
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                    ],
                  ),
                      Container(
                        child: Text(
                          'Category :  ${document.data()['Category']}',
                          style: kLabelStyle1,
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'Language :  ${document.data()['Language']}',
                          style: kLabelStyle1,
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'Date / Time :  ${
                      DateFormat('dd MMM (kk:mm)')
                          .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document.data()['timestamp'])))
                      
                    }',
                          style: kLabelStyle1,
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chat(
                         peerId: document.data()['Helpee'],
                         peerAvatar: 'a',
                         helperhelpee : 'helper',
                         cat: document.data()['Category'],
                         lang: document.data()['Language'],
                        )));
          },
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    
  }
}