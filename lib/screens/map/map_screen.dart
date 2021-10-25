// import 'package:mxc_mapper/responsive.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '../../constants.dart';

final String assetName = 'icons/menu_gateway.svg';
final Widget svgIcon = SvgPicture.asset(assetName,
    color: Colors.black, semanticsLabel: 'A red up arrow');

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
        plugins: [
          MarkerClusterPlugin(),
        ],
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/mxcdatadash/cktsdcfr911cq18pkhd7hvm06/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibXhjZGF0YWRhc2giLCJhIjoiY2s5bnc4dmh4MDBiMDNnbnczamRoN2ExeCJ9.sq0w8DGDXpA_6AMoejYaUw",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoibXhjZGF0YWRhc2giLCJhIjoiY2s5bnc4dmh4MDBiMDNnbnczamRoN2ExeCJ9.sq0w8DGDXpA_6AMoejYaUw',
            'id': 'mapbox.mapbox-streets-v8',
          },
          attributionBuilder: (_) {
            return Text("© OpenStreetMap contributors");
          },
        ),
        MarkerClusterLayerOptions(
          maxClusterRadius: 120,
          size: Size(40, 40),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                child: svgIcon,
              ),
            ),
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.10),
              builder: (ctx) => Container(
                child: svgIcon,
              ),
            ),
          ],
          polygonOptions: PolygonOptions(
              borderColor: Colors.blueAccent,
              color: Colors.black12,
              borderStrokeWidth: 3),
          builder: (context, markers) {
            return FloatingActionButton(
              child: Text(markers.length.toString()),
              onPressed: null,
            );
          },
        ),
      ],
    ));
  }
}
