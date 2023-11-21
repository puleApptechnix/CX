import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
var api='AIzaSyBrkOgTUNuFCWfPfC-LPNqUsmIog3tB3Wo';

class MapUtils{
  MapUtils._();

  static Future<void> openMap(double lat,double lng) async {
    String url = '';



    var uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
    }

/*
  static Future<void> openMap(double latitude, double longitude) async {
    // String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    String googleUrl='comgooglemaps://?center=${latitude},${longitude}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw Exception('Could not open the map.');
    }
  }
*/

}