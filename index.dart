import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:permission_handler/permission_handler.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
import 'package:internet_speed_test/callbacks_enum.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apneapp/src/utilities/constants.dart';
import './call.dart';
import './call1.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;
  var ranchan = new Random();
  var ranchan1 = new Random();
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
 CollectionReference vc = FirebaseFirestore.instance.collection("VC");
  CollectionReference info = FirebaseFirestore.instance.collection("Info");
 CollectionReference users = FirebaseFirestore.instance.collection("Users");
  ClientRole _role = ClientRole.Broadcaster;
  String idd;
  final TextEditingController _descController = TextEditingController();
  User result = FirebaseAuth.instance.currentUser;
  final internetSpeedTest = InternetSpeedTest();

  double downloadRate = 0;

  String downloadProgress = '0';
  int a = 1;
int check = 0;
int check1 = 0;
  String unitText = 'Kb/s';
  

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }
String _selected;
String _selected1;
_displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Write a short description about the problem.'),
            content: TextField(
              controller: _descController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Enter the description"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  
                },
              )
            ],
          );
        });
  }
  List<Map> _myJson = [
    {"id": 'cooking',  "name": "Cooking"},
    {"id": 'fixing_furniture',  "name": "Fixing Furniture"},
    {"id": 'basic_plumbing',  "name": "Basic Plumbing"},
    {"id": 'household_chore',  "name": "Household Chore"},
    {
      "id": 'fitness',
     
      "name": "Fitness"
    },
    {"id": 'school_work',  "name": "School Work"},
    {
      "id": 'gadget_use',
      
      "name": "Gadget Use"
    },
    {
      "id": 'basic_electronic_repair',
      
      "name": "Basic Electronic Repair"
    },
    
  ];
    List<Map> _myJson1 = [
    {"id": 'english',  "name": "English"},
    {"id": 'hindi',  "name": "Hindi (हिंदी)"},
    {"id": 'marathi',  "name": "Marathi (मराठी)"},
    {"id": 'sindhi',  "name": "Sindhi (सिन्धी)"},
    {
      "id": 'gujrati',
     
      "name": "Gujrati (ગુજરાતી)"
    },
    {"id": 'punjabi',  "name": "Punjabi (ਪੰਜਾਬੀ)"},
    {
      "id": 'tamil',
      
      "name": "Tamil (தமிழ்)"
    },
     {
      "id": 'telegu',
      
      "name": "Telegu (తెలుగు)"
    },
     {
      "id": 'kannada',
      
      "name": "Kannada (ಕನ್ನಡ)"
    },
     {
      "id": 'malayalam',
      
      "name": "Malayalam (മലയാളം)"
    },
    {
      "id": 'bengali',
      
      "name": "Bengali (বাংলা)"
    },
    {
      "id": 'haryanvi',
      
      "name": "Haryanvi (हरियाणवी)"
    },
    {
      "id": 'bhojpuri',
      
      "name": "Bhojpuri (𑂦𑂷𑂔𑂣𑂳𑂩𑂲)"
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body:
      
      
       Stack(
        
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
       Padding(
 padding:
                const EdgeInsets.only(left:100, top:100),

                 child: Text(
          'Join a Video Call',
          style: kOnBoardingHeadingStyle,
        ),
                 
      ),
      Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
           
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
            Text(
          'Category & Language',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle1,
          height: 60.0,
           child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      
                      isDense: true,
                      icon: Icon(Icons.keyboard_arrow_down, ),
                      dropdownColor: Colors.blue[300],
                      hint:
                      Padding(
 padding:
                const EdgeInsets.only(left: 100, right: 100),
                     child: new Text("Select Category",
                           style: new TextStyle(
                  color: Colors.white,
                  
                  
                )
                      ),
                      ),
                      value: _selected,
                      
                      onChanged: (String newValue) {
                        
                        setState(() {
                          _selected = newValue;
                          
                        });

                        print(_selected);
                      },
                      items: _myJson.map((Map map) {
                        return new DropdownMenuItem<String>(
                          
                          value: map["id"].toString(),
                          // value: _mySelection,
                          child: Row(
                            children: <Widget>[
                              
                              Container(
                                  margin: EdgeInsets.only(left: 15),
                                  
                                  child: Text(map["name"],
                                  
                                   style: new TextStyle(
                  color: Colors.white,
                  
                )
                                  )
                                  
                                  ),
                                  
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    )
        ),
              // Column(
              //   children: [
              //   //   ListTile(
              //   //     title: Text(ClientRole.Audience.toString()),
              //   //     leading: Radio(
              //   //       value: ClientRole.Audience,
              //   //       groupValue: _role,
              //   //       onChanged: (ClientRole value) {
              //   //         setState(() {
              //   //           _role = value;
              //   //         });
              //   //       },
              //   //     ),
              //   //   )
              //   // ],
      Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child:        
         
       
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle1,
          height: 60.0,
          
           child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      
                      isDense: true,
                      icon: Icon(Icons.keyboard_arrow_down, ),
                      dropdownColor: Colors.blue[300],
                      hint:
                      Padding(
 padding:
                const EdgeInsets.only(left: 100, right: 100),
                     child: new Text("Select Language",
                           style: new TextStyle(
                  color: Colors.white,
                  
                  
                )
                      ),
                      ),
                      value: _selected1,
                      
                      onChanged: (String newValue) {
                        
                        setState(() {
                          _selected1 = newValue;
                          
                        });

                        print(_selected1);
                      },
                      items: _myJson1.map((Map map) {
                        return new DropdownMenuItem<String>(
                          value: map["id"].toString(),
                          // value: _mySelection,
                          child: Row(
                            children: <Widget>[
                              
                              Container(
                                  margin: EdgeInsets.only(left: 15),
                                 
                                       child: Text(map["name"],
                                  
                                   style: new TextStyle(
                  color: Colors.white,
                  
                ),
                                  ),
                                  
                               
                                  
                                  ),
                                  
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    )
        ),
        
          ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
                       onPressed: onJoin,
                        child: Text('Helper Join'),
                        color: Colors.white,
                        textColor: Colors.blue[300],
                        
                      ),
                    )
                  ],
                ),
              ),
               Padding(
               padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
                       onPressed: 
                       
                       onJoin1,
  
                        child: Text('Helpee Join'),
                        color: Colors.white,
                        textColor: Colors.blue[300],
                        
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
          ],
    ),
    );
  }

  Future<void> onJoin() async {
users.where("uid", isEqualTo : result.uid)
    .get()
    .then((querySnapshot2)   {
    querySnapshot2.docs.forEach((result3)  {
int nor = result3["noofreports"];
if(nor >= 5)
{
                Fluttertoast.showToast(
                    
        msg: 'Account banned due to multiple reports',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
}

    else{
    if(check == 0)
    {
              Fluttertoast.showToast(
                    
        msg: 'We are checking your Internet Speed. Please wait...',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
 int min = 13, max = 30000;
 int r = min + ranchan.nextInt(max - min);  
 int r1 = min + ranchan1.nextInt(max - min);  
 int r2 = r + r1;
 vc
    
    .where("Helper", isEqualTo : "Null").where("Category", isEqualTo : _selected).where("Language", isEqualTo : _selected1).where("Done_helpee", isEqualTo : 0).where("Done_helper", isEqualTo : 0)
    .get()
    .then((querySnapshot)   {
      if(querySnapshot.docs.isEmpty)
      {
        
       _channelController.text = r2.toString(); 
            users.where("uid", isEqualTo: result.uid).get().then((querySnapshot5) {
       
     
       querySnapshot5.docs.forEach((result5)  {
      
       String nam =  result5["name"];  
       double rat = result5["rating"]; 
       int noh = result5["noofhelps"]; 
       int nohh = 0;   
           vc.add(
           {
            
            
            'Helpee' : "Null",
            'Helper' : result.uid,
            'Category' : _selected,
            'Language' : _selected1,
            'Channel' : _channelController.text,
            'Done_helper' : 0,
            'Done_helpee' : 0,
            'Helper Name' : nam,
            'Helper Rating' : rat,
            'Helper NOH' : noh,
            'Helpee Name' : "Finding",
            'Helpee NOH' : nohh,
            'Helpername' : nam,
            'Helpeename' : "Null",
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
           }
            
            ).then((value5) => idd = value5.id);               
                        
     });
  });  
     
              if (_channelController.text.isNotEmpty) {
                check = check + 1;
      
      // await for camera and mic permissions before pushing video page
      for(int i =0; i<5; i++)
      {
                  Fluttertoast.showToast(
                    
        msg: 'We are checking your Internet Speed. Please wait...',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
      internetSpeedTest.startDownloadTesting(
                    onDone: (double transferRate, SpeedUnit unit) {
                      print('the transfer rate $transferRate');
                      if(transferRate>=0.5)
                      {
    Fluttertoast.showToast(
        msg: 'Your internet speed is $transferRate Mb/s. You should not face any problems during the video call.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    
                 _handleCameraAndMic();
      // push video page with given channel name
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
            idd: idd,
          ),
        ),
      );
                      }
                      else{
 Fluttertoast.showToast(
        msg: 'Your internet speed is $transferRate Mb/s. Switching to a better network is recommended.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
   
                      
                      }
                      setState(() {
                        downloadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        downloadProgress = '100';
           
                      }
                      
                      );
                      
                    },
                    onProgress:
                        (double percent, double transferRate, SpeedUnit unit) {
          
                     
                      setState(() {
                        downloadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        downloadProgress = percent.toStringAsFixed(2);
                      });
                    },
                    onError: (String errorMessage, String speedTestError) {
                      print(
                          'the errorMessage $errorMessage, the speedTestError $speedTestError');
                    },
                    
                    
                  );

   
    }
      }
      else{

    querySnapshot.docs.forEach((result1)  {
     
    idd = result1.id;
_channelController.text = result1["Channel"];
users.where("uid", isEqualTo: result.uid).get().then((querySnapshot5) {
       
     
       querySnapshot5.docs.forEach((result5)  {
      
       String nam =  result5["name"];  
       double rat = result5["rating"]; 
       int noh = result5["noofhelps"]; 
      
vc
    .doc(result1.id)
      .update({
        'Helper': result.uid, 
        'Helpername' : nam,
      });
    });
      });



      });
        if (_channelController.text.isNotEmpty) {
      check = check + 1;
      // await for camera and mic permissions before pushing video page
      for(int i =0; i<5; i++)
      {
                  Fluttertoast.showToast(
                    
        msg: 'We are checking your Internet Speed. Please wait...',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
      internetSpeedTest.startDownloadTesting(
                    onDone: (double transferRate, SpeedUnit unit) {
                          querySnapshot.docs.forEach((result1)  {
     
    

users.where("uid", isEqualTo: result.uid).get().then((querySnapshot5) {
       
     
       querySnapshot5.docs.forEach((result5)  {
      
       String nam =  result5["name"];  
       double rat = result5["rating"]; 
       int noh = result5["noofhelps"]; 
      
vc
    .doc(result1.id)
      .update({
        'Helpername' : nam,
        'Helper Name' : nam,
        'Helper NOH' : noh,
        'Helper Rating' : rat,
      });
    });
      });



      });
                      print('the transfer rate $transferRate');
                      if(transferRate>=0.5)
                      {
    Fluttertoast.showToast(
        msg: 'Your internet speed is $transferRate Mb/s. You should not face any problems during the video call.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    
                 _handleCameraAndMic();
      // push video page with given channel name
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
            idd: idd,
          ),
        ),
      );
                      }
                      else{
 Fluttertoast.showToast(
        msg: 'Your internet speed is $transferRate Mb/s. Switching to a better network is recommended.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
   
                      
                      }
                      setState(() {
                        downloadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        downloadProgress = '100';
           
                      }
                      
                      );
                      
                    },
                    onProgress:
                        (double percent, double transferRate, SpeedUnit unit) {
          
                     
                      setState(() {
                        downloadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        downloadProgress = percent.toStringAsFixed(2);
                      });
                    },
                    onError: (String errorMessage, String speedTestError) {
                      print(
                          'the errorMessage $errorMessage, the speedTestError $speedTestError');
                    },
                    
                    
                  );

   
    }
      }
  });
         
    // update input validation
    
  }
    });
  });  
  }
  Future<void> onJoin1() async {
    users.where("uid", isEqualTo : result.uid)
    .get()
    .then((querySnapshot2)   {
    querySnapshot2.docs.forEach((result3)  {
int nor = result3["noofreports"];
if(nor >= 5)
{
                Fluttertoast.showToast(
                    
        msg: 'Account banned due to multiple reports',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
}
    else{
if(check1 == 0)
    {
              Fluttertoast.showToast(
                    
        msg: 'We are checking your Internet Speed. Please wait...',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
 int min = 13, max = 30000;
 int r = min + ranchan.nextInt(max - min);  
 int r1 = min + ranchan1.nextInt(max - min);  
 int r2 = r + r1;
 vc
    
    .where("Helpee", isEqualTo : "Null").where("Category", isEqualTo : _selected).where("Language", isEqualTo : _selected1).where("Done_helper", isEqualTo : 0).where("Done_helpee", isEqualTo : 0)
    .get()
    .then((querySnapshot)   {
      if(querySnapshot.docs.isEmpty)
      {
       _channelController.text = r2.toString(); 
        users.where("uid", isEqualTo: result.uid).get().then((querySnapshot5) {
       
     
       querySnapshot5.docs.forEach((result5)  {
      
       String nam =  result5["name"];  
       double rat = 0.0; 
       int noh = result5["noofhelps"]; 
       int nohh = 0; 
         vc.add(
           {
            
            
            'Helpee' : result.uid,
            'Helper' : "Null",
            'Category' : _selected,
            'Language' : _selected1,
            'Channel' : _channelController.text,
            'Done_helper' : 0,
            'Done_helpee' : 0,
            'Helpee Name' : nam,
            'Helper Rating' : rat,
            'Helpee NOH' : noh,
            'Helper Name' : "Finding",
            'Helper NOH' : nohh,
            'Helpeename' : nam,
            'Helpername' : "Null",
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
           }
            
            ).then((value5) => idd = value5.id); 
      });
    });
              if (_channelController.text.isNotEmpty) {
                check1 = check1 + 1;
      
      // await for camera and mic permissions before pushing video page
      for(int i =0; i<5; i++)
      {
                  Fluttertoast.showToast(
                    
        msg: 'We are checking your Internet Speed. Please wait...',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
      internetSpeedTest.startDownloadTesting(
                    onDone: (double transferRate, SpeedUnit unit) {
                      print('the transfer rate $transferRate');
                      if(transferRate>=0.5)
                      {
    Fluttertoast.showToast(
        msg: 'Your internet speed is $transferRate Mb/s. You should not face any problems during the video call.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    
                 _handleCameraAndMic();
      // push video page with given channel name
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage1(
            channelName: _channelController.text,
            role: _role,
            idd: idd,
          ),
        ),
      );
                      }
                      else{
 Fluttertoast.showToast(
        msg: 'Your internet speed is $transferRate Mb/s. Switching to a better network is recommended.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
   
                      
                      }
                      setState(() {
                        downloadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        downloadProgress = '100';
           
                      }
                      
                      );
                      
                    },
                    onProgress:
                        (double percent, double transferRate, SpeedUnit unit) {
          
                     
                      setState(() {
                        downloadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        downloadProgress = percent.toStringAsFixed(2);
                      });
                    },
                    onError: (String errorMessage, String speedTestError) {
                      print(
                          'the errorMessage $errorMessage, the speedTestError $speedTestError');
                    },
                    
                    
                  );

   
    }
      }
      else{

    querySnapshot.docs.forEach((result1)  {
     
    idd = result1.id;
_channelController.text = result1["Channel"];
     users.where("uid", isEqualTo: result.uid).get().then((querySnapshot5) {
       
     
       querySnapshot5.docs.forEach((result5)  {
      
       String nam =  result5["name"];  
       int noh = result5["noofhelps"]; 
       
vc
    .doc(result1.id)
      .update({
        'Helpee': result.uid, 
        'Helpeename' : nam,
      });
     
      });
      });
    });
        if (_channelController.text.isNotEmpty) {
      check1 = check1 + 1;
      // await for camera and mic permissions before pushing video page
      for(int i =0; i<5; i++)
      {
                  Fluttertoast.showToast(
                    
        msg: 'We are checking your Internet Speed. Please wait...',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.blue[200],
        textColor: Colors.white,
        fontSize: 16.0
    );
      }
      internetSpeedTest.startDownloadTesting(
                    onDone: (double transferRate, SpeedUnit unit) {
                      
    querySnapshot.docs.forEach((result1)  {
     
    idd = result1.id;
_channelController.text = result1["Channel"];
     users.where("uid", isEqualTo: result.uid).get().then((querySnapshot5) {
       
     
       querySnapshot5.docs.forEach((result5)  {
      
       String nam =  result5["name"];  
       int noh = result5["noofhelps"]; 
       
vc
    .doc(result1.id)
      .update({
        
        'Helpee Name' : nam,
        'Helpee NOH' : noh,
        'Helpeename' : nam,
      });
     
      });
      });
    });
                      print('the transfer rate $transferRate');
                      if(transferRate>=0.5)
                      {
    Fluttertoast.showToast(
        msg: 'Your internet speed is $transferRate Mb/s. You should not face any problems during the video call.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    
                 _handleCameraAndMic();
      // push video page with given channel name
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage1(
            channelName: _channelController.text,
            role: _role,
            idd: idd,
          ),
        ),
      );
                      }
                      else{
 Fluttertoast.showToast(
        msg: 'Your internet speed is $transferRate Mb/s. Switching to a better network is recommended.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
   
                      
                      }
                      setState(() {
                        downloadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        downloadProgress = '100';
           
                      }
                      
                      );
                      
                    },
                    onProgress:
                        (double percent, double transferRate, SpeedUnit unit) {
          
                     
                      setState(() {
                        downloadRate = transferRate;
                        unitText = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
                        downloadProgress = percent.toStringAsFixed(2);
                      });
                    },
                    onError: (String errorMessage, String speedTestError) {
                      print(
                          'the errorMessage $errorMessage, the speedTestError $speedTestError');
                    },
                    
                    
                  );

   
    }
      }
  });
     }
    });
  });     
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
