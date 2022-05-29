import 'package:flutter/material.dart';
import 'package:ticcket/models/user.dart';
import 'package:ticcket/services/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, String? title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserController.getUserData("35|oJg9vZJIT2LH0k3kT44Drh8AhpabMc7SbOHZYwtS"),
      builder: (context, AsyncSnapshot<dynamic>snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.connectionState == ConnectionState.done)
          return Text("DATA: ${snapshot.data.email}");
        else if (snapshot.hasError)
          return Text("ERROR: ${snapshot.error}");
        return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SelectableText(
                    "Profile",
                    style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                    toolbarOptions: const ToolbarOptions(
                      copy: true,
                      selectAll: true,
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(
                      'http://178.62.201.95/storage/users/1653664889-kareem.png'),
                ),
              ),
              const ListTile(
                title: Center(child: Text('Kareem El-Giushy')),
                subtitle: Center(child: Text('Computer Science, AI Student ')),
              ),
              const ListTile(
                title: Text('Email'),
                subtitle: Text(
                    'kareem@kareem.com'),
              ),
              const SizedBox(height: 20,),
              const ListTile(
                title: Text('Joined At:'),
                subtitle: Text(
                    'May, 2020'),
              ),
              const SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                  child: const Text("Change Data"),
                  onPressed: () {},
                ),
              ),
            ],
          );
      }
    );
  }
}