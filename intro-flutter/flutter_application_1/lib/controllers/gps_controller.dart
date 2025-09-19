import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class GpsController extends ChangeNotifier {
  Position? _currentPosition;
  bool _isLoading = false;
  String _statusMessage = 'Toque no botão para obter localização';
  late final MapController _mapController = MapController(); // <- aqui a troca
  List<Marker> _markers = [];
  String? _address;
  String? _postalCode;

  // Getters
  Position? get currentPosition => _currentPosition;
  bool get isLoading => _isLoading;
  String get statusMessage => _statusMessage;
  MapController get mapController => _mapController;
  List<Marker> get markers => _markers;
  String? get address => _address;
  String? get postalCode => _postalCode;

  Future<void> getCurrentLocation() async {
    _isLoading = true;
    _statusMessage = 'Obtendo localização...';
    notifyListeners();

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _statusMessage = 'Permissão de localização negada';
          _isLoading = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _statusMessage = 'Permissão de localização negada permanentemente';
        _isLoading = false;
        notifyListeners();
        return;
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _statusMessage = 'Serviço de localização desabilitado';
        _isLoading = false;
        notifyListeners();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentPosition = position;
      _statusMessage = 'Localização obtida com sucesso!';
      _isLoading = false;
      notifyListeners();

      await _getAddressFromCoordinates(position.latitude, position.longitude);

      _updateMapMarker(position.latitude, position.longitude);
    } catch (e) {
      _statusMessage = 'Erro ao obter localização: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _address =
            '${place.street}, ${place.subLocality}, ${place.locality} ${place.administrativeArea}, ${place.subAdministrativeArea}';
        _postalCode = place.postalCode;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao buscar endereço: $e');
      }
      _address = 'Endereço não encontrado';
      _postalCode = 'CEP não encontrado';
      notifyListeners();
    }
  }

  void _updateMapMarker(double latitude, double longitude) {
    _markers = [
      Marker(
        point: LatLng(latitude, longitude),
        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    ];
    notifyListeners();

    try {
      _mapController.move(LatLng(latitude, longitude), 16.0);
    } catch (e) {
      if (kDebugMode) {
        print('Mapa ainda não inicializado: $e');
      }
    }
  }
}