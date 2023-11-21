import 'dart:convert';



import 'package:chiken_xpress/screen/talk_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../map_utils.dart';
import 'find_us.dart';
import 'follow_us.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home_src.dart';

class SecondFragment extends StatefulWidget {
  static const String _title = 'Login';

  @override
  State<StatefulWidget> createState() {

    return SecondFragmentState();
  }
}


class SecondFragmentState extends State<SecondFragment> {
var jsonArrStoreList=[] as List;
var url;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xffD2232A),
        statusBarIconBrightness: Brightness.dark
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(

        centerTitle: true,

        title: const Text(
          'ORDER ONLINE',style: TextStyle(fontFamily: 'Montserrat_Regular',
            color: Colors.white,fontWeight: FontWeight.w800,
            fontSize: 20),
        ),
        leading: Builder(builder: (context) {
    return IconButton(
    onPressed: () { Scaffold.of(context).openDrawer();},
    icon:Image.asset('assets/images/new_menu.png',color: Colors.white,  ),
    );
        }),
        /* actions: [
            GestureDetector(
              onTap: (){
                get_driver_data_Refresh(user_id);
              },
              child:Image.asset(
                  "assets/images/icons_referesh.png",
                  width: 50.0, height: 50.0),
            ),
          ],*/
        backgroundColor: Color(0xffD2232A),


      ),

      body:WebView(
        initialUrl: HomeSrcState.url,
        javascriptMode: JavascriptMode.unrestricted,
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

                              navigateFindUs();
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

  get() async {

    final prefs=await SharedPreferences.getInstance();


      url=prefs.getString('url')!;

  }

  // void navigateToLogin() async{
  //   Navigator.pop(context,false);
  //   bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
  //
  //     return Login();
  //   }));
  // }
  void navigateTalkUs() async{
    Navigator.pop(context,false);
    Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return TalkUsFragment();

    }));
  }
  void moveToLastScreen() {
    Navigator.pop(context,true);
  }
  void navigateOnlineOrder() async{
    Navigator.pop(context,false);
    Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return SecondFragment();

    }));
  }

  void navigateFindUs() async{
    Navigator.pop(context,false);
    Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return FindUsFragment();

    }));
  }
  void navigateFollowUs() async{
    Navigator.pop(context,false);
    Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return FollowUsFragment();

    }));
  }
}