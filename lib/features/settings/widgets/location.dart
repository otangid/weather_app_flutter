import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app_flutter/utils/app_util.dart';
import 'package:weather_app_flutter/utils/ext.dart';

class Location extends HookConsumerWidget {
  const Location({super.key, required this.defCity, required this.defLat, required this.devLon, required this.onSaved});
  final String defCity;
  final double defLat, devLon;
  final Function(String city, double lat, double lon) onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isLoading = useState(false);
    var msg = useState('...');
    var lat = useState(defLat);
    var lon = useState(devLon);
    var acc = useState(0);
    var city = useState(defCity);

    void getAddressFromLatLng(Position position) async {
      final latTmp = position.latitude;
      final lonTmp = position.longitude;
      final accTmp = position.accuracy.round();
      var isIntenet = await AppUtil.isNetworkAvailable();
      if (isIntenet) {
        await Geocoding()
            .placemarkFromCoordinates(position.latitude, position.longitude)
            .then((placemarks) {
              final place = placemarks[0];
              final cityTmp = '${place.subLocality}, ${place.locality}';
              isLoading.value = false;
              msg.value = 'Location updated.';
              lat.value = latTmp;
              lon.value = lonTmp;
              acc.value = accTmp;
              city.value = cityTmp;
            })
            .catchError((e) {
              isLoading.value = false;
              msg.value = e.toString();
            });
      } else {
        isLoading.value = false;
        msg.value = 'Can\'t get location info, No internet.';
      }
    }

    void getCurrentPosition() async {
      isLoading.value = true;
      var result = await Permission.locationWhenInUse.status;
      switch (result) {
        case PermissionStatus.restricted:
        case PermissionStatus.provisional:
        case PermissionStatus.permanentlyDenied:
          isLoading.value = false;
          msg.value = 'Location is disabled :(';
          break;
        case PermissionStatus.denied:
          await Permission.locationWhenInUse.request();
          getCurrentPosition();
          break;
        case PermissionStatus.limited:
        case PermissionStatus.granted:
          var position = await Geolocator.getCurrentPosition(
            locationSettings: AndroidSettings(forceLocationManager: true),
          );
          getAddressFromLatLng(position);
          break;
      }
    }

    return Column(
      mainAxisSize: .min,
      children: [
        Text('Location', style: context.textTheme.headlineSmall),
        Container(
          width: double.infinity,
          margin: .only(top: 16, bottom: 8),
          padding: .all(16),
          decoration: BoxDecoration(color: context.colorScheme.surface, borderRadius: .circular(16)),
          child: Column(
            children: isLoading.value
                ? [CircularProgressIndicator()]
                : [
                    Text(city.value, textAlign: .center, style: context.textTheme.titleMedium?.clr(context.primary)),
                    Gap(16),
                    Text('Latitude: ${lat.value}', style: context.textTheme.labelMedium),
                    Text('Longitude: ${lon.value}', style: context.textTheme.labelMedium),
                    Text('Accuracy: ${acc.value} Meters', style: context.textTheme.labelMedium),
                    Gap(16),
                    Text('Status: ${msg.value}'),
                  ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: FilledButton.tonal(
            onPressed: () => getCurrentPosition(),
            // prefix: isLoading.value ? FCircularProgress.loader() : null,
            child: Text('Refresh'),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              onSaved(city.value, lat.value, lon.value);
              context.pop();
            },
            child: Text('Save'),
          ),
        ),
      ],
    );
  }
}
