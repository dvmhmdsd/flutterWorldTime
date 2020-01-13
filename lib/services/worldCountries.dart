import 'package:http/http.dart';
import 'dart:convert';

class WorldCountries {
  List countries; // all countries
  Map country; // single country

  Future<void> getAllCountries() async {
    Response response = await get("https://restcountries.eu/rest/v2/all");
    countries = jsonDecode(response.body);
  }

  Future<void> getSingleCountry(capital) async {
    Response response =
        await get("https://restcountries.eu/rest/v2/capital/$capital");
    country = jsonDecode(response.body)[0];
  }
}
