//İnternetten bir dosya okuyacağımız için veriler anında gelmeyecek Bir sürü bekleme anı olacak bekleme anında bu sayfanın gözükmesini sağlıcaz

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:havadurumu_app/screens/main_screen.dart';
import 'package:havadurumu_app/utils/location.dart';
import 'package:havadurumu_app/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      print("Konum bilgileri gelmiyor..");
    } else {
      print("latitude: " + locationData.latitude.toString());
      print("longitude: " + locationData.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData(); //Önce location bilgisinin alınmasını bekle
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData
        .getCurrentTemperature(); //WeatherData İçerisinde oanki sıcaklık ve o ankı durum bilgisi vardı
    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print("APİ'den sıcaklık veya durum bilgisi boş dönüyor");
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MainScreen(
          weatherData: weatherData,
        );
      }));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white38, Colors.black26])),
      child: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 150.0,
          duration: Duration(milliseconds: 1200),
        ),
      ),
    ));
  }
}
