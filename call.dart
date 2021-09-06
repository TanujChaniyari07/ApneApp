import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:apneapp/src/utilities/constants.dart';
import '../utilities/settings.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:painter/painter.dart';
import 'package:firebase_auth/firebase_auth.dart';
class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;

  /// non-modifiable client role of the page
  final ClientRole role;
final String idd;
  
  

  /// Creates a call page with given channel name.
  const CallPage({Key key, this.channelName, this.role, this.idd}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}
class _CallPageState extends State<CallPage> {
  bool _finished;
  PainterController _controller;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference firestorepoints = FirebaseFirestore.instance.collection("Points");
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  CollectionReference vc = FirebaseFirestore.instance.collection("VC");
 User result = FirebaseAuth.instance.currentUser;
  
  
  List<Offset> _points = <Offset>[];
  ArCoreController arCoreController;
 StreamMessageCallback streamMessage;
   
 
   
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
         final info = 'onError: $code';
         _infoStrings.add(info);
       });
     }, joinChannelSuccess: (channel, uid, elapsed) {
       setState(() {
         final info = 'onJoinChannel: $channel, uid: $uid';
         _infoStrings.add(info);
         
         
       });
     }, leaveChannel: (stats) {
       setState(() {
         _infoStrings.add('onLeaveChannel');
         _users.clear();
       });
     }, userJoined: (uid, elapsed) {
       setState(() {
         final info = 'userJoined: $uid';
         _infoStrings.add(info);
         _users.add(uid);
         u = uid;
         
         
         
       });
       new Signature(users: _users);
     }, 
     
     userOffline: (uid, elapsed) {
       setState(() {
         final info = 'userOffline: $uid';
         _infoStrings.add(info);
         _users.remove(uid);
       });
     }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
       setState(() {
         final info = 'firstRemoteVideo: $uid ${width}x $height';
         _infoStrings.add(info);
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
       setState(() {
         final info = 'First';
         _infoStrings.add(info);
       });
       return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
        
        
       case 2:
       setState(() {
         final info = 'First';
         _infoStrings.add(info);
       });
       return Container(
 
         
             child:
             
             
               
             
                        
 
        GestureDetector(
           onPanUpdate: (DragUpdateDetails details) {
             setState(() {
               
               RenderBox object = context.findRenderObject();
               Offset _localPosition =
                   object.globalToLocal(details.globalPosition);
               _points = new List.from(_points)..add(_localPosition);


                     
               
              
             });
           },
           onPanEnd: (DragEndDetails details){

             setState((){
               double width = MediaQuery.of(context).size.width;
               double height = MediaQuery.of(context).size.height;
              List<double> dx = new List(1000);
              List<double> dy = new List(1000);
               for (int i = 0; i < _points.length - 1; i++) {
      if (_points[i] != null && _points[i + 1] != null) {

        
        
        dx[i]=_points[i].dx;
        dy[i]=_points[i].dy;
        
       
        
      }
      
      
    }
              

          
          firestorepoints.add(
           {
            
            
            'dx' : dx,
            'dy' : dy,
            
            "UID" : u,
            'Width' : width,
            'Height' : height
           }
            
            ); 
             _points.add(null);
               
             });
           },
              
           
           
           child: new CustomPaint(
             foregroundPainter: new Signature(points: _points),
             size: Size.infinite,
             child:  Column(
             children: <Widget> [_videoView(views[1]), _expandedVideoRow([views[0]])],
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
             onPressed: _onSwitchCamera,
             child: Icon(
               Icons.switch_camera,
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
      stream: vc.doc(widget.idd).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
       var userDocument = snapshot.data;
        int noh2 = userDocument["Helpee NOH"];
        String nam = userDocument["Helpee Name"];
        
        
        
        if(nam == "Finding"){
        return 
      Row( 
        children: <Widget>[
           SizedBox(width: 6,),  
        
        Text('Finding helpee...', style: kOnBoardingSubHeadingStyle,),
        ],
);

      } 
    else if(nam == "Disconnected"){
        return 
      Row( 
        children: <Widget>[
           SizedBox(width: 6,),  
        
        Text('Helpee Disconnected', style: kOnBoardingSubHeadingStyle,),
        ],
);

      }  
      else{
       if(noh2 < 5)
        {
        return 
         Column( 
        children: <Widget>[
      Row( 
        children: <Widget>[
           SizedBox(width: 6,), 
           Icon(Icons.person, color: Colors.white,),
           SizedBox(width: 6,),  
        Text('Helpee : $nam', style: kOnBoardingSubHeadingStyle,
        
        ),
        ],
),


                   ],);
      }
       else if (noh2 >= 5 && noh2 < 11)
       {
      return 
         Column( 
        children: <Widget>[
      Row( 
        children: <Widget>[
           SizedBox(width: 6,), 
           Icon(Icons.person, color: Colors.white,),
           SizedBox(width: 6,),  
        Text('Helpee : $nam', style: kOnBoardingSubHeadingStyle,
        
        ),
        SizedBox(width: 6,), 
        Icon(Icons.verified, color: Colors.brown,),
        ],
),

                   ],);
       }   
           else if (noh2 >= 11 && noh2 < 16)
       {
      return 
         Column( 
        children: <Widget>[
      Row( 
        children: <Widget>[
           SizedBox(width: 6,), 
           Icon(Icons.person, color: Colors.white,),
           SizedBox(width: 6,),  
        Text('Helpee : $nam', style: kOnBoardingSubHeadingStyle,
        
        ),
        SizedBox(width: 6,), 
        Icon(Icons.verified, color: Colors.grey,),
        ],
),

                   ],);
       }  
             else  
       {
      return 
         Column( 
        children: <Widget>[
      Row( 
        children: <Widget>[
           SizedBox(width: 6,), 
           Icon(Icons.person, color: Colors.white,),
           SizedBox(width: 6,),  
        Text('Helpee : $nam', style: kOnBoardingSubHeadingStyle,
        
        ),
        SizedBox(width: 6,), 
        Icon(Icons.verified, color: Colors.amber,),
        ],
),

                   ],);
       }  
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
       vc
    
    .where("Helper", isEqualTo : result.uid).where("Done_helper", isEqualTo : 0)
    .get()
    .then((querySnapshot)   {
    querySnapshot.docs.forEach((result1)  {
 
    vc
    .doc(result1.id)
      .update({
        'Done_helper': 1, 
        'Helper Name' : "Disconnected",
        
      });

    
     
      });
  });
     Navigator.pop(context);
   }
 
   void _onToggleMute() {
     setState(() {
       muted = !muted;
     });
     _engine.muteLocalAudioStream(muted);
   }
 
   void _onSwitchCamera() {
     _engine.switchCamera();
     
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
  List<Offset> points;
  List<int> users;
  var point1;
  
  final CustomPainter foregroundPainter;
  
  

  Signature({this.points, this.point1, this.foregroundPainter, this.users});
  

  @override
  void paint(Canvas canvas, Size size) {
    print("object");
    Paint paint = new Paint()
    
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;
       
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {

        
        canvas.drawLine(points[i], points[i + 1], paint);
        
        
       
        
      }
      
      
    }
   
 


  }
  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;



}
