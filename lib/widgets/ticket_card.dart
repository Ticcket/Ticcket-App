import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ticcket/core/res/app.dart';
import 'package:ticcket/models/ticket.dart';
import 'package:ticcket/pages/views/ticket_view.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  const TicketCard({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder:  (context) => TicketScreen(ticket: ticket))
        )
      },
        child: Ink(
          padding: const EdgeInsets.all(
            20,
          ),
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
                      ticket.eventTitle,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Complete - 80%",
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
                child: Image.network("http://${AppConstants.server}/${ticket.eventLogo}"),
              ),
            ],
          ),
        ),
      );
  }
}