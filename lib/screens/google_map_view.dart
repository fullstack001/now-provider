import 'dart:async';

import 'package:fare_now_provider/util/api_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  GoogleMapView({Key? key}) : super(key: key);

  @override
  _GoogleMapViewState createState() => _GoogleMapViewState();
}

/*
https://maps.googleapis.com/maps/api/staticmap?zoom=8&size=600x300&maptype=roadmap&
markers=color:red%7Clabel:E%7C6.5212402,3.3679965&
markers=color:blue%7Clabel:C%7C6.849660,3.648190
&key=AIzaSyDM06VJYrW1xHW4F4zvL1Bt4lgcF7YgZ7U



 */
//  6.5212402,3.3679965
//  6.849660,3.648190
// Starting point latitude
double originLatitude = 6.5212402;
// Starting point longitude
double originLongitude = 3.3679965;
// Destination latitude
double destLatitude = 6.849660;
// Destination Longitude
double destLongitude = 3.648190;
// Markers to show points on the map
Map<MarkerId, Marker> markers = {};

PolylinePoints polylinePoints = PolylinePoints();
Map<PolylineId, Polyline> polylines = {};

class _GoogleMapViewState extends State<GoogleMapView> {
  // Google Maps controller
  Completer<GoogleMapController> _controller = Completer();

  // Configure map position and zoom
  var _kGooglePlex;

  double getCenterLatLong(LatLng latLng1, LatLng latLng2, lat) {
    double midLat, midLong;

    // Calculating midLat
    int coefficient = 1;

    if ((latLng1.latitude > 90 && latLng2.latitude < -90) ||
        (latLng2.latitude > 90 && latLng1.latitude < -90)) {
      midLat = 180 - ((latLng1.latitude - latLng2.latitude) / 2).abs();
      // If output will be in the 1st quartile then co-ef will remain 1, if in 4th then it will be -1
      if ((latLng1.latitude < 0 &&
              latLng1.latitude.abs() < latLng2.latitude.abs()) ||
          (latLng2.latitude < 0 &&
              latLng2.latitude.abs() < latLng1.latitude.abs()))
        coefficient = -1;
      // Applying coefficient
      midLat *= coefficient;
    } else
      midLat = (latLng2.latitude + latLng1.latitude) / 2;

    // Calculating midLong
    coefficient = 1;

    if ((latLng1.longitude > 90 && latLng2.longitude < -90) ||
        (latLng2.longitude > 90 && latLng1.longitude < -90)) {
      midLong =
          180 - ((latLng1.longitude.abs() - latLng2.longitude.abs()) / 2).abs();
      // If output will be in the 1st quartile then co-ef will remain 1, if in 4th then it will be -1
      if ((latLng1.longitude < 0 &&
              latLng1.longitude.abs() < latLng2.longitude.abs()) ||
          (latLng2.longitude < 0 &&
              latLng2.longitude.abs() < latLng1.longitude.abs()))
        coefficient = -1;

      // Applying coefficient
      midLong *= coefficient;
    } else
      midLong = (latLng2.longitude + latLng1.longitude) / 2;

    if (lat) {
      return midLat;
    }

    return midLong;
  }

  @override
  void initState() {
    /// add origin marker origin marker
    ///
    _kGooglePlex = CameraPosition(
      target: LatLng(
          getCenterLatLong(LatLng(originLatitude, originLongitude),
              LatLng(destLatitude, destLongitude), true),
          getCenterLatLong(LatLng(originLatitude, originLongitude),
              LatLng(destLatitude, destLongitude), false)),
      zoom: 8,
    );
    _addMarker(
      LatLng(originLatitude, originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

/*

    _addMarker(
      LatLng(
          getCenterLatLong(LatLng(originLatitude, originLongitude),
              LatLng(destLatitude, destLongitude), true),
          getCenterLatLong(LatLng(originLatitude, originLongitude),
              LatLng(destLatitude, destLongitude), false)),
      "center",
      BitmapDescriptor.defaultMarkerWithHue(50),
    );

*/

    // Add destination marker
    _addMarker(
      LatLng(destLatitude, destLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    _getPolyline();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("origin: $originLatitude,$originLongitude\n");
    print("destination: $destLatitude,$destLongitude");
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        zoomControlsEnabled: false,
        scrollGesturesEnabled: false,
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          ..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
        minMaxZoomPreference: MinMaxZoomPreference(10.5, 36),
        zoomGesturesEnabled: true,
        polylines: Set<Polyline>.of(polylines.values),
        markers: Set<Marker>.of(markers.values),
        onTap: (value) {
          print("$value");
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  // This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      ApiUtills.mapKey,
      PointLatLng(originLatitude, originLongitude),
      PointLatLng(destLatitude, destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
}
