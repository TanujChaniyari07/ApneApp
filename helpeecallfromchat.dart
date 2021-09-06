import 'dart:async';


import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';

import '../utilities/settings.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import './review.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:apneapp/src/utilities/constants.dart';
import 'package:painter/painter.dart';



class CallPagehelpee extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;

  /// non-modifiable client role of the page
  final ClientRole role;

  final String idd;
  

  /// Creates a call page with given channel name.
  const CallPagehelpee({Key key, this.channelName, this.role, this.idd}) : super(key: key);

  @override
  _CallPageStatehelpee createState() => _CallPageStatehelpee();
}
class _CallPageStatehelpee extends State<CallPagehelpee> {
  bool _finished;
  PainterController _controller;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference firestorepoints = FirebaseFirestore.instance.collection("Points");
  
  
  List<Offset> _points = <Offset>[];
  ArCoreController arCoreController;
 StreamMessageCallback streamMessage;
   CollectionReference users = FirebaseFirestore.instance.collection("Users");
  CollectionReference vc = FirebaseFirestore.instance.collection("VC");
  CollectionReference msgs = FirebaseFirestore.instance.collection("messages");
  CollectionReference info = FirebaseFirestore.instance.collection("Info");
 User result = FirebaseAuth.instance.currentUser;
 
   
   static final _users = <int>[];
   final _infoStrings = <String>[];
   bool muted = false;
   RtcEngine _engine;
   int u;
   
   
   @override
   void dispose() {
   
     // clear users
     _users.clear();
     // destroy sdk
     _engine.leaveChannel();
     _engine.destroy();
     super.dispose();
   }
 
   @override
   void initState() {
     super.initState();
     _finished = false;
    
     // initialize agora sdk
     initialize();
   }
   
   Future<void> initialize() async {
     if (APP_ID.isEmpty) {
       setState(() {
         _infoStrings.add(
           'APP_ID missing, please provide your APP_ID in settings.dart',
         );
         _infoStrings.add('Agora Engine is not starting');
       });
       return;
     }
 
     await _initAgoraRtcEngine();
     _addAgoraEventHandlers();
     //await _engine.enableWebSdkInteroperability(true);
     VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
     configuration.dimensions = VideoDimensions(1920, 1080);
     await _engine.setVideoEncoderConfiguration(configuration);
     await _engine.joinChannel(null, widget.channelName, null, 0);
   }
 
   /// Create agora sdk instance and initialize
   Future<void> _initAgoraRtcEngine() async {
     _engine = await RtcEngine.create(APP_ID);
     await _engine.enableVideo();
     _engine.switchCamera();
     await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
     await _engine.setClientRole(widget.role);
   }
   
 
   /// Add agora event handlers
   void _addAgoraEventHandlers() {
     _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
       setState(() {
        
       });
     }, joinChannelSuccess: (channel, uid, elapsed) {
       setState(() {
       
         u=uid;
       });
     }, leaveChannel: (stats) {
       setState(() {
         
         _users.clear();
       });
     }, userJoined: (uid, elapsed) {
       setState(() {
      
         _users.add(uid);
       
       });
     }, userOffline: (uid, elapsed) {
       setState(() {
         
         _users.remove(uid);
       });
     }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
    
     },
     streamMessage: (uid, streamId, data)
     {
       setState(() {
         int i=0;
         final point = '$data';
         var point1;  
         point1[i] = double.parse(point);
         i=i+1; 
         Fluttertoast.showToast(
        msg: '$data',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
       });

     },
     streamMessageError: (uid, streamId, error, missed, cached)
     {
       setState(() {
         
         Fluttertoast.showToast(
        msg: '$error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
       });

     },
     
     
     ));
   }
 
 
   /// Helper function to get list of native views
   List<Widget> _getRenderViews() {
     final List<StatefulWidget> list = [];
     if (widget.role == ClientRole.Broadcaster) {
       list.add(RtcLocalView.SurfaceView());
     }
     _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
     return list;
   }
 
   /// Video view wrapper
   Widget _videoView(view) {
      
     
     return Expanded(child: Container(child:  view)); 
  
   }
 
   /// Video view row wrapper
   Widget _expandedVideoRow(List<Widget> views) {
     final wrappedViews = views.map<Widget>(_videoView).toList();
     return Expanded(
       child: Row(
         children: wrappedViews,
       ),
     );
   }
 
   /// Video layout wrapper
   Widget _viewRows() {
     final views = _getRenderViews();
     switch (views.length) {
       case 1:
   
       Offset a = Offset(1, 2);
       for(int k=0;k<1000;k++)
                   {
               _points = new List.from(_points)..add(a);

                   } 
 return Container(
 
         
             child:
             
             
               
             
                        
 
        GestureDetector(
          
          
           onDoubleTap: 
          () {
          setState(() {
            _engine.switchCamera();
          });
        },

        onTap: 
         () {
          setState(() {
           
            for(int k=0;k<100;k++)
                   {
               _points = new List.from(_points)..add(a);

                   } 
          });
        },
        
           
           
           
           child: new CustomPaint(
             foregroundPainter: new Signature(points: _points),
             size: Size.infinite,
             child:  Column(
             children: <Widget> [_videoView(views[0])],
             )
             )),
             
        
             
                 
               );
  
  
 
         
       case 2:
    
       double width = MediaQuery.of(context).size.width;
               double height = MediaQuery.of(context).size.height;
       Offset a = Offset(1, 2);
    for(int k=0;k<1000;k++)
                   {
               _points = new List.from(_points)..add(a);

                   } 
 return Container(
 
         
             child:
             
             
               
             
                        
 
        GestureDetector(
          
          
           onDoubleTap: 
          () {
          setState(() {
            _engine.switchCamera();
          });
        },

   
        
           
           
           
           child: new CustomPaint(
             foregroundPainter: new Signature(points: _points, u: u, height : height, width : width),
             size: Size.infinite,
             child:  Column(
             children: <Widget> [
               
               _videoView(views[0]),
             
              _expandedVideoRow([views[1]])],
             )
             )),
             
        
             
                 
               );
       case 3:
         return Container(
             child: Column(
           children: <Widget>[
             _expandedVideoRow(views.sublist(0, 2)),
             _expandedVideoRow(views.sublist(2, 3))
           ],
         ));
       case 4:
         return Container(
             child: Column(
           children: <Widget>[
             _expandedVideoRow(views.sublist(0, 2)),
             _expandedVideoRow(views.sublist(2, 4))
           ],
         ));
       default:
     }
     return Container();
   }
 
   /// Toolbar layout
   Widget _toolbar() {
     if (widget.role == ClientRole.Audience) return Container();
     return Container(
       alignment: Alignment.bottomCenter,
       padding: const EdgeInsets.symmetric(vertical: 48),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           RawMaterialButton(
             onPressed: _onToggleMute,
             child: Icon(
               muted ? Icons.mic_off : Icons.mic,
               color: muted ? Colors.white : Colors.blueAccent,
               size: 20.0,
             ),
             shape: CircleBorder(),
             elevation: 2.0,
             fillColor: muted ? Colors.blueAccent : Colors.white,
             padding: const EdgeInsets.all(12.0),
           ),
           RawMaterialButton(
             onPressed: () => _onCallEnd(context),
             child: Icon(
               Icons.call_end,
               color: Colors.white,
               size: 35.0,
             ),
             shape: CircleBorder(),
             elevation: 2.0,
             fillColor: Colors.redAccent,
             padding: const EdgeInsets.all(15.0),
           ),
           
             RawMaterialButton(
             onPressed: _onSwitchCamera1,
             child: Icon(
               Icons.brush,
               color: Colors.blueAccent,
               size: 20.0,
             ),
             shape: CircleBorder(),
             elevation: 2.0,
             fillColor: Colors.white,
             padding: const EdgeInsets.all(12.0),
           ),
                RawMaterialButton(
             onPressed: () => _points.clear(),
             child: Icon(
               Icons.clear,
               color: Colors.blueAccent,
               size: 20.0,
             ),
             shape: CircleBorder(),
             elevation: 2.0,
             fillColor: Colors.white,
             padding: const EdgeInsets.all(12.0),
           ),
         ],
       ),
     );
   }
 
   /// Info panel to show logs
   Widget _panel() {
     return Container(
       padding: const EdgeInsets.symmetric(vertical: 48),
       alignment: Alignment.bottomCenter,
       child: FractionallySizedBox(
         heightFactor: 0.5,
         child: Container(
           padding: const EdgeInsets.symmetric(vertical: 48),
           child: ListView.builder(
             reverse: true,
             itemCount: 1,
             itemBuilder: (BuildContext context, int index) {
             
               return Padding(
                 padding: const EdgeInsets.symmetric(
                   vertical: 50,
                   horizontal: 10,
                 ),
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Flexible(
                       child: Container(
                         padding: const EdgeInsets.symmetric(
                           vertical: 2,
                           horizontal: 5,
                         ),
                         decoration: BoxDecoration(
                           color: Colors.transparent,
                           borderRadius: BorderRadius.circular(5),
                         ),
                         child:
  StreamBuilder(
      stream: info.doc(widget.channelName).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("");
        }
       var userDocument = snapshot.data;
        int rejected = userDocument["rejected"];
       
        
        if(rejected == 0){

        return 
      Row( 
        children: <Widget>[
           SizedBox(width: 6,),  
        
        Text('', style: kOnBoardingSubHeadingStyle,),
        ],
);

      } 
           
      else{
                       Fluttertoast.showToast(
                    
        msg: 'Call rejected by helper',
        
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 56,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
             return 
      Row( 
        children: <Widget>[
           SizedBox(width: 6,),  
        
        Text('', style: kOnBoardingSubHeadingStyle,),
        ],
);
      }    
      }
  ),
              

                         
                       ),
                     )
                   ],
                 ),
               );
             },
           ),
         ),
       ),
     );
   }
 
   
 
   
 
   
 
   void _onCallEnd(BuildContext context) {
      info.doc(widget.channelName).delete();
                       msgs.doc(widget.channelName).collection(widget.channelName).where('idFrom', isEqualTo: result.uid).where('type', isEqualTo: 4).get().then((querySnapshot5) {
       
     
       querySnapshot5.docs.forEach((result5)  {
      msgs.doc(widget.channelName).collection(widget.channelName).doc(result5.id).delete();

    });
      });
        vc
    
    .where("Helpee", isEqualTo : result.uid).where("Done_helpee", isEqualTo : 0)
    .get()
    .then((querySnapshot)   {
    querySnapshot.docs.forEach((result1)  {
 if(result1["Helper"] == "Null")
 {
      vc
    .doc(result1.id)
      .update({
        'Done_helpee': 1, 
        
      });
   Navigator.pop(context);
 }
 else{
 
      
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewScreen(
            
          ),
        ),
      );

    }
     
      });
  });
     
   }
 
   void _onToggleMute() {
     setState(() {
       muted = !muted;
     });
     _engine.muteLocalAudioStream(muted);
   }
 
   
  void _onSwitchCamera1() {
     _engine.getCallId();
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('ApneApp'),
       ),
       backgroundColor: Colors.black,
       body: 
       
       Center(
         
         
         child: Stack(
 
 
           children: <Widget>[
 
         
 
             
             _viewRows(),
             _panel(),
             _toolbar(),
            
 
           
             
             
           ],
         ),
       ),
     );
   }
   
 }
 
 class StreamMessageCallback{

   StreamMessageCallback streamMessage;


}

class Signature extends CustomPainter {
  List<double> pointsdx = new List(1000);
  List<double> pointsdy = new List(1000);
  List<Offset> points = new List(1000);
  List<Offset> pointss = new List(1000); 
  List<double> pointsdx1 = new List(1000);
  List<double> pointsdy1 = new List(1000);
  String a;
  int u;
  double height;
  double width;
  
  var point1;
  final CustomPainter foregroundPainter;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference firestorepoints = FirebaseFirestore.instance.collection("Points");

  Signature({this.pointsdx, this.point1, this.foregroundPainter, this.pointsdy, this.points, this.u, this.height, this.width});
  

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
    
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;
             
    firestorepoints
    
    .where("UID", isEqualTo : u)
    .get()
    .then((querySnapshot)   {
    querySnapshot.docs.forEach((result)  {
      pointsdx = List.from(result["dx"]);
      pointsdy = List.from(result["dy"]);
      
      
        for (int i = 0; i <pointsdx.length - 1; i++) {
         if (pointsdx[i] != null && pointsdx[i+1] != null && pointsdy[i] != null && pointsdy[i+1] != null) { 
      
        pointsdx1[i] = (pointsdx[i] * width) / result["Width"];
       pointsdy1[i] = (pointsdy[i] * height) / result["Height"];
     
        
        pointss[i] = Offset(pointsdx1[i],pointsdy1[i]);
       }
     
        
      
    }
    

    
     
      });
  });

       
        for (int i = 0; i < points.length-1; i++) {
      if (pointss[i] != null && pointss[i+1] != null) {
        
        
        canvas.drawLine(pointss[i], pointss[i + 1], paint);
       
        
      }
    }
      
    
     
  }


  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.pointss != pointss;
}