import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BluetoothManager {

  List<String> eSenseNames = ['eSense-1743'];
  String eSenseName = 'eSense-1743';
  ESenseManager manager;

  String _deviceName = 'eSense-0115';
  double _voltage = -1;
  String deviceStatus = '';
  bool sampling = false;
  String _event = '';
  String _button = 'not pressed';
  bool connected = false;

  Future connectToESense() async {
    print('Trying to connect ..');
    connected = await ESenseManager().connect(eSenseName);

    deviceStatus = connected ? 'connecting' : 'connection failed';

    listenToESense();

  }

  Future listenToESense() async {
    // if you want to get the connection events when connecting,
    // set up the listener BEFORE connecting...
    ESenseManager().connectionEvents.listen((event) {
      print('CONNECTION event: $event');

      // when we're connected to the eSense device, we can start listening to events from it
      if (event.type == ConnectionType.connected) _listenToESenseEvents();

        switch (event.type) {
          case ConnectionType.connected:
            deviceStatus = 'connected';
            connected = true;
            break;
          case ConnectionType.unknown:
            deviceStatus = 'unknown';
            break;
          case ConnectionType.disconnected:
            deviceStatus = 'disconnected';
            break;
          case ConnectionType.device_found:
            deviceStatus = 'device_found';
            break;
          case ConnectionType.device_not_found:
            deviceStatus = 'device_not_found';
            break;
        }
      });
  }

  void _listenToESenseEvents() async {
    ESenseManager().eSenseEvents.listen((event) {
      print('ESENSE event: $event');

      switch (event.runtimeType) {
        case DeviceNameRead:
          _deviceName = (event as DeviceNameRead).deviceName;
          break;
        case BatteryRead:
          _voltage = (event as BatteryRead).voltage;
          break;
        case ButtonEventChanged:
          _button = (event as ButtonEventChanged).pressed
              ? 'pressed'
              : 'not pressed';
          break;
        case AccelerometerOffsetRead:
        // TODO
          break;
        case AdvertisementAndConnectionIntervalRead:
        // TODO
          break;
        case SensorConfigRead:
        // TODO
          break;
      }
    });
  }

  StreamSubscription subscription;
  void startListenToSensorEvents() async {
    // subscribe to sensor event from the eSense device
    subscription = ESenseManager().sensorEvents.listen((event) {
      print('SENSOR event: $event');

    });

    sampling = true;
  }

  void pauseListenToSensorEvents() async {
    subscription.cancel();

    sampling = false;

  }

  bool isConnected() {
    return this.deviceStatus == 'connected';
  }
}