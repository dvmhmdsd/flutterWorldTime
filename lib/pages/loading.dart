import 'package:flutter/material.dart';
import 'package:worldtime/services/worldtime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:worldtime/services/worldCountries.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    // instanitiate the world countries class
    WorldCountries countriesObject = WorldCountries();

    // get a single country
    await countriesObject.getSingleCountry("Cairo");

    WorldTime timeObject = WorldTime(
        location: countriesObject.country["capital"],
        url:
            "/${countriesObject.country["region"]}/${countriesObject.country["capital"]}");
    await timeObject.getTime();

    // redirect to the home screen
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      "location": timeObject.location,
      "time": timeObject.time,
      "isDayTime": timeObject.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: SpinKitRing(
              color: Colors.white,
              size: 60.0,
            )));
  }
}
