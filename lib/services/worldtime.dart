import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';


class WorldTime {
  String location;
  String time;
  String url;

  bool isDayTime;

  WorldTime({ this.location, this.url });

  Future<void> getTime() async {
    try {
      Response response = await get("http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);

      // get offset and datetime
      String datetime = data["utc_datetime"];
      String offset = data["utc_offset"].substring(1, 3);

      // create datetime object
      DateTime now = DateTime.parse(datetime);

      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      time = DateFormat.jm().format(now);

      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;  
    } 
    catch (e) {
      time = "can not get data";
    }
  }

}
