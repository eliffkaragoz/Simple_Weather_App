import 'package:location/location.dart';

class LocationHelper {
  late double latitude; //enlem
  late double longitude; //boylam

  Future<void> getCurrentLocation() async {
    Location location =
        Location(); //Yüklediğimiz location package'inden bir nesne oluşturuyoruz.
    bool _serviceEnabled; //Servis ayakta mı?
    PermissionStatus _permissionGrandted; //İzin verildi mi ?
    LocationData
        _locationdata; //Locationumuzun dolu olup olmadığını takip etmek için

    //Location için servis ayakta mı?
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    //konum izni kontrolü ? Kullanıcı konum bilgisi için izin vermiş mi ?
    _permissionGrandted = await location.hasPermission();
    if (_permissionGrandted == PermissionStatus.denied) {
      _permissionGrandted = await location.requestPermission();
      if (_permissionGrandted != PermissionStatus.granted) {
        return;
      }
    }

    //İzinler tamam ise; Yani servisler ayakta ise
    _locationdata = await location.getLocation();
    latitude = _locationdata.latitude!;
    longitude = _locationdata.longitude!;
  }
}
