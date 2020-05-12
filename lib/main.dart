import 'package:WeatherApp/Location.dart';
//import 'package:WeatherApp/weaTher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:weather_icons/weather_icons.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Weather(),
    );
  }
}

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var textColor;
  var buttonColor;
  var buttonTextColor;
  var imageBackground;
  var cityName = "";
  var temprature = "";
  var description = "";
  var weatherIconUrl = "";
  var dialog;
  _WeatherState() {
    this._buildThem();
    this._initApp();
  }

  @override
  Widget build(BuildContext context) {
    dialog = ProgressDialog(context, type: ProgressDialogType.Normal);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            //color: Colors.amber,
            constraints: BoxConstraints.expand(),
            child: imageBackground,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
            child: Container(
              constraints: BoxConstraints.expand(),
              //color: Colors.amber,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints.expand(),
                        //color: Colors.yellow,
                        child: ListTile(
                          title: Text(
                            this.cityName,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        //color: Colors.green,
                        child: Card(
                          elevation: 20,
                          shadowColor: textColor,
                          child: Container(
                            //color: Colors.orange,
                            margin: EdgeInsets.only(left: 20),
                            alignment: Alignment.center,
                            child: ListTile(
                              title: Row(
                                children: <Widget>[
                                  Text(
                                    "${this.temprature}",
                                    style: TextStyle(
                                      color: this.textColor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    WeatherIcons.celsius,
                                    color: textColor,
                                    size: 30,
                                  )
                                ],
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  this.description,
                                  style: TextStyle(
                                    color: this.textColor,
                                    //fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              leading: Image.network(
                                this.weatherIconUrl,
                              ),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        // color: Colors.grey,
                        constraints: BoxConstraints.expand(),
                        alignment: Alignment.center,
                        child: RaisedButton(
                          color: buttonColor,
                          onPressed: () {
                            dialog.show();
                            this._initApp();
                          },
                          child: Text(
                            "refresh",
                            style: TextStyle(
                              color: buttonTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _buildThem() {
    var time = DateFormat.yMEd().add_jms().format(DateTime.now());
    if (time.contains("AM")) {
      imageBackground = Image.asset(
        "assets/Daytime.jpg",
        fit: BoxFit.fill,
      );

      textColor = Colors.lime;
      buttonColor = Colors.limeAccent;
      buttonTextColor = Colors.green;
    } else if (time.contains("PM")) {
      imageBackground = Image.asset(
        "assets/Night.jpg",
        fit: BoxFit.fill,
      );
      textColor = Colors.deepPurpleAccent[100];
      buttonColor = Colors.deepPurple[300];
      buttonTextColor = Colors.white;
    }
  }

  Future<void> _initApp() async {
    var x = await controller1().excute();
    if (x != null) {
      dialog.hide();
      setState(() {
        this.cityName = x.getcityName();
        this.description = x.getDescription();
        double a = x.getTemprature();
        this.temprature = a.toInt().toString();
        this.weatherIconUrl = x.getWeatherIconUrl();
      });
    }
  }
}
