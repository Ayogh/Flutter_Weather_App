import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'dart:math';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));
//https://pub.dev/packages/http#-installing-tab-
//https://pub.dev/packages/font_awesome_flutter#-installing-tab-
//https://openweathermap.org/
//e1a6d08738dc0bb713ce73a61026f6ce
//api.openweathermap.org/data/2.5/weather?q={city name}&appid={your api key}
//http://api.openweathermap.org/data/2.5/weather?q=North%20Carolina&appid=e1a6d08738dc0bb713ce73a61026f6ce

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int temp;
  int windSpeed;
  int humidity;
  String weather = '';
  String abbreviation = '';
  String location = "San Francisco";
  int woeid = 2487956;
  String searchCityUrl =
      "https://www.metaweather.com/api/location/search/?query="; //url where we get data from. The city name is passed to the query
  String tempWeatherUrl = "https://www.metaweather.com/api/location/";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeather();
  }

  //function to search the "city" name and its "woeid" using the url
  void fetchCity(String city) async {
    var searchResult = await get(
        searchCityUrl + city); //returns info of a given city like name & woeid.
    var result = json.decode(searchResult.body)[0];

    setState(() {
      location = result["title"]; //name of city
      woeid = result["woeid"]; //
    });
  }

  //function to get the temperature and the weather for a given city
  void fetchWeather() async {
    var locationSearch = await get(tempWeatherUrl +
        woeid
            .toString()); //returns weather info of a given city like temperature and weather.
    var result = json.decode(locationSearch.body);
    var consolidated_weather = result["consolidated_weather"];
    var data = consolidated_weather[0];

    setState(() {
      temp = data["the_temp"].round() * 2 + 32 -8 ;
      weather = data["weather_state_name"];
      windSpeed = data["wind_speed"].round();
      humidity = data["humidity"].round();
      //abbreviation = data["weather_state_abbr"];
    });
  }

  void onTextFieldSubmitted(String input) async{
    await fetchCity(input);
    await fetchWeather();
  }

  //function to search a  city
  //------ Start-----------------------------------------//

//  var temp;
//  var description;
//  var currently;
//  var humidity;
//  var windSpeed;
//
//  Future getWeather() async {
//    Response response = await get("http://api.openweathermap.org/data/2.5/weather?q=North%20Carolina&appid=e1a6d08738dc0bb713ce73a61026f6ce");
//    var results = jsonDecode(response.body);
//    setState(() {
//      this.temp = results['main']['temp'];
//      this.description = results['weather'][0]['description'];
//      this.currently = results['weather'][0]['main'];
//      this.humidity = results['main']['humidity'];
//      this.windSpeed = results['wind']['speed'];
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    this.getWeather();
//  }

//-----------------End --------------------------------------------------//
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Weather App",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              //backgroundColor: Colors.blue[900],
              letterSpacing: 2.0,
              fontSize: 25.0),
        ),
      ),
      body: temp ==null ? Center(child: CircularProgressIndicator()):Column(
        //Below is a List or Array of items. I will call it List 1
        children: <Widget>[
          //Container is item 1 in List 1 which makes the first column
          Container(
            //The Container takes 1/5 of the height of the Column
            //Below are the properties and structure of the Container
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            color: Colors.red[900],
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: NetworkImage('https://images.unsplash.com/photo-1446776709462-d6b525c57bd3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'),
//                fit: BoxFit.cover,
//              ),
//            ),

            //The Container is divided into 5 columns as shown below.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              //Below is a List or Array of items. I will call it List 2
              children: <Widget>[
                //Column 1 is item 1 inside List 2
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    location,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                //Column 2 is item 2 inside List 2
                Text(
                  temp != null ? temp.toString() + "\u00B0" + "F" : "Loading",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                ),

                //Column 3 is item 3 inside List 2
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "currently", //currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Below is item 2 in List 1 which makes the second column
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null
                        ? temp.toString() + "\u00B0" + "F"
                        : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(weather),
                  ),

                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString() + "%" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windSpeed != null ? windSpeed.toString() + " mph" : "Loading"),
                  ),
                  //--Start-------
                  //SizedBox(height: 40,),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        child: TextField(
                          onSubmitted: (String input) {
                            onTextFieldSubmitted(input);
                          },
                          style: TextStyle(color: Colors.red, fontSize: 25),
                          decoration: InputDecoration(
                            hintText: 'Search another location...',
                            hintStyle:
                                TextStyle(color: Colors.red, fontSize: 18.0),
                            prefixIcon: Icon(Icons.search, color: Colors.red),
                          ),
                        ),
                      )
                    ],
                  )
                  //---End
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
