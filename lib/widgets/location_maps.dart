import 'package:url_launcher/url_launcher.dart';

class LocationMaps{
  LocationMaps._();

  static Future<void> openMaps(double latitude, double longitude) async{
      String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&mode=d';
      if(await canLaunch(googleUrl)){
        await launch(googleUrl);
      }else{
        throw 'Could not open google maps for the location ${googleUrl.toString()}';
      }
  }
}
