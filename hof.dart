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
//import 'package:apne_app/src/pages/index.dart';
class HOFScreen extends StatefulWidget {
  @override
  _HOFScreenState createState() => _HOFScreenState();
}

class _HOFScreenState extends State<HOFScreen> {
  
  bool _rememberMe = false;
  var error1 = 0;
  final _auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
 CollectionReference users = FirebaseFirestore.instance.collection("Users");

 
final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmpasswordController = TextEditingController();
String name;
User result = FirebaseAuth.instance.currentUser;
  String text = "Hey, I got featured in the Hall of Fame page of ApneApp by helping more than 5 people. Check out the app on Google play store and App store.";
  String subject = "ApneApp";
 
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
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
              Container(
                
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 100.0,
                  ),
                  child: Form(
                    key: _formKey1,

  
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                Text(
                        'Hall Of Fame',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  
                  
                      SizedBox(height: 60.0),
                   StreamBuilder<QuerySnapshot>(
                        stream: users.where('noofhelps', isGreaterThan: 4).orderBy('noofhelps', descending: true)
                           
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                          {
                            return Text(
                                 '');
                          }
                          List<DocumentSnapshot> docs = snapshot.data.docs;
List<Map<String, String>> l = [];
String abc;
int i = 0;
          docs.forEach((element) {
             double rat = element.data()['rating'];
        String step2 = rat.toStringAsFixed(2); 
        double rat1 = double.parse(step2);
            l.add({"Name" : element.data()['name'],
            "Noofhelps" : element.data()['noofhelps'].toString(),
            "Rating" : rat1.toString()
            });
    abc = element.data()['name'];
          });
  

 return DataTable(
   
      columns: [
        DataColumn(label:   Row( 
        children: <Widget>[
             
           Icon(Icons.person, color: Colors.white,),
           SizedBox(width: 4,), 
        Text('Name', style: TextStyle(
    
    color: Colors.white,
  fontWeight: FontWeight.w900,
  fontSize: 14.0,
  fontFamily: 'OpenSans',
  ),),
        ],
)),
        DataColumn(label: Row( 
        children: <Widget>[
             
           Icon(Icons.videocam, color: Colors.white,),
           SizedBox(width: 4,), 
        Text('Helps', style: TextStyle(
    
    color: Colors.white,
  fontWeight: FontWeight.w900,
  fontSize: 14.0,
  fontFamily: 'OpenSans',
  ),),
        ],
)),
        DataColumn(label: Row( 
        children: <Widget>[
            
           Icon(Icons.star, color: Colors.white,),
           SizedBox(width: 4,), 
        Text('Rating', style: TextStyle(
    
    color: Colors.white,
  fontWeight: FontWeight.w900,
  fontSize: 14.0,
  fontFamily: 'OpenSans',
  ),),
        ],
)),
      ],
      rows:
          l // Loops through dataColumnText, each iteration assigning the value to element
              .map(
                ((element1) => DataRow(
                  
                      cells: <DataCell>[
                        
                        element1["Name"] == result.displayName ? DataCell(Text(element1["Name"], style: TextStyle(
    decoration: TextDecoration.underline,
    color: Colors.white,
  fontWeight: FontWeight.w900,
  fontSize: 12.0,
  fontFamily: 'OpenSans',
  ),
                        
                        )) : DataCell(Text(element1["Name"], style: kOnBoardingHeadingStyle5)),
                        
                        element1["Name"] == result.displayName ? DataCell(Text(element1["Noofhelps"], style: kOnBoardingHeadingStyle5)) : DataCell(Text(element1["Noofhelps"], style: kOnBoardingHeadingStyle5)),
                        element1["Name"] == result.displayName ? DataCell(                             Row( 
        children: <Widget>[
           
           Text(element1["Rating"], style: kOnBoardingHeadingStyle5),
           
           SizedBox(width: 25,),  
        SizedBox(
   height: 18.0,
   width: 18.0,
   child: new IconButton(
      padding: new EdgeInsets.all(0.0),
      color: Colors.white,
      icon: new Icon(Icons.share, size: 18.0),
      onPressed: () {
            
      share(context);
             
                  
        },
   )
),
        ],
)) : DataCell(Text(element1["Rating"], style: kOnBoardingHeadingStyle5)),
 
                      ],
                    )),
              )
              .toList(),
    );

                        
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                     
                      //_buildSignInWithText(),
                      // _buildSocialBtnRow(),

                    ],
                  ),
),
                  
                  
                
                ),
                ),
              
     
            ],
          ),
        ),
        
      ),
      
    );
  }
}