import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/models/event.dart';
import 'package:ticcket/models/user.dart';
import 'package:ticcket/pages/scanner.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
            Expanded(
              child: Stack(
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
                    child: SingleChildScrollView(
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
                          SizedBox(
                            child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Image.network(
                                "${event.logo}",
                                height: 70,
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
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        // color: AppColors.kGreyColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),        
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
}