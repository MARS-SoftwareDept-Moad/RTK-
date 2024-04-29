import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

import '../../../../shared/components/loading_indicator.dart';
import '../../../../shared/state/general_provider.dart';
import 'build_attribution.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());

  @override
  Widget build(BuildContext context) => Consumer<GeneralProvider>(
        builder: (context, provider, _) => FutureBuilder<Map<String, String>?>(
          future: provider.currentStore == null
              ? Future.sync(() => {})
              : FMTC.instance(provider.currentStore!).metadata.readAsync,
          builder: (context, metadata) {
            if (!metadata.hasData ||
                metadata.data == null ||
                (provider.currentStore != null && metadata.data!.isEmpty)) {
              return const LoadingIndicator(
                message:
                    'Loading Settings...\n\nSeeing this screen for a long time?\nThere may be a misconfiguration of the\nstore. Try disabling caching and deleting\n faulty stores.',
              );
            }

            final String urlTemplate =
                provider.currentStore != null && metadata.data != null
                    ? metadata.data!['sourceURL']!
                    : 'http://mt0.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}';

            return FlutterMap(
              options: MapOptions(
                center: const LatLng(51.509364, -0.128928),
                zoom: 9.2,
                maxBounds: LatLngBounds.fromPoints([
                  const LatLng(-90, 180),
                  const LatLng(90, 180),
                  const LatLng(90, -180),
                  const LatLng(-90, -180),
                ]),
                interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                keepAlive: true,
              ),
              // nonRotatedChildren: buildStdAttribution(urlTemplate),
              children: [
                TileLayer(
                  urlTemplate: urlTemplate,
                  tileProvider: provider.currentStore != null
                      ? FMTC.instance(provider.currentStore!).getTileProvider(
                            FMTCTileProviderSettings(
                              behavior: CacheBehavior.values
                                  .byName(metadata.data!['behaviour']!),
                              cachedValidDuration: int.parse(
                                        metadata.data!['validDuration']!,
                                      ) ==
                                      0
                                  ? Duration.zero
                                  : Duration(
                                      days: int.parse(
                                        metadata.data!['validDuration']!,
                                      ),
                                    ),
                            ),
                          )
                      : NetworkTileProvider(),
                  maxZoom: 20,
                  userAgentPackageName: 'dev.org.fmtc.example.app',
                  keepBuffer: 5,
                  backgroundColor: const Color(0xFFaad3df),
                ),
                AnimatedMarkerLayer(
                  markers: [
                    AnimatedMarker(
                      width: 30,
                      height: 30,
                      point: LatLng(_connectionService.current_Packet.Latitude,
                          _connectionService.current_Packet.Longitude),
                      builder: (context, animation) {
                        // Add animation parameter
                        return Center(
                          child: Transform.rotate(
                            angle: 0 * pi / 180,
                            child: const Icon(
                              Icons.pin_drop,
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
}
