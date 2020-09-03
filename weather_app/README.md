# Flutter Weather App
### What the App does
This app has a user interface which a user can enter the name of a city and will get the temperature, the state of the weather, the wind speed, and the humidity of the city.

### Fetching data from the internet
Data was fetched from the internet using an API. The website for the API used is shown below:

https://www.metaweather.com/api/


### Dependencies
Below is a table of the dependencies used in the app.

| Dependencies |
| --- |
| import 'package:flutter/material.dart'; |
| import 'package:flutter/rendering.dart'; |
| import 'dart:async'; |
| import 'dart:convert'; |
| import 'package:font_awesome_flutter/font_awesome_flutter.dart'; |
| import 'package:http/http.dart'; |
| import 'dart:math'; |

### The variables and functions used in the design
The class ** Home ** is a ** StatefulWidget **. The class ** _HomeState ** inherits the properties of the StatefulWidget. ** _HomeState ** has the properties temp(temperature), windSpeed, humidity, woeid(where on earth id) which have integer data types, and weather, location, serachCityUrl, and tempWeatherUrl which have string data types. Because temp, weather, windSpeed, humidity, location, and woeid are properties that change during run-time, they are placed inside a ** setState ** function.

** fetchCity ** is the location search function which is an asynchronous function.

** fetchWeather ** is the temperature and weather search function which is asynchronous.

While waiting for data to be displayed on the screen, a circular progress indicator is displayed on the screen until the data is displayed. The following code shows this
```javascript
body: temp ==null ? Center(child: CircularProgressIndicator()):
```

The function below calls the two async functions ** fetchCity ** and ** fetchWeather **:
```javascript
  void onTextFieldSubmitted(String input) async{
    await fetchCity(input);
    await fetchWeather();
  }
```
### Building the layout and managing states
A ** Scaffold ** widget was used to provide a framework to implement the basic material design layout structure for the app.

An ** AppBar ** widget was used to create the App Bar. A Text widget was used for the text, "Weather App", in the App Bar.

Below the app bar is the area called the ** body ** property. The body is separated into a ** Container ** widget and a ** ListView ** widget.

The ** Container ** widget is ** 1/5 ** the height of the body but it spans the entire width. The ** Container ** contains three ** Text ** widgets separated by three columns. These Text widgets contain the ** location(city name) **, the ** temperature ** in Fahrenheit, and ** currently **.

The ** ListView ** widget is ** 4/5 ** the height of the body but it spans the entire width. The ** ListView ** contains four ** ListTyle ** widgets and a ** Container ** widget below the ** ListTyles **. The ** ListTyles ** contain the ** Temperature **, ** Weather **, ** Humidity **, and the ** Wind Speed **. The ** Container ** widget has a ** TextField ** widget which has a ** hintText which has the words, ** "Search another location..." **.





