//screen to show Marvel characters on map with clusters

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marvel_app/data/dto/character_position.dart';
import 'package:marvel_app/presentation/screen/character_detail_screen.dart';
import 'package:marvel_app/presentation/viewmodel/maps_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../data/dto/character_position.dart';
import '../../data/dto/place.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return MapsViewModel.buildWithProvider(
        builder: (_, __) => const MapsContent());
  }
}

class MapsContent extends StatefulWidget {
  const MapsContent({Key? key}) : super(key: key);

  @override
  _MapsContentState createState() => _MapsContentState();
}

class _MapsContentState extends State<MapsContent> {
  late ClusterManager _manager;

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = Set<Marker>();

  final CameraPosition _europeCameraPosition =
      CameraPosition(target: LatLng(48.856614, 2.3522219), zoom: 3);

  final Paint _paint1 = Paint()..color = Colors.orange;
  final Paint _paint2 = Paint()..color = Colors.white;
  late PictureRecorder _pictureRecorder;
  late Canvas _canvas;

  @override
  void initState() {
    _manager = _initClusterManager();
    super.initState();
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<Place>([], _updateMarkers,
        markerBuilder: _markerBuilder);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapsViewModel>(
      builder: (_, viewModel, __) {
        _manager.setItems(viewModel.places);
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _europeCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    _manager.setMapId(controller.mapId);
                  },
                  markers: _markers,
                  onCameraMove: _manager.onCameraMove,
                  onCameraIdle: _manager.updateMap,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: FloatingActionButton(
                    onPressed: () {
                      _controller.future.then((value) {
                        value.animateCamera(
                          CameraUpdate.newCameraPosition(_europeCameraPosition),
                        );
                      });
                    },
                    child: const Icon(Icons.my_location),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _updateMarkers(Set<Marker> markers) async {
    setState(() {
      _markers = markers;
    });
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
            cluster.items.forEach((p) => print(p));
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }
}
