import 'package:flutter/material.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/services/announcements_controller.dart';
import 'package:ticcket/widgets/loading.dart';

class AddAnnouncementScreen extends StatefulWidget {
  final int event_id;
  const AddAnnouncementScreen({Key? key, required this.event_id}) : super(key: key);

  @override
  State<AddAnnouncementScreen> createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add A New Announcement'),),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:  Text("Message:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                      ),
                    ),
                    Container(
                      height: 150,
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 4,
                          maxLength: 1000,
                          maxLines: null,
                          validator: (v) {
                            if(v!.isEmpty)
                              return "This Field Can't Be Empty";
                            if(v.length > 1000)
                              return "This Field Can't Exceed 1000 Characters";
                            return null;
                          },
                          onSaved: (v) {this.message = v.toString();},
                          autocorrect: false,
                          enableSuggestions: false,
                          autofocus: false,
                          decoration: InputDecoration.collapsed(
                            hintText: "Write Your Message",
                            hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        ),
                      ),
                      onPressed: () async {
                        showLoading(context);

                        if(_formkey.currentState!.validate()){
                          _formkey.currentState?.save();
                          bool respone = await AnnouncementsController.addAnnouncement(this.message, widget.event_id);
                          print(respone);
                          if (respone) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            return ;
                          }
                        }

                        if(Navigator.canPop(context))
                          Navigator.of(context).pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        child: Text('Post Message', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}