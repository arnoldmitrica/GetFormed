import 'package:flutter/material.dart';
import 'package:location/location.dart';
//import 'package:mi_card/components/utils/locationDataModel.dart' as LocationDta;
import 'package:mi_card/components/utils/ViewModel.dart';
import 'package:provider/provider.dart';

class GetLocation extends StatefulWidget {
  GetLocation({Key key}) : super(key: key);

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  bool _isLoading = false;
  String _locationAltitudeLongitude;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width / 8),
        child: Builder(builder: (locationContext) {
          print("Locatiooooon");
          final form =
              Provider.of<ViewModel>(locationContext, listen: false).model;
          _locationAltitudeLongitude = form.values["location"];
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _getLocation();
                  },
                  child: Text("Get location"),
                ),
                _isLoading == true ? CircularProgressIndicator() : Text(""),
                _locationAltitudeLongitude == null
                    ? Text("No location")
                    : Text(_locationAltitudeLongitude)
              ]);
        }));
  }

  _getLocation() async {
    _isLoading = true;
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    try {
      _locationData = await location.getLocation().then((val) {
        return val;
      });

      //return (onValue.latitude.toString() + "," + onValue.longitude.toString());
      print(_locationData);
      //return _locationData;
    } catch (e) {
      print(e.code);
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
      _locationData = null;
    }

    setState(() {
      _locationAltitudeLongitude = (_locationData.latitude).toString() +
          (_locationData.longitude).toString();
      Provider.of<ViewModel>(context, listen: false)
          .updateCompletePercentState("location", _locationAltitudeLongitude);
      _isLoading = false;
    });
  }
}
