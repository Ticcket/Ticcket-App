import 'package:flutter/material.dart';
import 'package:ticcket/core/res/app.dart';
import 'package:ticcket/models/user.dart';

class ScannedUserScreen extends StatelessWidget {

  final User user;

  ScannedUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("kareem"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          children: [
            this.user.photo == null ?
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage("assets/Ticckets.png"),
              ),
            ) :
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage("${this.user.photo}"),
              ),
            ),
            ListTile(
              title: Center(child: Text(this.user.name)),
              subtitle: Center(child: Text(this.user.email)),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Approve")
              ),
            ),
          ],
        ),
      ),
    );
  }
}