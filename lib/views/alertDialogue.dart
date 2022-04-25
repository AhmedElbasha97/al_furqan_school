import 'package:flutter/material.dart';

class AlertDialogue extends StatefulWidget {
  const AlertDialogue({Key? key}) : super(key: key);

  @override
  State<AlertDialogue> createState() => _AlertDialogueState();
}

class _AlertDialogueState extends State<AlertDialogue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text("ALERT DIALOG EXAMPLE"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Click me"),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ListTile(
                      leading: new Icon(Icons.photo),
                      title: new Text('Photo'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.music_note),
                      title: new Text('Music'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.videocam),
                      title: new Text('Video'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        },
        icon: Icon(Icons.open_with),
      ),
    );
  }
}
