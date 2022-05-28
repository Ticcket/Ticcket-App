import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/models/event.dart';
import 'package:sizer/sizer.dart';

class EventScreen extends StatefulWidget {
  final Event event;
  const EventScreen({Key? key, required this.event}) : super(key: key);


  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 35.w,
                    child: Image.network("http://178.62.201.95/storage/events/1653069980-turing_point.png")
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.event.title,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.sp),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                "Start Date: ",
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
                              ),
                            ),
                            
                            Text(
                              widget.event.startAt,
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "End Date: ",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
                            ),
                            Text(
                              widget.event.endAt,
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13.sp),
              ),
            ),
            Divider(thickness: 1, color: AppColors.accentColor,),
            Expanded(
              child: Text(
                  widget.event.description,
                  style: TextStyle(fontSize: 12.sp),
                )
              ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: () {}, child: const Text("Book Now")),
          ],
        ),
      ),
    );
  }
}