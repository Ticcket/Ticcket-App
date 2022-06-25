import 'package:flutter/material.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/models/event.dart';
import 'package:ticcket/models/user.dart';
import 'package:sizer/sizer.dart';
import 'package:ticcket/pages/add_organizer.dart';
import 'package:ticcket/services/events_controller.dart';

class ShowOrganizersScreen extends StatefulWidget {
  final Event event;
  const ShowOrganizersScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<ShowOrganizersScreen> createState() => _ShowOrganizersScreenState();
}

class _ShowOrganizersScreenState extends State<ShowOrganizersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organizers"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddOrganizerScreen(event: widget.event),
                )
              ).then((value) => setState(() {}));
            },
            icon: Icon(Icons.add, color: AppColors.primaryColor, size: 30,)
          ),
        ],
      ),
      body: FutureBuilder(
        future: EventsController.getOrganizers(widget.event.id),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return _organizer(snapshot.data[index], index);
              },
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  _organizer(User u, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    u.name,
                    style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timelapse,
                        color: Colors.blue[300],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${u.email}",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      index == 0 ? "Owner" : "Organizer",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20.w,
              child: Image.network(
                "${u.photo!}",
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}