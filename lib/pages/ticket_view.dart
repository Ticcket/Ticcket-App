import 'package:flutter/material.dart';
import 'package:ticcket/models/ticket.dart';

class TicketScreen extends StatefulWidget {
  final Ticket ticket;
  const TicketScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Ticket"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(widget.ticket.eventTitle, style: TextStyle(fontSize: 30), textAlign: TextAlign.center,)
                  )
                ),
              ],
            ),
            Image.network(widget.ticket.qrCode),
            ElevatedButton(
              onPressed: () {},
              child: Text("Save To Gallery")
            ),
          ],
        ),
      ),
    );
  }
}