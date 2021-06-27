import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havadurumu_app/utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;

  MainScreen(
      {required this.weatherData}); //Request için süslü paranteze alıyorum.

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;
  late String country;
  late String description;

  //Yukarıdaki tanımladığımız değişkenleri weather.dart dosyamızdan getirecek
  void updateDisplayInfo(WeatherData weatherData) {
    //Bu fonksiyonun çalışması için initState metodu içerisine yerleştiriyorum
    //SetState kullanmamın nedeni, veriler anlık olarakda değişebilir.Tanımladığım statik verileri anlık olarak değiştirebilmek için kullandım.

    setState(() {
      temperature = weatherData.currentTemperature.round();
      city = weatherData.city;
      country = weatherData.country;
      description = weatherData.description;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Widget. dediğimde Statefull'da tanımlanan değerlere ulaşıyorum Yani WeatherData 'ya
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, fit: BoxFit.cover),
            border: Border.all(color: Colors.black26, width: 5)),
        child: Center(
          child: Container(
            width: 300,
            height: 350,
            decoration: BoxDecoration(
              color: Colors.white38,
            ),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  Container(child: weatherDisplayIcon),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "${temperature}°",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 80.0,
                          letterSpacing: -5),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      "P l a c e  :  ${city} - ${country} ",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 30.0,
                          letterSpacing: -5),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      "Description:${description}",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
