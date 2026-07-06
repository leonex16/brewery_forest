import 'package:brewery_forest/core/domain/brewery.dart';
import 'package:brewery_forest/features/020_feed/application/feed_cubit.dart';
import 'package:brewery_forest/features/020_feed/presentation/widgets/search_area_pill.dart';
import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' hide Position;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class FeedMap extends StatefulWidget {
  const FeedMap({super.key});

  @override
  State<FeedMap> createState() => _FeedMapState();
}

class _FeedMapState extends State<FeedMap> {
  final _fallback = Position(-79.3832, 43.6532);
  final _viewport = ViewportController();
  MapboxMap? _map;
  Brightness? _brightness;

  bool _showSearchArea = false;
  GeoCoordinates? _lastCentered;

  CircleAnnotationManager? _markers;
  late ColorScheme _colors;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final b = Theme.of(context).brightness;

    if (_brightness != null && _brightness != b) {
      _map?.loadStyleURI(_styleFor(b));
    }

    _brightness = b;
    _colors = context.colors;
  }

  @override
  void dispose() {
    _viewport.dispose();
    super.dispose();
  }

  String _styleFor(Brightness b) =>
      b == Brightness.dark ? MapboxStyles.DARK : MapboxStyles.LIGHT;

  Future<void> _onMapCreated(MapboxMap map) async {
    _map = map;
    _markers = await map.annotations.createCircleAnnotationManager();
    _markers?.tapEvents(onTap: _onMarkerTap);

    if (mounted == false) return;

    _renderMarkers(context.read<FeedCubit>().state);
  }

  Future<void> _onStyleLoaded(StyleLoadedEventData _) async {
    _markers = await _map?.annotations.createCircleAnnotationManager();
    _markers?.tapEvents(onTap: _onMarkerTap);
    if (!mounted) return;
    _renderMarkers(context.read<FeedCubit>().state);
  }

  void _onMarkerTap(CircleAnnotation annotation) {
    final id = annotation.customData?['brewery_id'] as String?;
    final state = context.read<FeedCubit>().state;
    if (id == null || state is! FeedOk) return;
    final match = state.breweries.where((b) => b.id == id).firstOrNull;
    if (match == null) return;
    context.read<FeedCubit>().selectBrewery(match);
  }

  Future<void> _renderMarkers(FeedState state) async {
    final m = _markers;

    if (m == null || state is! FeedOk) return;

    await m.deleteAll();

    final futureMarkers = <Future<CircleAnnotation>>[];
    for (final b in state.breweries) {
      final (bgColor, strokeColor) = (
        _colors.primary.toARGB32(),
        _colors.surface.toARGB32(),
      );
      final data = {'brewery_id': b.id};

      final marker = m.create(
        CircleAnnotationOptions(
          geometry: b.address.coordinates.toPoint(),
          circleColor: bgColor,
          circleStrokeColor: strokeColor,
          customData: data,
          circleRadius: 8,
          circleStrokeWidth: 2,
        ),
      );

      futureMarkers.add(marker);
    }

    await Future.wait(futureMarkers);

    final userPosition = state.userPosition;

    if (userPosition == null) return;

    await m.create(
      CircleAnnotationOptions(
        geometry: Point(coordinates: userPosition.toPosition()),
        circleColor: _colors.secondary.toARGB32(),
        circleStrokeColor: _colors.surface.toARGB32(),
        circleRadius: 10,
        circleStrokeWidth: 2,
      ),
    );
  }

  void _onFeedChanged(BuildContext _, FeedState state) {
    _renderMarkers(state);
    final target = (state is FeedOk)
        ? state.userPosition ?? state.breweries.firstOrNull?.address.coordinates
        : null;
    if (target == null || identical(target, _lastCentered)) return;
    _lastCentered = target;
    _viewport.moveTo(CameraViewportState(center: target.toPoint()));
  }

  Future<void> _onMapIdle(MapIdleEventData _) async {
    final map = _map;
    final state = context.read<FeedCubit>().state;
    if (map == null || state is! FeedOk) return;

    final latitude = state.lastQueryCenter?.latitude;
    final longitude = state.lastQueryCenter?.longitude;

    if (latitude == null || longitude == null) return;

    final cam = await map.getCameraState();
    final p = cam.center.coordinates;
    final meters = Geolocator.distanceBetween(
      latitude,
      longitude,
      p.lat.toDouble(),
      p.lng.toDouble(),
    );
    final show = meters > 3000;

    if (mounted && show != _showSearchArea) {
      setState(() => _showSearchArea = show);
    }
  }

  Future<void> _onSearchAreaPressed() async {
    final map = _map;
    if (map == null) return;

    final cam = await map.getCameraState();
    final p = cam.center.coordinates;

    if (!mounted) return;

    setState(() => _showSearchArea = false);
    context.read<FeedCubit>().searchArea(
      GeoCoordinates.raw(
        latitude: p.lat.toDouble(),
        longitude: p.lng.toDouble(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedCubit, FeedState>(
      listener: _onFeedChanged,
      child: Stack(
        children: [
          MapWidget(
            onMapCreated: _onMapCreated,
            onStyleLoadedListener: _onStyleLoaded,
            onMapIdleListener: _onMapIdle,
            styleUri: _styleFor(Theme.of(context).brightness),
            viewportController: _viewport,
            viewport: CameraViewportState(
              center: Point(coordinates: _fallback),
              zoom: 12,
            ),
          ),

          if (_showSearchArea)
            Positioned(
              top: AppSpacing.stackLg,
              left: 0,
              right: 0,
              child: Center(child: SearchAreaPill(onTap: _onSearchAreaPressed)),
            ),
        ],
      ),
    );
  }
}

extension _GeoCoordX on GeoCoordinates {
  Position toPosition() => Position(longitude, latitude);
  Point toPoint() => Point(coordinates: toPosition());
}
