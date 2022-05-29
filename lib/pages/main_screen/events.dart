import 'package:flutter/material.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/services/events_controller.dart';
import 'package:ticcket/widgets/event_card.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.bgColor,
          padding: const EdgeInsets.only(bottom: 10.0, top: 20.0, right: 15.0, left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                "All Events",
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
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.blue[400],
                  ))
            ],
          ),
        ),
        Expanded(
          child: MediaQuery.removePadding(
            removeBottom: true,
            context: context,
            child: FutureBuilder(
              future: EventsController.getAllEvent(),
              builder: (context, AsyncSnapshot<dynamic>snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                else if (snapshot.hasError){
                  return Text("ERROR: ${snapshot.error}");
                }
                else if (snapshot.connectionState == ConnectionState.done){
                  if(snapshot.data[1].isEmpty)
                    return Text("Empty");

                  List events = snapshot.data![1];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: events.length + 1,
                    itemBuilder: (context, index) {
                
                      if (index == events.length)
                        return  Padding(
                          padding: const EdgeInsets.only(bottom: 100.0),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_downward)
                          ),
                        );
                
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EventCard(event: events[index]),
                      );
                    }
                  );
                }else {
                  return Text("Error");
                }
              },
              
            ),
          ),
        ),
      ],
    );
  }
}