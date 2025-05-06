// 기관 지도 보여주는 화면
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class InstitutionMap extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String name;

  const InstitutionMap({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$name 위치')),
      body: NaverMap(
        options: NaverMapViewOptions(
          initialCameraPosition: NCameraPosition(
            target: NLatLng(latitude, longitude),
            zoom: 16,
          ),
        ),
        onMapReady: (controller) {
          final marker = NMarker(
            id: 'institution',
            position: NLatLng(latitude, longitude),
          );
          controller.addOverlay(marker);
        },
      ),
    );
  }
}
