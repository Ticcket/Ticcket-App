import 'package:flutter/material.dart';
import 'package:ticcket/models/ticket.dart';
import 'package:ticcket/widgets/ticket_card.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Booked Tickets"),
      ),
      body: Column(
        children: [
          Expanded(
            child: MediaQuery.removePadding(
              removeBottom: true,
              context: context,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: demo_tickets.length + 1,
                itemBuilder: (context, index) {
    
                  if (index == demo_tickets.length)
                    return  Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_downward)
                      ),
                    );
    
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TicketCard(ticket: demo_tickets[index]),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}