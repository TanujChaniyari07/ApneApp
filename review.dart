import 'package:apneapp/src/pages/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:apneapp/src/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './index.dart';
import 'package:apneapp/src/pages/bottomNavBar.dart';

//import 'package:apne_app/src/pages/index.dart';
class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool _rememberMe = false;
  final _auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
 CollectionReference users = FirebaseFirestore.instance.collection("Users");
  CollectionReference vc = FirebaseFirestore.instance.collection("VC");
  User result = FirebaseAuth.instance.currentUser;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmpasswordController = TextEditingController();
var rating = 0.0;
double val = 0.0;
int rep = 1;
int rep1 = 0;


  // Widget _buildEmailTF() {
  //   return Center(
  //           child: SmoothStarRating(
  //         rating: rating,
  //         isReadOnly: false,
  //         size: 80,
  //         filledIconData: Icons.star,
  //         halfFilledIconData: Icons.star_half,
  //         defaultIconData: Icons.star_border,
  //         color: Colors.white,
  //         borderColor: Colors.white,
  //         starCount: 5,
  //         allowHalfRating: true,
  //         spacing: 2.0,
  //         onRated: (value) {
  //           print("rating value -> $value");
  //           // print("rating value dd -> ${value.truncate()}");
  //         },
  //       ));
  // }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: <Widget>[
        
        SmoothStarRating(
          rating: rating,
          isReadOnly: false,
          size: 40,
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_half,
          defaultIconData: Icons.star_border,
          color: Colors.amber,
          borderColor: Colors.white,
          starCount: 5,
          allowHalfRating: true,
          spacing: 2.0,
          
          onRated: (value) {
            val = value;
            // print("rating value dd -> ${value.truncate()}");
          },
        )
        
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
     padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 38),
      width: double.infinity,
     
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
                  rep = rep + 1;
                  if(rep.isEven)
                  {
rep1 = 1;
                  }
                  else
                  {
rep1 = 0;
                  }
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Report the Helper',
            style: kOnBoardingSubHeadingStyle,
            
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      width: double.infinity,
      child:
      
       RaisedButton(
        elevation: 5.0,
        onPressed: () {
if(val == 0.0)
{
               Fluttertoast.showToast(
                    
        msg: 'Please provide the rating for the helper',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    ); 
}
          else {
            vc
    
    .where("Helpee", isEqualTo : result.uid).where("Done_helpee", isEqualTo : 0)
    .get()
    .then((querySnapshot)   {
    querySnapshot.docs.forEach((result1)  {
 
users.where("uid", isEqualTo : result1["Helper"])
    .get()
    .then((querySnapshot1)   {
    querySnapshot1.docs.forEach((result2)  {

users
    .doc(result2.id)
      .update({
        'totalrating': result2["totalrating"] + val, 
        'noofhelps': result2["noofhelps"] + 1, 
        'rating': (val + result2["totalrating"]) / (result2["noofhelps"] + 1), 
        'noofreports': rep1 + result2["noofreports"],  
      });

     });
  });
    vc
    .doc(result1.id)
      .update({
        'Done_helpee': 1, 
        'Helpee Name' : "Disconnected",
      });

    
     
      });
  });
          
                       Fluttertoast.showToast(
                    
        msg: 'Thank you for rating!',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 16.0
    );
            Navigator.pop(context);
            Navigator.pop(context);
        }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Submit',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
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
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
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
                    horizontal: 40.0,
                    vertical: 215.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     Text(
                        'Rate the Helper',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      // _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                     
                     _buildRememberMeCheckbox(),
                      
                      _buildLoginBtn(),
                      //_buildSignInWithText(),
                      // _buildSocialBtnRow(),
                      
                    ],
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