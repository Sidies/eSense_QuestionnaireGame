import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';
import 'package:mobilecomputing_app/Utils/Gesture.dart';
import 'package:mobilecomputing_app/Utils/GyroData.dart';
import 'dart:async';

import 'package:mobilecomputing_app/mainPage.dart';

class BluetoothManager {
  List<String> eSenseNames = ['eSense-1743', 'eSense-0115'];
  ESenseManager manager;

  String _deviceName = 'eSense-1743';
  double _voltage = -1;
  String deviceStatus = '';
  bool sampling = false;
  String _event = '';
  String _button = 'not pressed';
  bool connected = false;

  Function onConnection;

  Future<bool> connectToESense(String deviceName, Function onConnectionSucceed, Function onConnectionFailed) async {
    print('Trying to connect to $deviceName ..');
    this.onConnection = onConnectionSucceed;
    listenToESense();
    bool connection = await ESenseManager().connect(deviceName);
    deviceStatus = connection ? 'connecting' : 'connection failed';
    return connection;
  }

  Future listenToESense() async {
    // if you want to get the connection events when connecting,
    // set up the listener BEFORE connecting...
    ESenseManager().connectionEvents.listen((event) {
      print('CONNECTION event: $event');

      // when we're connected to the eSense device, we can start listening to events from it
      if (event.type == ConnectionType.connected)
      {
        _listenToESenseEvents();
      }

      switch (event.type) {
        case ConnectionType.connected:
          deviceStatus = 'connected';
          connected = true;
          if(this.onConnection != null) {
            this.onConnection();
          }
          break;
        case ConnectionType.unknown:
          deviceStatus = 'unknown';
          break;
        case ConnectionType.disconnected:
          deviceStatus = 'disconnected';
          connected = false;
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
          _button =
              (event as ButtonEventChanged).pressed ? 'pressed' : 'not pressed';
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

  Future<void> startListeningToGesture(Function(Gesture) onGestureDetected) async {

    print(' ');
    print(' ');
    print('START LISTENING TO SENSOR EVENTS:');
    List<GyroData> gyros = [];
    // subscribe to sensor event from the eSense device
    subscription = ESenseManager().sensorEvents.listen((event) {
      //print('SENSOR event: $event');
      gyros.add(new GyroData(event.gyro[0], event.gyro[1], event.gyro[2]));

      if(gyros.length > 20) {
        // If more than 10 gyros data have been captured get the movement

        // Check for left to right motion
        int highestX = 0;
        int lowestX = 0;
        gyros.forEach((element) {
          if(element.x < lowestX) {
            lowestX = element.x;
          }
          if(element.x > highestX) {
            highestX = element.x;
          }
        });

        int highestY = 0;
        int lowestY = 0;
        gyros.forEach((element) {
          if(element.y < lowestY) {
            lowestY = element.y;
          }
          if(element.y > highestY) {
            highestY = element.y;
          }
        });

        int highestZ = 0;
        int lowestZ = 0;
        gyros.forEach((element) {
          if(element.z < lowestZ) {
            lowestZ = element.z;
          }
          if(element.z > highestZ) {
            highestZ = element.z;
          }
        });

        print('-----------------');
        print('Highest X: $highestX');
        print('Highest Y: $highestY');
        print('Highest Z: $highestZ');

        print('Lowest X $lowestX');
        print('Lowest Y $lowestY');
        print('Lowest Z $lowestZ');

        bool nodding = false;
        bool shaking = false;
        if(highestX > 8500 || lowestX.abs() > 8500) {
          shaking = true;
        }
        if(highestZ > 8500 || lowestZ.abs() > 5500) {
          nodding = true;
        }

        if(nodding && !shaking) {
          onGestureDetected(new Gesture(GestureType.Nodding));
        }
        else if(shaking && !nodding) {
          onGestureDetected(new Gesture(GestureType.Shaking));
        }
        gyros.clear();
      }
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
