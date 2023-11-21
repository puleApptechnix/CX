

import 'package:chiken_xpress/screen/talk_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'find_us.dart';
import 'online_order.dart';

class FollowUsFragment extends StatefulWidget {
  static const String _title = 'Login';

  @override
  State<StatefulWidget> createState() {

    return FollowUsFragmentState();
  }
}


class FollowUsFragmentState extends State<FollowUsFragment> {
String facebook='https://www.facebook.com/ChickenXpress';
var insta='https://www.instagram.com/chickenxpress_sa/';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xffD2232A),
        statusBarIconBrightness: Brightness.dark
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          centerTitle: true,

          title: const Text(
            'FOLLOW US',style: TextStyle(fontFamily: 'Montserrat_Regular',
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

        body: Stack(
          children: [
            Container(
              // width: double.infinity,

                margin: EdgeInsets.only(top: 20,left: 0,right: 0),
                child:Column(
                  children: [
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Image.asset('assets/images/new_insta_img.png',height: 250,width: 180,fit: BoxFit.fill,),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: ClipOval(

                                  child:
                                  Image.asset("assets/images/new_insta_logo.png",
                                    fit: BoxFit.cover,
                                    height: 65,
                                    width: 65,
                                  )
                              ),
                            ),

                            // Image.asset('assets/images/facebook_logo.png',height: 70,width: 80,fit: BoxFit.fill,),
                            GestureDetector(
                              onTap: (){
                                _launchURLInsta();
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                      colors: [Colors.red, Colors.orange]
                                  ),

                                ),
                                child: Text('FOLLOW',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 16),),

                              ),
                            )

                          ],
                        ),
                        Column(
                          children: [
                            Image.asset('assets/images/new_fb_img.png',height: 250,width: 180,fit: BoxFit.fill,),
                            Container(margin: EdgeInsets.only(top: 30),
                              child:
                              ClipOval(

                                  child:
                                  Image.asset("assets/images/new_fb_logo.png",
                                    fit: BoxFit.cover,
                                    height: 65,
                                    width: 65,
                                  )
                              ),
                            ),

                            // Image.asset('assets/images/insta_logo.png',height: 80,width: 80,fit: BoxFit.fill,),
                           GestureDetector(
                             onTap: (){
                               _launchURLFB();
                             },
                             child:  Container(
                               height: 40,
                               width: 100,
                               alignment: Alignment.center,
                               padding: EdgeInsets.all(10),
                               margin: EdgeInsets.only(top: 20),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(Radius.circular(40)),
                                 gradient: LinearGradient(
                                     begin: Alignment.topLeft,
                                     end: Alignment.topRight,
                                     colors: [Colors.red, Colors.orange]
                                 ),

                               ),
                               child: Text('FOLLOW',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 16),),

                             ),
                           )



                          ],
                        ),
                      ],
                    ),

                  ],
                )

            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset('assets/images/hen.png'),
            )
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

  // void navigateToLogin() async{
  //   Navigator.pop(context,false);
  //   bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
  //
  //     return Login();
  //   }));
  // }
  _launchFacebook(String? facebook) async {
    final url = 'fb://facewebmodal/f?href='+ facebook!;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }

_launchInstagram(String? instagram) async {
  final url = 'in://' + instagram!;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  // Future<void> _launchUrl() async {
  //    final Uri _url = Uri.parse('https://www.facebook.com/ChickenXpress');
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }
  _launchURLInsta() async {
    final Uri url = Uri.parse('https://www.instagram.com/chickenxpress_sa/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  _launchURLFB() async {
    // final Uri url = Uri.parse('https://www.facebook.com/ChickenXpress');
    // if (!await launchUrl(url)) {
    //   throw Exception('Could not launch $url');
    // }
    var fbUrl =
        "fb://facewebmodal/f?href=" +facebook;
    launchFacebook(fbUrl, facebook);
    }

Future<void> launchFacebook(String fbUrl,String fbWebUrl)
async {
  try {
    bool launched = await launch(fbUrl, forceSafariVC: false);
    print("Launched Native app $launched");

    if (!launched) {
      await launch(fbWebUrl, forceSafariVC: false);
      print("Launched browser $launched");
    }
  } catch (e) {
    await launch(fbWebUrl, forceSafariVC: false);
    print("Inside catch");
  }
}

  void moveToLastScreen() {
    Navigator.pop(context,true);
  }
  void navigateFollowUs() async{
    Navigator.pop(context,false);
    Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return FollowUsFragment();

    }));
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
  void navigateTalkUs() async{
    Navigator.pop(context,false);
    Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return TalkUsFragment();

    }));
  }

}