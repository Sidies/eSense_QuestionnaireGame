import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:mobilecomputing_app/Data/QuestionsData.dart';
import 'package:mobilecomputing_app/QuestionsDataStore.dart';
import 'package:mobilecomputing_app/QuestionsGame.dart';
import 'package:mobilecomputing_app/Design/appColors.dart';
import 'package:mobilecomputing_app/Settings.dart';
import 'package:mobilecomputing_app/eSense/BluetoothManager.dart';
import 'package:mobilecomputing_app/main.dart';
import 'package:mobilecomputing_app/eSense/BluetoothManager.dart';
import 'package:flushbar/flushbar.dart';

class MainPage extends StatefulWidget {

  // Constructor
  MainPage({Key this.scaffoldKey, this.title}) : super(key: scaffoldKey);

  final String title;
  final Key scaffoldKey;
  final _MainPageState state = new _MainPageState();

  static BluetoothManager manager = new BluetoothManager();

  void refreshUI() {
    state.setState(() {

    });
  }

  @override
  _MainPageState createState() => state;
}

class _MainPageState extends State<MainPage> {



  void toggleBluetooth([String deviceName]) async {

    print('--------------------------');
    String status = MainPage.manager.deviceStatus;
    print('DEVICE STATUS: $status');

    String connectionDevice = deviceName != null ? deviceName : 'eSense-0115';

    bool connection;
    if(!MainPage.manager.isConnected()) {
      connection = await MainPage.manager.connectToESense(connectionDevice,
          () => {
            this.setState(() {
              this.showSnackBar("Verbindung erfolgreich!");
            })
          }
      , () => {
        this.setState(() {
          this.showSnackBar("Keine Kopfhörer gefunden!");
        })
      });
      if(connection) {
        this.showSnackBar("Verbindung zu den Kopfhörern wird aufgebaut ..");
        print(' ');
        print('Start connecting ..');
      }
    }
    setState(() {

    });

  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MainPage.manager.isConnected() ? Colors.green : Colors.red,
        child: const Icon(Icons.bluetooth_connected), onPressed: () {
          toggleBluetooth();
        },
      ),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: -50,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text("Questionnaire", style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AppSettingsWidget()));
                },
              )
            ],
          )
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: constraints.maxHeight * 0.4,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Center(
                          child: Text(widget.title, style: TextStyle(color: titleTextColor, fontSize: 25)),
                        ),
                      ),
                      Expanded(
                        child: QuestionsStoreList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: backgroundColor,
                  child: Container(
                    height: constraints.maxHeight * 0.6,
                    decoration: BoxDecoration(
                      color: secondaryBackgroundColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
                    ),
                    child: Center(
                      child: QuestionsGame(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void showSnackBar(String string) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(string),
    ));
  }

/*

  int _currentPanelIndex = -1;
  Widget mainPanelWidget = Center(
    child: Text('Main Panel Widget'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: constraints.maxHeight * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Center(
                          child: Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 25)),
                        ),
                      ),
                      Expanded(
                        child: QuestionsStoreList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
                  ),
                  child: MainPage.mainPanelWidget,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void changeMainPanel(Widget widget) {
    setState(() {
      mainPanelWidget = widget;
    });
  }

  void changeMainPanelIndex(int index) {
    setState(() {
      this._currentPanelIndex = index;
    });
  }

  bool isSelected(int index) {
    return this._currentPanelIndex == index;
  }

   */

/*
  Widget _frontLayer = Center(
      child: Text("Front")
  );

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        title: Text(widget.title),
        /*
        actions: <Widget>[
          BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          ),
        ]*/
      ),
      stickyFrontLayer: true,
      frontLayer: _frontLayer,
      backLayer: BackdropNavigationBackLayer(
        items: [
          Card(
            color: primaryColor,
            child: ListTile(
              leading: Icon(Icons.gamepad),
              title: Text("Fragenspiel"),
              onTap: () => changeFrontLayer(QuestionsGame()),
              subtitle: Text(
                  'Starte das Fragespiel.'
              ),
            ),
          ),
          Card(
            color: primaryColor,
            child: ListTile(
              leading: Icon(Icons.library_books),
              title: Text("Katalog"),
              onTap: () => changeFrontLayer(QuestionsStorePage()),
              subtitle: Text(
                  'Verwalte dein Fragenkatalog'
              ),
            ),
          ),
          Card(
            color: primaryColor,
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("Einstellungen"),
              onTap: () => changeFrontLayer(QuestionsStorePage()),
              subtitle: Text(
                  'Verwalte die Einstellungen der App'
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeFrontLayer(Widget widget) {
    setState(() {
      _frontLayer = widget;
    });
  }

   */
}
