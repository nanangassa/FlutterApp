import 'package:flutter/material.dart';
import 'package:forecanvass/model/PersonModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:async';
import 'package:location/location.dart' as LocationManager;

class Map extends StatefulWidget {
  final List<Person> peopleList;
  Map(this.peopleList, {Key key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  List<LatLng> coordinates = List<LatLng>();

  static final CameraPosition college = CameraPosition(
      target: LatLng(45.349520, -75.755720), zoom: 13.151926040649414);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: new Stack(children: <Widget>[
        new CustomPaint(
          size: new Size(width, height),
        ),
        new Scaffold(
          appBar: AppBar(
            title: Text("Map"),
          ),
          body: new Center(
            child: GoogleMap(
              initialCameraPosition: college,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              
              mapType: MapType.satellite,
              myLocationEnabled: true,
              compassEnabled: true,
              trackCameraPosition: true,
              zoomGesturesEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
            ),
          ),

          /*force new thread to populate map ,avoid 
          too much load on main thread bug*/
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            onPressed: _onMapCreated,
            label: Text('Load !'),
          ),
        ),
      ]),
    );
  }

  Future<void> _onMapCreated() async {
    var address;
    for (int i = 0; i < widget.peopleList.length; ++i) {
      address = await Geocoder.local.findAddressesFromQuery(
          widget.peopleList[i].streetNumber.toString() +
              widget.peopleList[i].streetName);
      coordinates.add(new LatLng(address.first.coordinates.latitude,
          address.first.coordinates.longitude));
    }
    load();
  }

  Future<void> load() async {
    final GoogleMapController mapController = await _controller.future;
    final location = await getUserLocation();

    for (var i = 0; i < widget.peopleList.length; ++i) {
      LatLng latlng = LatLng(coordinates[i].latitude, coordinates[i].longitude);
      InfoWindowText locationsName = InfoWindowText(
          widget.peopleList[i].firstName, widget.peopleList[i].lastName);
      mapController.addMarker(
        MarkerOptions(
            position: latlng,
            infoWindowText: locationsName,
            zIndex: i.toDouble()),
      );
    }

    InfoWindowText locationName = InfoWindowText("You", "are here");
    mapController.addMarker(
      MarkerOptions(
        position: location,
        infoWindowText: locationName,
      ),
    );
    mapController.animateCamera(CameraUpdate.newLatLngZoom(location, 13));
    // mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //    target: LatLng(location.latitude, location.longitude), zoom: 13.0)));
  }

  Future<LatLng> getUserLocation() async {
    var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation["latitude"];
      final lng = currentLocation["longitude"];
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }
}
