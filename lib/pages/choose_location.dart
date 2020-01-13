import 'package:flutter/material.dart';
import 'package:worldtime/services/worldtime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:worldtime/services/worldCountries.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [];

  bool loading = true;

  void setupLocations() async {
    WorldCountries countriesObject = WorldCountries();

    await countriesObject.getAllCountries();

    setState(() {
      loading = false;
    });

    try {
      for (final country in countriesObject.countries) {
        locations.add(WorldTime(
            location: country["capital"],
            url: "/${country["region"]}/${country["capital"]}"));
      }
    } catch (e) {
      print("image");
    }
  }

  void updateTime(index) async {
    WorldTime timeObject = locations[index];
    await timeObject.getTime();

    Navigator.pop(context, {
      "location": timeObject.location,
      "time": timeObject.time,
      "isDayTime": timeObject.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    setupLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          elevation: 0,
          title: Text("Choose a location"),
          centerTitle: true,
        ),
        body: loading
            ? SpinKitRing(
                color: Colors.blue[900],
                size: 60.0,
              )
            : Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: onSearchTextChanged,
                      cursorColor: Colors.blue[900],
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        labelText: 'Search for a location',
                        icon: Icon(Icons.search),
                        contentPadding: EdgeInsets.all(5.0),
                      ),
                    ),
                  ),
                  // add expanded to avoid the "Vertical viewport was given unbounded height." error
                  Expanded(
                    child: ListView.builder(
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 4.0),
                            child: Card(
                                child: ListTile(
                              onTap: () {
                                updateTime(index);
                              },
                              title: Text(locations[index].location),
                            )));
                      },
                    ),
                  ),
                ],
              ));
  }

  onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    var toRemove = [];

    locations.forEach((location) {
      if (location.location.toLowerCase().contains(text.toLowerCase()))
        // locations.remove(location);
        // locations.insert(0, locationClone);
        toRemove.add(location);
    });

    toRemove.forEach((item) {
      WorldTime locationClone = item;
      locations.remove(item);
      locations.insert(0, locationClone);
    });

    setState(() {});
  }
}
