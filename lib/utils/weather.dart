//APİ'den veri çekme işlemlerini bu dosyada yapıyorum
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';

const apiKey = "e3b38a052b6e7df50b23c259a6eb3648";

class WeatherDisplayData {
  //Ekranda görüntülenecek verileri bu class tutacak.
  late Icon weatherIcon;
  late AssetImage weatherImage;
  late String city;
  late String description;
  late String country;
  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData(
      {required this.locationData}); //Parametreyle gelen locationData nesnesini bu sayfada tanımlanan locationData nesnesine atar.
  LocationHelper locationData;
  late double currentTemperature;
  late int currentCondition;
  late String city;
  late String country;
  late String description;
  //Yukarıdaki tanımlanan değişkenlerin bilgilerini APİ'den alacağım.
  //APİ'den veri çekerken yüklediğim http package'ini kullanacağım.

  Future<void> getCurrentTemperature() async {
    //Gelen kullanıcı konumlarına göre verilen location bilgilerini yerleştiriyoruz
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body; // Tüm APİ'den gelen bilgileri al
      var currentWeather =
          jsonDecode(data); // APİ'den gelen tüm nesne bunun içerisinde
      //APİ'den gelen verilerin tipi JSON, bunları Decode ediyorum

      //Decode ederken hata oluşursa try-cache'de yakalayacağız.
      try {
        currentTemperature = currentWeather["main"]["temp"];
        currentCondition = currentWeather["weather"][0]["id"];
        city = currentWeather["name"];
        country = currentWeather["sys"]["country"];
        description = currentWeather["weather"][0]["description"];
      } catch (e) {
        print(e);
      }
    } else {
      print("APİ'den değer gelmiyor. ");
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    var now = new DateTime.now(); //Telefonun saatini aldık.
    if (now.hour >= 19) {
      return WeatherDisplayData(
          weatherIcon:
              Icon(FontAwesomeIcons.moon, size: 75.0, color: Colors.black45),
          weatherImage: AssetImage("assets/gece.png"));
    } else {
      return WeatherDisplayData(
          weatherIcon: Icon(FontAwesomeIcons.solidSun,
              size: 75.0, color: Colors.black45),
          weatherImage: AssetImage("assets/gunesli.png"));
    }
  }
}
