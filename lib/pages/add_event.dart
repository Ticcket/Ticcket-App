import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticcket/pages/views/event_details.dart';
import 'package:ticcket/services/events_controller.dart';
import 'package:ticcket/widgets/loading.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _title = "";
  String _description = "";
  String _startAt = "";
  String _endAt = "";
  File? _logo;

  showBottomSheet() {
    return showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: 200,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text("Please Choose Image", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 10,),
            InkWell(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: Row(children: [
                  Icon(Icons.photo_outlined, size: 30,),
                  const SizedBox(width: 20,),
                  Text("From Gallery", style: TextStyle(fontSize: 20),)
                ],),
              ),
              onTap: () async{
                var picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                if(picked != null) {
                  setState(() {
                    this._logo = File(picked.path);
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 10,),
            InkWell(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                child: Row(children: [
                  Icon(Icons.camera, size: 30,),
                  const SizedBox(width: 20,),
                  Text("From Camera", style: TextStyle(fontSize: 20),)
                ],),
              ),
              onTap: () async {
                var picked = await ImagePicker().pickImage(source: ImageSource.camera);
                if(picked != null) {
                  setState(() {
                    this._logo = File(picked.path);
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add A New Note'),),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("Title:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
                      child: TextFormField(
                        validator: (v) {
                          if(v!.isEmpty)
                            return "This Field Can't Be Empty";
                          return null;
                        },
                        onSaved: (v) {this._title = v.toString();},
                        autocorrect: false,
                        enableSuggestions: false,
                        autofocus: false,
                        decoration: InputDecoration.collapsed(
                          hintText: "Type An Event Title",
                          hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("Description:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
                      child: TextFormField(
                        validator: (v) {
                          if(v!.isEmpty)
                            return "This Field Can't Be Empty";
                          else if(v.length < 10 && v.length > 255)
                            return "This Field Must Be Between 10 - 255";
                          return null;
                        },
                        onSaved: (v) {this._description = v.toString();},
                        autocorrect: false,
                        enableSuggestions: false,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        decoration: InputDecoration.collapsed(
                          hintText: "Enter A Description",
                          hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("Start At:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          currentTime: DateTime.now(),
                          minTime: DateTime.now(),
                          locale: LocaleType.en,
                          onChanged: (date) {
                            print('change $date');
                          },
                          onConfirm: (date) {
                            setState(() {
                              this._startAt = DateFormat("yyyy-MM-dd").format(date);
                            });
                          }, 
                        );
                      },
                      child: Text(
                          this._startAt.isEmpty ? "Pick A Start Date": this._startAt,
                          // style: TextStyle(color: Colors.blue),
                      )
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:  Text("End At:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          currentTime: DateTime.now(),
                          minTime: DateTime.now(),
                          locale: LocaleType.en,
                          onChanged: (date) {
                            print('change $date');
                          },
                          onConfirm: (date) {
                            setState(() {
                              this._endAt = DateFormat("yyyy-MM-dd").format(date);
                            });
                          }, 
                        );
                      },
                      child: Text(
                          this._endAt.isEmpty ? "Pick An End Date": this._endAt,
                          // style: TextStyle(color: Colors.blue),
                      )
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50),
              child: ElevatedButton.icon(
                onPressed: this.showBottomSheet,
                label: Text('Add Image'),
                icon: Icon(Icons.image),
              ),
            ),
            this._logo != null?
            const SizedBox(height: 20,) : SizedBox(),
            this._logo != null ?
            Container(
              child:  Image.file(this._logo!,height: MediaQuery.of(context).size.width * 0.5,),
            ) : Container(),
            const SizedBox(height: 10,),
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
                if(_formKey.currentState!.validate()){
                  _formKey.currentState?.save();
                  print(this._logo);
                  if (this._logo == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Logo can't Be Empty"),
                      duration: Duration(milliseconds: 300),
                    ));
                  }else {
                    var response = await EventsController.addEvent(
                      title: this._title,
                      description: this._description,
                      startAt: this._startAt,
                      endAt: this._endAt,
                      logo: this._logo!,
                    );
                    if (response == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Something Went Wrong"),
                        duration: Duration(milliseconds: 300),
                      ));
                    }else {
                      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder:  (context) => EventDetails(event: response))
                      // );
                      return ;
                    }
                  }
                }

                if(Navigator.canPop(context))
                  Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Text('Add Event', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
              ),
            ),
            const Divider(thickness: 0, color: Colors.transparent,)
          ],
        ),
      ),
    );
  }
}