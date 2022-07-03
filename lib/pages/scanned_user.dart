import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticcket/models/user.dart';

class ScannedUserScreen extends StatelessWidget {

  final User? user;

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
            this.user?.photo == null ?
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
                backgroundImage: NetworkImage(this.user != null ? "${this.user?.photo}" : ""),
              ),
            ),
            ListTile(
              title: Center(child: Text(this.user != null ? "${this.user?.name}" : "Annonymous User")),
              subtitle: Center(child: Text(this.user != null ? "${this.user?.email}" : "")),
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Made With ♥ By ",
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    "Kareem El-Giushy",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    "GDSC MU",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}