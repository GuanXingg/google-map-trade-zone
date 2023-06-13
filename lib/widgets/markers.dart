import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker currentMarker(LatLng pos) => Marker(markerId: const MarkerId('pos-current'), position: pos);
