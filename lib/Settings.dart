import 'package:flutter/material.dart';
import 'package:mobilecomputing_app/Design/appColors.dart';

class AppSettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Einstellungen"),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 30, left: 10, right: 10),
          child: ListView(
            children: [
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Theme Einstellungen", style: TextStyle(
                        //fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black38,
                    ),
                    ListTile(
                      leading: Icon(Icons.phone_android),
                      title: Text("Green Theme"),
                      subtitle: Text("Stelle ein grünes Design für die App ein."),
                      onTap: () => {greenTheme()},
                    ),
                    ListTile(
                      leading: Icon(Icons.phone_android),
                      title: Text("Dark Theme"),
                      subtitle: Text("Stelle ein dunkles Design für die App ein."),
                      onTap: () => {darkTheme()},
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      );
  }

}