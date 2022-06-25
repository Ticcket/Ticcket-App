import 'package:flutter/material.dart';
import 'package:ticcket/models/event.dart';
import 'package:sizer/sizer.dart';
import 'package:ticcket/pages/views/event_details.dart';
import 'package:ticcket/services/global.dart';
import 'package:ticcket/widgets/star_rating.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var user = await Global.getUser();
        var organizers =  await Global.getOrganizers(event.id);
        var isBooked = await Global.isBooked(event.id);
  
        Navigator.push(
          context,
          MaterialPageRoute(builder:  (context) => EventDetails(event: event, user: user, organizers: organizers, isBooked: isBooked,))
        );
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
                      event.title,
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
                          "${event.startAt} - ${event.endAt}",
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
                      child: StarRating(
                        color: Colors.yellow,
                        rating: event.rating ?? 0.0,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 20.w,
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
            ],
          ),
        ),
      );
  }
}