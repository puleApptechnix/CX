import 'dart:convert';


// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:chiken_xpress/screen/splash.dart';
import 'package:chiken_xpress/screen/talk_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

// import '../notificationservice/local_notification_service.dart';
import 'StatefulExample.dart';
import 'find_us.dart';
import 'follow_us.dart';
import 'online_order.dart';

class HomeSrc extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return HomeSrcState();

  }

}
class HomeSrcState extends State<HomeSrc>{

  var link;
  static var name;
  static var user_id;
  var latitude_login;
  var longitude_login;
  static var url;
  var profile="";
 // bool isLoading = false; // Add this variable to track loading state
  bool isLoading = true; // Add this variable to track loading state
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      // getData();
      get();
    });
    super.initState();


  }


  List<Widget> _fragments=[FirstFragment()];
  static int _currentIndex=0;
  // late double lati=0,longi=0;
  @override
  Widget build(BuildContext context) {



    return Scaffold(

      // appBar: AppBar(
      //   centerTitle: true,
      //
      //   title: const Text(
      //     'Driver Live Location',style: TextStyle(
      //       color: Colors.black,fontWeight: FontWeight.w700,
      //       fontSize: 16),
      //   ),
      //
      //   backgroundColor: Colors.white,
      // ),


        body:  Stack(
          children: <Widget>[
            Container(
              child: Container(
                  child: Column(
                    children: [
                      Expanded(child:
                      isLoading
                          ? Center(child: CircularProgressIndicator()) // Loading indicator
                          : _fragments[_currentIndex],

                      ),],
                  )
              ),
            ),
          ],
        ),


        drawer: Drawer(
          child: Container(
            color: Color(0xffD2232A),
            child: Container(

                child:Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 100,left: 10),
                      child: ListView(
                        // Important: Remove any padding from the ListView.
                        padding: EdgeInsets.zero,
                        children: [
                          ListTile(
                            leading: Image.asset('assets/images/order_online.png',height: 20,width: 20,fit: BoxFit.fill,color: Colors.white),
                            title: const Text("Order Online",style: TextStyle(fontWeight: FontWeight.w500,color:Colors.white,fontSize:15,fontFamily: 'Montserrat_regular'),),
                            onTap: () {
                              // navigateToHomeBusiness();
                              navigateOnlineOrder();
                            },
                          ),
                          ListTile(
                            leading: Image.asset('assets/images/new_our_menu.png',height: 20,width: 20,fit: BoxFit.fill,color: Colors.white
                            ),

                            title: const Text("Our Menu",style: TextStyle(fontFamily: 'Montserrat_regular',fontWeight: FontWeight.w500,color:Colors.white,fontSize:15),),
                            onTap: ()  async {
                              final Uri url = Uri.parse('https://www.chickenxpress.co.za/menu/');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                              // _launchUrl();

                            },
                          ),
                          ListTile(
                            leading: Image.asset('assets/images/new_find_us.png',height: 20,width: 20,fit: BoxFit.fill,color: Colors.white),
                            title: const Text("Find Us",style: TextStyle(fontFamily: 'Montserrat_regular',fontWeight: FontWeight.w500,color:Colors.white,fontSize:15),),
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => StatefulExample()),
                              );
                             // navigateFindUs();
                              // Navigator.pop(context);
                              // logoutUser();
                            },
                          ),
                          ListTile(
                            leading: Image.asset('assets/images/follow_us.png',height: 20,width: 20,fit: BoxFit.fill,color: Colors.white,),
                            title: const Text("Follow Us",style: TextStyle(fontFamily: 'Montserrat_regular',fontWeight: FontWeight.w500,color:Colors.white,fontSize:15),),
                            onTap: () async {
                              navigateFollowUs();

                              // Navigator.pop(context);
                              // logoutUser();
                            },
                          ),
                          // ListTile(
                          //   leading: Image.asset('assets/images/new_talk_us.png',height: 20,width: 20,fit: BoxFit.fill,color: Colors.white,),
                          //   title: const Text("Talk to us?",style: TextStyle(fontFamily: 'Montserrat_regular',fontWeight: FontWeight.w500,color:Colors.white,fontSize:15),),
                          //   onTap: () async {
                          //
                          //     navigateTalkUs();
                          //     // Navigator.pop(context);
                          //     // logoutUser();
                          //   },
                          // ),


                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,

                      child:
                      Container(
                          alignment: Alignment.bottomLeft,
                          // margin: EdgeInsets.only(right: 200,top: 100),
                          child: Image.asset('assets/images/drawer.png',height: 200,width: 153,fit: BoxFit.fill,)),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: (){
                          Scaffold.of(context).closeDrawer();
                        },
                        child:  Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Image.asset('assets/images/close.png')),
                      ),

                    )
                  ],
                )

            ),
          ),
        )

    );




  }

  Future<void> get() async {
    // Set isLoading to true to indicate loading
    setState(() {
      isLoading = true;
    });


    try {
      var response = await http.get(
        Uri.parse('https://app.chickenxpress.co.za/adminpanel/api/v1/Cx_api/getSettings'),
      );
      print(response.body);
      var data = json.decode(response.body);

      String api_key = data['Data Found']['api_key'];
      url = data['Data Found']['order_url'];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('url', url);
    } catch (e) {
      print(e);
    } finally {
      // Set isLoading to false to indicate loading is complete
      setState(() {
        isLoading = false;
      });
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


  void navigateTalkUs() async{
    // Navigator.pop(context,false);
    // Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return TalkUsFragment();

    }));
  }
  void navigateOnlineOrder() async{
    // Navigator.pop(context,false);
    // Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return SecondFragment();

    }));
  }
  void navigateFindUs() async{
    // Navigator.pop(context,false);
    // Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return FindUsFragment();

    }));
  }
  void navigateFollowUs() async{
    // Navigator.pop(context,false);
    // Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return FollowUsFragment();

    }));
  }
  void moveToLastScreen() {
    Navigator.pop(context,true);
  }



}


class FirstFragment extends StatefulWidget {
  static const String _title = 'Login';

  @override
  State<StatefulWidget> createState() {

    return FirstFragmentState();
  }
}


class FirstFragmentState extends State<FirstFragment> {
  PageController _controller = PageController(initialPage: 0);
  static int user_type=1;
  final controller=PageController();
  bool isLastPage=false;
  bool firstVisible=false;
  bool secondVisible=false;
  bool thriedVisible=false;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.white,
    //     statusBarIconBrightness: Brightness.dark
    // ));
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // key: _scaffoldState,
      // backgroundColor: Colors.white,

      body:
      Stack(

          children:<Widget> [

            Container(
              // padding: const EdgeInsets.only(bottom: 50),
              alignment: Alignment.bottomCenter,
              child:
              PageView(
                controller: controller,
                onPageChanged: (index){
                  setState(() => isLastPage=index==4);
                },
                children: [
                  Container(
                    // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),

                      child:
                      Stack(
                        // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[


                            Align(
                              // alignment: Alignment.center,
                              child:
                              Stack(
                                children: [
                                  Container(
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(image: new NetworkImage(SplashScreenState.jsonArrImageList[0]['image']), fit: BoxFit.cover,),
                                    ),
                                  )
                                ],

                              ),

                            ),



                            Align(
                                alignment: Alignment.bottomCenter,
                                child:Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset('assets/images/bottom_banner.png'),
                                    ),

                                    /*  Align(
                                  alignment: Alignment.center,
                                  child: Image.network(SplashScreenState.jsonArrImageList[0]['image'],height: 500,fit: BoxFit.fill,),
                                ),*/
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              SplashScreenState.jsonArrImageList[0]['type']=='1'?navigateOnlineOrder():navigateFindUs();

                                            },
                                            child: Container(
                                              height: 40,
                                              width: 180,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.only(bottom: 30),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [Colors.red, Colors.orange]
                                                ),

                                              ),
                                              child: Text(SplashScreenState.jsonArrImageList[0]['type']=='1'?'ORDER ONLINE':'FIND A STORE',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 16),),

                                            ),
                                          )



                                        ],
                                      ),
                                    )

                                  ],
                                )

                            ),


                            Align(
                                alignment: Alignment.topLeft,

                                child: Stack(
                                  children: <Widget>[


                                    Container(
                                      margin: EdgeInsets.only(top: 30),
                                      child: Image.asset('assets/images/top_banner.png'),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        // _scaffoldState.currentState.openDrawer();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 50),
                                        child: IconButton(
                                          onPressed: () {
                                            Scaffold.of(context).openDrawer();},
                                          icon:Image.asset('assets/images/new_menu.png',color: Colors.white,  ),
                                        ),

                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Container(
                                            height: 40,
                                            width: 180,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(top: 50),

                                            child: Text('ONLINE STORE',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 18),),

                                          ),




                                        ],
                                      ),
                                    ),

                                  ],
                                )


                            ),



                          ]
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          child: Stack(
                            children: [
                              Container(
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new NetworkImage(SplashScreenState.jsonArrImageList[1]['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.bottomRight,
                                child: Image.asset('assets/images/bottom_banner.png'),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        SplashScreenState.jsonArrImageList[1]['type'] == '1'
                                            ? navigateOnlineOrder()
                                            : navigateFindUs();
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 180,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.only(bottom: 30),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [Colors.red, Colors.orange],
                                          ),
                                        ),
                                        child: Text(
                                          SplashScreenState.jsonArrImageList[1]['type'] == '1'
                                              ? 'ORDER ONLINE'
                                              : 'FIND A STORE',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat_Bold',
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Image.asset('assets/images/top_banner.png'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // _scaffoldState.currentState.openDrawer();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: IconButton(
                                    onPressed: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    icon: Image.asset(
                                      'assets/images/new_menu.png',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 180,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(top: 50),
                                      child: Text(
                                        'TTFT',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat_Bold',
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),

                      child:
                      Stack(
                        // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[


                            Align(
                              // alignment: Alignment.center,
                              child:
                              Stack(
                                children: [
                                  Container(
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(image: new NetworkImage(SplashScreenState.jsonArrImageList[2]['image']), fit: BoxFit.cover,),
                                    ),
                                  )
                                ],

                              ),

                            ),



                            Align(
                                alignment: Alignment.bottomCenter,
                                child:Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset('assets/images/bottom_banner.png'),
                                    ),

                                    /*Align(
                                      alignment: Alignment.center,
                                      child: Image.network(SplashScreenState.jsonArrImageList[2]['image'],height: 500,fit: BoxFit.fill,),
                                    ),*/
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              SplashScreenState.jsonArrImageList[2]['type']=='1'?navigateOnlineOrder():navigateFindUs();

                                            },
                                            child: Container(
                                              height: 40,
                                              width: 180,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.only(bottom: 30),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [Colors.red, Colors.orange]
                                                ),

                                              ),
                                              child: Text(SplashScreenState.jsonArrImageList[2]['type']=='1'?'ORDER ONLINE':'FIND A STORE',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 16),),

                                            ),
                                          )



                                        ],
                                      ),
                                    )

                                  ],
                                )

                            ),


                            Align(
                                alignment: Alignment.topLeft,

                                child: Stack(
                                  children: <Widget>[


                                    Container(
                                      margin: EdgeInsets.only(top: 30),
                                      child: Image.asset('assets/images/top_banner.png'),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        // _scaffoldState.currentState.openDrawer();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 50),
                                        child: IconButton(
                                          onPressed: () {
                                            Scaffold.of(context).openDrawer();},
                                          icon:Image.asset('assets/images/new_menu.png',color: Colors.white,  ),
                                        ),

                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Container(
                                            height: 40,
                                            width: 180,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(top: 50),

                                            child: Text('EXPREZZA',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 18),),

                                          ),




                                        ],
                                      ),
                                    ),

                                  ],
                                )


                            ),



                          ]
                      )
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),

                      child:
                      Stack(
                        // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[


                            Align(
                              // alignment: Alignment.center,
                              child:
                              Stack(
                                children: [
                                  Container(
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(image: new NetworkImage(SplashScreenState.jsonArrImageList[3]['image']), fit: BoxFit.cover,),
                                    ),
                                  )
                                ],

                              ),

                            ),



                            Align(
                                alignment: Alignment.bottomCenter,
                                child:Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset('assets/images/bottom_banner.png'),
                                    ),

                                    /*  Align(
                                      alignment: Alignment.center,
                                      child: Image.network(SplashScreenState.jsonArrImageList[3]['image'],height: 500,fit: BoxFit.fill,),
                                    ),*/

                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              SplashScreenState.jsonArrImageList[3]['type']=='1'?navigateOnlineOrder():navigateFindUs();
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 180,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.only(bottom: 30),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [Colors.red, Colors.orange]
                                                ),

                                              ),
                                              child: Text(SplashScreenState.jsonArrImageList[3]['type']=='1'?'ORDER ONLINE':'FIND A STORE',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 16),),

                                            ),
                                          )



                                        ],
                                      ),
                                    )

                                  ],
                                )

                            ),


                            Align(
                                alignment: Alignment.topLeft,

                                child: Stack(
                                  children: <Widget>[


                                    Container(
                                      margin: EdgeInsets.only(top: 30),
                                      child: Image.asset('assets/images/top_banner.png'),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        // _scaffoldState.currentState.openDrawer();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 50),
                                        child: IconButton(
                                          onPressed: () {
                                            Scaffold.of(context).openDrawer();},
                                          icon:Image.asset('assets/images/new_menu.png',color: Colors.white,  ),
                                        ),

                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Container(
                                            height: 40,
                                            width: 180,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(top: 50),

                                            child: Text('FLAVA BOX',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 18),),

                                          ),




                                        ],
                                      ),
                                    ),

                                  ],
                                )


                            ),



                          ]
                      )
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),

                      child:
                      Stack(
                        // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[


                            Align(
                              // alignment: Alignment.center,
                              child:
                              Stack(
                                children: [
                                  Container(
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(image: new NetworkImage(SplashScreenState.jsonArrImageList[4]['image']), fit: BoxFit.cover,),
                                    ),
                                  )
                                ],

                              ),

                            ),



                            Align(
                                alignment: Alignment.bottomCenter,
                                child:Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset('assets/images/bottom_banner.png'),
                                    ),

                                    /* Align(
                                      alignment: Alignment.center,
                                      child: Image.network(SplashScreenState.jsonArrImageList[4]['image'],height: 500,fit: BoxFit.fill,),
                                    ),*/
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                              SplashScreenState.jsonArrImageList[4]['type']=='1'?navigateOnlineOrder():navigateFindUs();

                                            },
                                            child: Container(
                                              height: 40,
                                              width: 180,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.only(bottom: 30),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.topRight,
                                                    colors: [Colors.red, Colors.orange]
                                                ),

                                              ),
                                              child: Text(SplashScreenState.jsonArrImageList[4]['type']=='1'?'ORDER ONLINE':'FIND A STORE',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 16),),

                                            ),
                                          )



                                        ],
                                      ),
                                    )

                                  ],
                                )

                            ),


                            Align(
                                alignment: Alignment.topLeft,

                                child: Stack(
                                  children: <Widget>[


                                    Container(
                                      margin: EdgeInsets.only(top: 30),
                                      child: Image.asset('assets/images/top_banner.png'),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        // _scaffoldState.currentState.openDrawer();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 50),
                                        child: IconButton(
                                          onPressed: () {
                                            Scaffold.of(context).openDrawer();},
                                          icon:Image.asset('assets/images/new_menu.png',color: Colors.white,  ),
                                        ),

                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Container(
                                            height: 40,
                                            width: 180,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(top: 50),

                                            child: Text('FIND A STORE',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 18),),

                                          ),




                                        ],
                                      ),
                                    ),

                                  ],
                                )


                            ),



                          ]
                      )
                  ),


                ],
              ),
            ),
            /* GestureDetector(
          onTap: (){

            Scaffold.of(context).openDrawer();
          },
          child:  Container(
            margin: EdgeInsets.only(top: 30),
            child: Image.asset('assets/images/new_menu.png',color: Colors.white,  ),
    *//*IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();},
                icon:Image.asset('assets/images/new_menu.png',color: Colors.white,  ),
              ),*//*

  ),
),*/


          ]
      ),





    );

  }
  void navigateTalkUs() async{
    // Navigator.pop(context,false);
    // Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return TalkUsFragment();

    }));
  }
  void navigateOnlineOrder() async{
    // Navigator.pop(context,false);
    // Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return SecondFragment();

    }));
  }
  void navigateFindUs() async{
    // Navigator.pop(context,false);
    // Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return FindUsFragment();

    }));
  }
  void navigateFollowUs() async{
    // Navigator.pop(context,false);
    // Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return FollowUsFragment();

    }));
  }

  // void navigateToLogin() async{
  //   Navigator.pop(context,false);
  //   bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
  //
  //     return Login();
  //   }));
  // }
  void moveToLastScreen() {
    Navigator.pop(context,true);
  }
  void showMsg(String msg) {
    Fluttertoast.showToast(msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}

