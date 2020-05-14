import 'package:geolocator/geolocator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class WeatherModel {
  var cityName;
  var latitude;
  var longtude;
  var temprature;
  var description;
  var weatherIconUrl;

  getcityName() {
    return cityName;
  }

  getlatitude() {
    return latitude;
  }

  getlongtude() {
    return longtude;
  }

  getTemprature() {
    return temprature;
  }

  getDescription() {
    return description;
  }

  getWeatherIconUrl() {
    return weatherIconUrl;
  }
}

class Controller1{
  var _apiKey = "ee645b76d49faa05ff41d046c4e0d999";
  var _apiUrl;

  Future<WeatherModel> excute() async {
    var k = WeatherModel();
    var _position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    k.longtude = _position.longitude;
    k.latitude = _position.latitude;

    this._apiUrl =
        "http://api.openweathermap.org/data/2.5/weather?lat=${k.getlatitude()}&lon=${k.getlongtude()}&appid=${this._apiKey}&units=metric";

    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(k.latitude, k.longtude);

    k.cityName = placemark[0].locality;

    var response = await http.get(this._apiUrl);
    print(response.body);
    var json = convert.jsonDecode(response.body);

    var weatherIcon = json["weather"][0]["icon"];

    k.description = json["weather"][0]["description"];
    k.temprature = json["main"]["temp"];
    k.weatherIconUrl = "http://openweathermap.org/img/wn/$weatherIcon.png";

    return k;
  }
}
