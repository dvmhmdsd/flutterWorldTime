import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map routeData = {};

  @override
  Widget build(BuildContext context) {
    routeData = routeData.isNotEmpty
        ? routeData
        : ModalRoute.of(context).settings.arguments;

    String bgImage = routeData["isDayTime"] ? 'day.png' : 'night.png';
    Color bgColor = routeData["isDayTime"] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/$bgImage"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.grey[300],
                ),
                label: Text("Choose Location",
                    style: TextStyle(
                      color: Colors.grey[300],
                    )),
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, "/location");
                  routeData = {
                    "time": result["time"],
                    "location": result["location"],
                    "isDayTime": result["isDayTime"],
                  };
                },
              ),
              SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(routeData["location"],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white))
                ],
              ),
              SizedBox(height: 20.0),
              Text(routeData["time"],
                  style: TextStyle(fontSize: 60.0, color: Colors.white))
            ],
          ),
        ),
      )),
    );
  }
}
