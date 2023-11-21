import 'dart:convert';



import 'package:chiken_xpress/screen/talk_us.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_maps_marker/interactive_maps_marker.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'find_us.dart';
import 'follow_us.dart';
import 'online_order.dart';




class StatefulExample extends StatefulWidget {
  @override
  _StatefulExampleState createState() => _StatefulExampleState();
}

class _StatefulExampleState extends State<StatefulExample> {
  List<MarkerItem> markers = [];

  InteractiveMapsController controller = InteractiveMapsController();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/marker.png")
        .then(
          (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }
  @override
  void initState() {
    super.initState();
    addCustomIcon();
    addCustomIcon();
    loadStoreMarkers(); // Call the function to load markers from the API
    fetchStoreInfoData();
  }
  var storeInfoData=[]as List;
  Future<void> fetchStoreInfoData() async {
    List<dynamic> data = await getStoreInfo();
    setState(() {
      storeInfoData = data;
    });
  }

  // Function to load store markers from the API
  void loadStoreMarkers() async {
    try {
      final response = await http.get(
        Uri.parse('https://app.chickenxpress.co.za/adminpanel/api/v1/Cx_api/getStore'),
        // You can add headers here if needed
        // headers: {
        //   'Authorization': 'Bearer $token',
        // },
      );

      if (response.statusCode == 200) {
        final newdata = json.decode(response.body);

        if (newdata.containsKey('Data Found')) {
          final storeList = newdata['Data Found'] as List;
          for (var store in storeList) {
            markers.add(
              MarkerItem(
                id: int.parse(store['id']), // Convert the 'id' to an integer
                latitude: double.parse(store['latitude']),
                longitude: double.parse(store['longitude']),
                // latitude:31.4906504,
                // longitude: 74.319872,
                // You can customize the marker's properties as needed
              ),
            );
          }
          setState(() {
            controller.reset(index: 0);
          });
        } else {
          print('Data not found in the response.');
        }
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error appropriately
    }
  }


  var jsonArrStoreList=[]as List;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'OUR STORES',
          style: TextStyle(
            fontFamily: 'Montserrat_Regular',
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Image.asset('assets/images/new_menu.png', color: Colors.white),
            );
          },
        ),
        backgroundColor: Color(0xffD2232A),
      ),
      body: Stack(
        children: [
          InteractiveMapsMarker(
            items: markers,
            controller: controller,
            center: markers.isNotEmpty
                ? LatLng(markers[0].latitude, markers[0].longitude)
                : LatLng(31.4906504, 74.3531591), // Fallback to a default location
            itemContent: (context, index) {
              MarkerItem item = markers[index];
              if (index < storeInfoData.length) {
                Map<String, dynamic> storeData = storeInfoData[index];
                return BottomTile(
                  item: item,
                  storeName: storeData['store_name'],
                  address: storeData['address'],
                  trading_hours: storeData['trading_hours'],
                  email: storeData['email'],

                );
              } else {
                return Container(); // Handle the case when data is not available
              }
            },
            onLastItem: () {
              print('Last Item');
            },
          ),

          Positioned(
            top: 16.0, // Adjust the position as needed
            right: 16.0, // Adjust the position as needed
            child: GestureDetector(
                onTap: () {
                  // Add your button click action here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindUsFragment()),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: 100.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Button.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(25.0), // Adjust the border radius as needed
                      ),
                    ),
                    Positioned(
                      right: 23.0, // Adjust the value to push the text to the right
                      bottom: 15.0, // Adjust the value to push the text down
                      child: Center(
                        child: Text(
                          'Stores',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
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

}
class BottomTile extends StatelessWidget {
  const BottomTile({
    required this.storeName,
    required this.item,
    required this.address,
    required this.trading_hours,
    required this.email,




  });

  final String storeName;
  final MarkerItem item;
  final String address;
  final String trading_hours;
  final String email;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 120.0,
            height: 120.0,
            color: Colors.red,
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),  // Add padding around the Text widget
                    child: Text(storeName, style: Theme.of(context).textTheme.headline5),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),  // Add padding around the Text widget
                    child: Text("$address ", style: Theme.of(context).textTheme.caption),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),  // Add padding around the Text widget
                    child: Text("${trading_hours}",style: Theme.of(context).textTheme.caption),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(2.0),  // Add padding around the Text widget
                    child: Text("$email",style: Theme.of(context).textTheme.caption),
                  ),
                ],
              ),
            ),
          ),



        ],
      ),
    );
  }


}



Future<List<dynamic>> getStoreInfo() async {
  try {
    final response = await http.get(
      Uri.parse('https://app.chickenxpress.co.za/adminpanel/api/v1/Cx_api/getStore'),
      // You can add headers here if needed
      // headers: {
      //   'Authorization': 'Bearer $token',
      // },
    );

    if (response.statusCode == 200) {
      final newdata = json.decode(response.body);
      print(newdata);

      if (newdata.containsKey('Data Found')) {
        final jsonArrStoreList = newdata['Data Found'] as List;
        return jsonArrStoreList;
      } else {
        print('Data not found in the response.');
      }
    } else {
      print('HTTP request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    // Handle the error appropriately
  }
  return []; // Return an empty list in case of an error or no data
}

