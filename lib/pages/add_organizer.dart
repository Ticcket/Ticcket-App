import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/models/event.dart';
import 'package:ticcket/models/user.dart';
import 'package:ticcket/services/events_controller.dart';
import 'package:ticcket/widgets/loading.dart';
import 'package:textfield_search/textfield_search.dart';

class AddOrganizerScreen extends StatefulWidget {
  final Event event;
  const AddOrganizerScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<AddOrganizerScreen> createState() => _AddOrganizerScreenState();
}

class _AddOrganizerScreenState extends State<AddOrganizerScreen> {

  TextEditingController txtController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    txtController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("User Email:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 10, right: 25),
                      child: TextFieldSearch(
                        label: "",
                        textStyle: GoogleFonts.poppins(
                          fontSize: 17,
                        ),
                        controller: txtController,
                        future: () async {
                          List<String> names = [];
                          List us = await EventsController.searchUsers(email: txtController.text);
                            for(User u in us)
                              names.add(u.email);
                          return names;
                        },
                      ),
                      /*TextFormField(
                        validator: (v) => v == null || v == "" ? "Can't Be Empty": null,
                        onSaved: (v) {},
                        autocorrect: false,
                        enableSuggestions: false,
                        autofocus: false,
                        decoration: InputDecoration.collapsed(
                          hintText: "example@example.com",
                          hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),*/
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
                      
                      
                      if(Navigator.canPop(context))
                        Navigator.of(context).pop();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: Text('Add User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}