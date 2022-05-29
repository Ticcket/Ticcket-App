import 'package:flutter/material.dart';
import 'package:ticcket/core/res/app.dart';
import 'package:ticcket/pages/scanner.dart';

class ScannedUserScreen extends StatelessWidget {
  const ScannedUserScreen({Key? key}) : super(key: key);

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
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(
                    '${AppConstants.server}storage/users/1653664889-kareem.png'),
              ),
            ),
            const ListTile(
              title: Center(child: Text('Kareem El-Giushy')),
              subtitle: Center(child: Text('Kareem@gmail.com')),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => QRScanner())
                  );
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