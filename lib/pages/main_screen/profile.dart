import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticcket/services/auth.dart';
import 'package:ticcket/services/global.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.getUser(),
      builder: (context, AsyncSnapshot<dynamic>snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasError){
          return Text("ERROR: ${snapshot.error}");
        }
        else if (snapshot.connectionState == ConnectionState.done){
          // print(snapshot.data!.photo);
          // return Text("${snapshot.data!.email}");
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
              snapshot.data!.photo == null ?
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
                  backgroundImage: NetworkImage("${snapshot.data!.photo}"),
                ),
              ),
              ListTile(
                title: Center(child: Text('${snapshot.data!.name}')),
                subtitle: Center(child: Text('Computer Science, AI Student ')),
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text(
                    '${snapshot.data!.email}'),
              ),
              const SizedBox(height: 20,),
              ListTile(
                title: Text('Joined At:'),
                subtitle: Text(
                    "${DateFormat.MMMEd().format(DateTime.parse(snapshot.data.createdAt))}"),
              ),
              const SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                  child: const Text("Change Data"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile/change');
                  },
                ),
              ),
              Center(
                child: TextButton(
                  child: const Text("LOGOUT"),
                  onPressed: () async {
                    bool c = await Auth.logout();
                    print(c);
                    if(c) {
                      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                    }
                  },
                ),
              ),
            ],
          );
        }else {
          return Text("karee");
        }
      }
    );
  }
}