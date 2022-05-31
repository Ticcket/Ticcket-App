import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticcket/core/res/app.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/models/user.dart';
import 'package:ticcket/widgets/loading.dart';

class ChangeDataScreen extends StatefulWidget {
  const ChangeDataScreen({Key? key}) : super(key: key);

  @override
  State<ChangeDataScreen> createState() => _ChangeDataScreenState();
}

class _ChangeDataScreenState extends State<ChangeDataScreen> {
  
  String _name = "";
  String _email = "";
  String _newpassword = "";
  String _oldpassword = "";
  File? _photo;
  
  getUser(key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var temp = await pref.getString(key);
    Map<String,dynamic> t = jsonDecode(temp ?? "");
    return User.fromJson(t);
  }

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
                    this._photo = File(picked.path);
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
                    this._photo = File(picked.path);
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
      body: FutureBuilder(
        future: getUser("object"),
        builder: (context, AsyncSnapshot<dynamic>snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError){
            return Text("ERROR: ${snapshot.error}");
          }
          else if (snapshot.connectionState == ConnectionState.done){
            // print(snapshot.data!.photo);
            // return Text("${snapshot.data!.email}");
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SelectableText(
                      "Profile",
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                      toolbarOptions: const ToolbarOptions(
                        copy: true,
                        selectAll: true,
                      ),
                    ),
                  ),
                ),
                snapshot.data!.photo == null ?
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 75,
                  ),
                ) :
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage("http://${AppConstants.server}/${snapshot.data!.photo}"),
                  ),
                ),
                const SizedBox(height: 25,),
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
                      onSaved: (v) {this._name = v.toString();},
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: false,
                      decoration: InputDecoration.collapsed(
                        hintText: "John Doe",
                        hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                      keyboardType: TextInputType.text,
                    ),
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
                      onSaved: (v) {this._email = v.toString();},
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: false,
                      decoration: InputDecoration.collapsed(
                        hintText: "kareem@example.com",
                        hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
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
                      onSaved: (v) {this._oldpassword = v.toString();},
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                        hintText: "Old Password",
                        hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                      keyboardType: TextInputType.text
                    ),
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
                      onSaved: (v) {this._newpassword = v.toString();},
                      autocorrect: false,
                      enableSuggestions: false,
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                        hintText: "New Password",
                        hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50),
                  child: ElevatedButton.icon(
                    onPressed: this.showBottomSheet,
                    label: Text('Profile Picture'),
                    icon: Icon(Icons.image),
                  ),
                ),
                this._photo != null?
                const SizedBox(height: 20,) : SizedBox(),
                this._photo != null ?
                Container(
                  child:  Image.file(this._photo!,height: MediaQuery.of(context).size.width * 0.5,),
                ) : Container(),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                      ),
                    ),
                    onPressed: () async {
                      // showLoading(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: Text('Change Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                    ),
                  ),
                ),
              ],
            );
          }else {
            return Text("Error");
          }
        }
      ),
    );
  }
}