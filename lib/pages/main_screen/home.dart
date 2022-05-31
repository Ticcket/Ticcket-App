import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ticcket/pages/ticket.dart';
import 'package:ticcket/services/events_controller.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/widgets/event_card.dart';
import 'package:ticcket/widgets/task_group.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    EventsController.getAllEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                _gridHeader(),
                const SizedBox(
                  height: 15,
                ),
                buildGrid(),
                const SizedBox(
                  height: 25,
                ),
                _eventsHeader(),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: EventsController.getTopEvents(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    else if (snapshot.hasError){
                      return Text("ERROR: ${snapshot.error}");
                    }
                    else if (snapshot.connectionState == ConnectionState.done){
                      List tEvents = snapshot.data;
                      if(tEvents.isEmpty)
                        return Text("No Top Events");
                      return Column(
                        children: [
                          for(var e in tEvents)
                            EventCard(event: e),
                        ],
                      );
                    }
                    return Text("Error");
                  }
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _eventsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Top Events",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: Text(
            "See all",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Row _gridHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          "Events",
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
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TicketsScreen()),
                  );
                  // debugPrint("kareem");
                },
                child: const TaskGroupContainer(
                  color: Colors.pink,
                  icon: Icons.menu_book_rounded,
                  taskCount: "10 Tickets",
                  taskGroup: "My Tickets",
                ),
              );
            }
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InkWell(
            onTap: () => {},
            child: const TaskGroupContainer(
              color: Colors.orange,
              isSmall: true,
              icon: Icons.mobile_friendly,
              taskCount: "0 Events",
              taskGroup: "Organized Events",
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: InkWell(
            onTap: () => {},
            child: const TaskGroupContainer(
              color: Colors.green,
              icon: Icons.article,
              taskCount: "0",
              taskGroup: "Owned Events",
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: InkWell(
            onTap: () => {},
            child: const TaskGroupContainer(
              color: Colors.blue,
              isSmall: true,
              icon: Icons.single_bed_sharp,
              taskCount: "0",
              taskGroup: "Temp",
            ),
          ),
        ),
      ],
    );
  }
}
