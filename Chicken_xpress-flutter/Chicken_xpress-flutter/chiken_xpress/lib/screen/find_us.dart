import 'dart:convert';


import 'package:chiken_xpress/screen/talk_us.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'StatefulExample.dart';
import 'follow_us.dart';
import 'online_order.dart';

class FindUsFragment extends StatefulWidget {
  static const String _title = 'Login';

  @override
  State<StatefulWidget> createState() {

    return FindUsFragmentState();
  }
}


class FindUsFragmentState extends State<FindUsFragment> {
  var jsonArrStoreList=[]as List;
  TextEditingController searchController = TextEditingController();

  void performSearch(String query) {
    // Filter the store list based on the query and update the state.
    List filteredStores = jsonArrStoreList.where((store) {
      return store['address'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      jsonArrStoreList = filteredStores;
    });
  }
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
        backgroundColor: Color(0xffF5F5F5),
        appBar: AppBar(

          centerTitle: true,

          title: const Text(
            'OUR STORES',style: TextStyle(fontFamily: 'Montserrat_Regular',
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

        body: Container(
          // width: double.infinity,

            margin: EdgeInsets.only(top: 20,left: 15,right: 15),
            child:Column(
              children:[
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        style: TextStyle(fontSize: 14),
                        onChanged: (text) {
                          performSearch(text);
                        },
                        cursorColor: Colors.red,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        // Reset the store list to the original data.
                        get();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        performSearch(searchController.text);
                      },
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.only(top: 0, left: 0, right: 15),
                ),

                Expanded(
                  child: Container(
                    child: jsonArrStoreList!=null?ListView.builder(
                      shrinkWrap: true,
                      itemCount:jsonArrStoreList.length,
                      itemBuilder:(context,index) {


                        return
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/list_img.png',
                                        fit: BoxFit.cover,
                                        height: 65,
                                        width: 65,
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  jsonArrStoreList[index]['store_name'],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Montserrat_SemiBold',
                                                    color: Color(0xff393939),
                                                  ),
                                                ),
                                                Text(
                                                  jsonArrStoreList[index]['address'],
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Montserrat_regular',
                                                    color: Color(0xff393939),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: (() async{
                                                  // canLaunchUrl(phoneno);
                                                  //   print(await canLaunchUrl(phoneno));
                                                  launch('tel:'+jsonArrStoreList[index]['contact']);
                                                }),
                                                child: Container(

                                                  child: Image.asset('assets/images/new_phone.png',height: 36,),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  // MapUtils.openMap(
                                                  //   double.parse(jsonArrStoreList[index]['latitude']),
                                                  //   double.parse(jsonArrStoreList[index]['longitude']),
                                                  // );
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>  StatefulExample()),
                                                  );

                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 10),
                                                  child: Image.asset('assets/images/new_share.png', height: 36, width: 36),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey,
                              )
                            ],
                          );




                      },

                    ):null,
                  ),
                )
              ],
            )

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

  void showMsg(String msg) {
    Fluttertoast.showToast(msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  static Future<void> openMap(double latitude, double longitude) async {
    var api='AIzaSyBrkOgTUNuFCWfPfC-LPNqUsmIog3tB3Wo';
    String googleUrl = 'https://www.google.com/maps/search/?api=$api&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      // Exception throw 'Could not open the map.';
    }
  }



  void navigateTalkUs() async{
    Navigator.pop(context,false);
    Navigator.pop(context,true);
    bool result=await Navigator.push(context, MaterialPageRoute(builder: (context){
      return TalkUsFragment();

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

  get() async {
    try {

      var response = await http.get(
        Uri.parse('https://app.chickenxpress.co.za/adminpanel/api/v1/Cx_api/getStore'),
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
        jsonArrStoreList=newdata['Data Found'] as List;
        // showMsg(jsonArrImageList.length.toString());

        // print(jsonArrImageList);

      });

    }
    catch(e){
      print(e);
      // Navigator.pop(dialogContext!);
    }


  }
}