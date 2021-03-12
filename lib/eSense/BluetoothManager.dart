import 'package:esense_flutter/esense.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BluetoothManager {

  List<String> eSenseNames = ['eSense-0115'];
  String eSenseName = 'eSense-0115';
  ESenseManager manager;

  BluetoothManager() {
    manager = new ESenseManager();

  }

  Future<bool> connectToESense() async {

      //for(String element in eSenseNames) {
        print('Trying to connect to: $eSenseName');

        manager.connectionEvents.listen((event) {
          print('CONNECTION event: $event');
        });

        bool connected = await manager.connect(eSenseName);
        if(connected) {
          print('CONNECTION PROCESS DONE');
        }
      //}

    return true;

  }

  void disconnectFromESense() async {
    bool disconnected = await manager.disconnect();
    //disconnected ? print('Disconnected successfully') : print('Could not disconnect from device');
  }

  bool isConnected() {
    bool flag = manager.connected;
    flag ? print('Device is connected') : print('No device connected');
    return flag;
  }


  void getAccelerometerData() async {

  }

}