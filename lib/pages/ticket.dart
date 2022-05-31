import 'package:flutter/material.dart';
import 'package:ticcket/services/tickets_controller.dart';
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
              child: FutureBuilder(
                future: TicketsController.getUserTickets(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  else if (snapshot.hasError){
                    return Text("ERROR: ${snapshot.error}");
                  }
                  else if (snapshot.connectionState == ConnectionState.done){
                    List tickets = snapshot.data;
                    // return Text("h");
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TicketCard(ticket: tickets[index]),
                        );
                      }
                    );
                  } else {
                    return Text("Error");
                  }
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}