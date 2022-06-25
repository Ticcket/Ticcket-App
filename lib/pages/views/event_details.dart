import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/models/announcement.dart';
import 'package:ticcket/models/event.dart';
import 'package:ticcket/models/user.dart';
import 'package:ticcket/pages/add_announcement.dart';
import 'package:ticcket/pages/scanner.dart';
import 'package:ticcket/services/Announcements_controller.dart';
import 'package:ticcket/services/tickets_controller.dart';
import 'package:ticcket/services/events_controller.dart';
import 'package:ticcket/widgets/loading.dart';

class EventDetails extends StatelessWidget {
  final Event event;
  final User user;
  final List organizers;
  final bool isBooked;
  EventDetails({
    Key? key,
    required Event this.event,
    required this.user,
    required this.organizers,
    this.isBooked = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            DateFormat.MMMEd().format(DateTime.now()),
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
        ),
        actions: [
          event.creator == user.id ?
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Are You Sure You Want To Delete The Event",
                    style: GoogleFonts.poppins(

                    )
                  ),
                  actions: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () async {
                        showLoading(context);
                        bool c = await EventsController.delete(event.id);
                        Navigator.of(context).pop();
                        print(c);
                        if(c) {
                          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                          return ;
                        }
                        else {
                          Navigator.pop(context);
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Delete",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      )
                    )
                  ]
                ),
              );
            },
            icon: Icon(Icons.delete_forever_outlined, size: 30, color: Colors.red[300],),
          ) : Container(),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(),
            expandedHeight: MediaQuery.of(context).size.height * 0.305,
            flexibleSpace: Container(
              height: MediaQuery.of(context).size.height * .35,
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              child: Image.network(
                "${event.logo!}",
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
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Offline',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${event.title}',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Free',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '${event.description}',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'Start At:',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(
                                    "${event.startAt}",
                                    style: TextStyle(color: AppColors.primaryColor,),
                                  ),
                                ],
                              ),
                            ),
                    
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'End At:',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(
                                    "${event.endAt}",
                                    style: TextStyle(color: AppColors.primaryColor,),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Announcements',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(thickness: 1, color: Colors.grey,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                            future: AnnouncementsController.getAllAnnouncements(event.id),
                            builder: (context, AsyncSnapshot snapshot) {
                              if(snapshot.connectionState == ConnectionState.done){ 
                                if(snapshot.data.isEmpty)
                                  return Center(child: Text("Nothing To Show"),);
                                List<Widget> anns = [];
                                print(snapshot.data);
                                for(var d in snapshot.data){
                                  anns.add(_announcement(context, d));
                                }
                                return Column(children: anns,);
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: organizers.contains(user.id) ?
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddAnnouncementScreen(event_id: event.id)
                    )
                  );
                },
                icon: Icon(
                  Icons.assistant_rounded,
                  size: 30,
                  color: Colors.grey,
                ),
              ) : IconButton(
                onPressed: () {
                  
                },
                icon: Icon(
                  Icons.feedback_outlined,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: organizers.contains(user.id) ?
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QRScanner(event_id: event.id)
                    )
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Scan Tickets',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ) : InkWell(
                onTap: () async {
                  showLoading(context);
                  var resp = await TicketsController.bookTicket(event.id);
                  print(resp);
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Book A Ticket',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _announcement(context, Announcement ann) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ann.announcement,
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
                DateFormat.MMMd().format(ann.createdAt),
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
              "${ann.orgName}",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}