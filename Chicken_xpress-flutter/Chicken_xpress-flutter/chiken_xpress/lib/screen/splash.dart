import 'dart:convert';
import 'package:video_player/video_player.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../notificationservice/local_notification_service.dart';
import 'home_src.dart';

class SplashScreen extends StatefulWidget {
  static const String _title = 'Login';
  static const String Key_login='login';
  static String pop_up_status ='0';




  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}


class SplashScreenState extends State<SplashScreen> {
  String? user_type="";
  static var jsonArrImageList=[]as List;
  var user_id;
  static  var jsonArrDriverList=[]as List;
  String fcmTokenString='';
  bool isLoading = true;
  final VideoPlayerController _controller = VideoPlayerController.asset('assets/images/home.mp4');


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    isLoading = true; // Set loading to true initially
    getImages();
    //myFutureHome();
    getFcmId();

    _controller.initialize().then((_) {
      _controller.play();
      _controller.setLooping(false); // Set looping to false to play the video only once
      _controller.addListener(() {
        if (_controller.value.position == _controller.value.duration) {
          // Video has finished playing, navigate to the next page.
          navigatetoHome();
        }
      });
      setState(() {});
    });
// get();

    // bool? session=pref.getBool('session');
// showMsg('${session}');
//     final pref = await SharedPreferences.getInstance();
//     user_type = pref.getString('user_type');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFF003166),
        statusBarIconBrightness: Brightness.dark
    ));

    // whereToGo();

     FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
// storageget();
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
            body:Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/splash_background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      VideoPlayer(_controller), // Use VideoPlayer to display the video
                      if (isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ],
            )




        )
    );
  }

  Future myFutureHome() async {
    Future.delayed(Duration(seconds: 3), ()  {
      navigatetoHome();
      // final pref=await SharedPreferences.getInstance();
      // user_type = pref.getString('user_type');
      // bool check=await storageget();
      // print(user_type);
      // if(check==true){


    });
  }


  void navigatetoHome() async {
    Navigator.pop(context,true);
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return HomeSrc();
    }));
  }



  getImages() async {
    try {

      var response = await http.get(

        Uri.parse('https://app.chickenxpress.co.za/adminpanel/api/v1/Cx_api/getSplash'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // },
        // body: {
        //   'member_phone': mobile,
        // },
      );

      // Dispatch action depending upon
      // the server response
      var newdata = json.decode(response.body);
      print(newdata);
      // String status=newdata['status'];
      // if(status=='1'){
        //   // print("call1");
        setState(() {
          // var newdata = json.decode(response.body);
          jsonArrImageList=newdata['Data Found'] as List;
          isLoading = false; // Set loading to false after data is received
          // showMsg(jsonArrImageList.length.toString());

          print(jsonArrImageList);

        });

    }
    catch(e){
      print(e);
      // Navigator.pop(dialogContext!);
    }


  }

  void showMsg(String msg) {
    Fluttertoast.showToast(msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  getFcmId() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
     fcmTokenString=fcmToken.toString();
     print(fcmTokenString);
    savePhonId(fcmTokenString);
  }

  savePhonId(String phone_id) async {
    try {

      var response = await http.post(
        Uri.parse('https://app.chickenxpress.co.za/adminpanel/api/v1/Cx_api/SavePhoneid'),

        body: {
          'phone_id': phone_id,
        }
      );

      // Dispatch action depending upon
      // the server response
      var newdata = json.decode(response.body);
      print(newdata);
      String msg=newdata['MSG'];
      String status=newdata['status'];
      if(status=='1') {

// showMsg(msg);

      }
    }
    catch(e){
      print(e);
      // Navigator.pop(dialogContext!);
    }


  }



/* void showMsg(String msg) {
    Fluttertoast.showToast(msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }
*/
}