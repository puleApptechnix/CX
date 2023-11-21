import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'find_us.dart';
import 'follow_us.dart';
import 'online_order.dart';

class TalkUsFragment extends StatefulWidget {
  static const String _title = 'Login';

  @override
  State<StatefulWidget> createState() {

    return TalkUsFragmentState();
  }
}


class TalkUsFragmentState extends State<TalkUsFragment> {

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
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(

          centerTitle: true,

          title: const Text(
            'TALK TO US',style: TextStyle(fontFamily: 'Montserrat_Regular',
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
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("assets/images/talk_img.png"), fit: BoxFit.cover,),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child:
              Container(
                margin: EdgeInsets.only(top: 60,left: 20),
                child: Row(
                  children: [
                    Text('Name:',style: TextStyle(fontFamily: 'Montserrat_SemiBold',fontSize: 18),),
                    Container(
                      width: 200,
                      child: TextFormField(
                        style: TextStyle(fontSize: 16,fontFamily: 'Montserrat_Regular'),
                        onChanged: (text){

                        },
                        cursorColor: Colors.red,
                        // obscureText: false,
                        // maxLength: 10,
                        keyboardType: TextInputType.text,

                        // controller: mobileController,
                        decoration: InputDecoration(
                          border: InputBorder.none,

                          hintText: '',
                          // errorText: _validate ? "Invalid Mobile Number" : null,


                        ),

                        // errorText: _validate ? 'Value Can't Be Empty' : null,




                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child:
              Container(
                margin: EdgeInsets.only(top: 110,left: 20),
                child: Row(
                  children: [
                    Text('Number:',style: TextStyle(fontFamily: 'Montserrat_SemiBold',fontSize: 18),),
                    Container(
                      width: 200,
                      child: TextFormField(
                        style: TextStyle(fontSize: 14),
                        onChanged: (text){

                        },
                        cursorColor: Colors.red,
                        // obscureText: false,
                        // maxLength: 10,
                        keyboardType: TextInputType.text,

                        // controller: mobileController,
                        decoration: InputDecoration(
                          border: InputBorder.none,

                          hintText: '',
                          // errorText: _validate ? "Invalid Mobile Number" : null,


                        ),

                        // errorText: _validate ? 'Value Can't Be Empty' : null,




                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child:
              Container(
                margin: EdgeInsets.only(top: 160,left: 20),
                child: Row(
                  children: [
                    Text('Email:',style: TextStyle(fontFamily: 'Montserrat_SemiBold',fontSize: 18),),
                    Container(
                      width: 200,
                      child: TextFormField(
                        style: TextStyle(fontSize: 14),
                        onChanged: (text){

                        },
                        cursorColor: Colors.red,
                        // obscureText: false,
                        // maxLength: 10,
                        keyboardType: TextInputType.text,

                        // controller: mobileController,
                        decoration: InputDecoration(
                          border: InputBorder.none,

                          hintText: '',
                          // errorText: _validate ? "Invalid Mobile Number" : null,


                        ),

                        // errorText: _validate ? 'Value Can't Be Empty' : null,




                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child:
              Container(
                margin: EdgeInsets.only(top: 210,left: 20),
                child: Row(
                  children: [
                    Text('Coment:',style: TextStyle(fontFamily: 'Montserrat_SemiBold',fontSize: 18),),
                    Container(
                      width: 200,
                      child: TextFormField(
                        style: TextStyle(fontSize: 14),
                        onChanged: (text){

                        },
                        cursorColor: Colors.red,
                        // obscureText: false,
                        // maxLength: 10,
                        keyboardType: TextInputType.text,

                        // controller: mobileController,
                        decoration: InputDecoration(
                          border: InputBorder.none,

                          hintText: '',
                          // errorText: _validate ? "Invalid Mobile Number" : null,


                        ),

                        // errorText: _validate ? 'Value Can't Be Empty' : null,




                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  GestureDetector(
                    onTap: (){
                      // showMsg('hello');

                    },
                    child: Container(
                      height: 40,
                      width: 80,
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
                      child: Text('Send',style: TextStyle(fontFamily: 'Montserrat_Bold',color: Colors.white,fontSize: 16),),

                    ),
                  )



                ],
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


  // Example usage:
  // void main() async {
  //   final response = await sendEmail(
  //     'Your Name',
  //     'your_email@example.com',
  //     '1234567890',
  //     'This is a test comment',
  //   );
  //
  //   print(response);
  // }

  Future<Map<String, dynamic>> sendEmail(
      String name, String email, String number, String comment) async {
    final apiUrl = 'https://app.chickenxpress.co.za/adminpanel/api/v1/Cx_api/sendEmail'; // Replace with your API endpoint URL

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'name': name,
        'email': email,
        'number': number,
        'comment': comment,
      },
    );

    if (response.statusCode == 200) {
      // API request successful
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      // Handle the case where the API request fails
      return {
        'msg': 'API request failed',
        'status': '0',
      };
    }
  }
  void navigateTalkUs() async{
    // Navigator.pop(context,false);
    // Navigator.pop(context,true);
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