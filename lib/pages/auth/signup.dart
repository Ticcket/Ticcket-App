import 'package:flutter/material.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/models/user.dart';
import 'package:ticcket/services/auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _password = "";
  String _repassword = "";
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          image: const DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
            image: AssetImage("assets/Ticckets.png")
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.62,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
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
                                child:  Text("Full Name:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
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
                                  onSaved: (v) {this._name = v.toString();},
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  autofocus: false,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Type Your Full Name",
                                    hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                                  ),
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:  Text("E-mail:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
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
                                    hintText: "Type Your Email",
                                    hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:  Text("Password:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
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
                                    else if (v.length < 7)
                                      return "Password Can't Be Less Than 7";
                                    return null;
                                  },
                                  onSaved: (v) {this._password = v.toString();},
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  autofocus: false,
                                  obscureText: true,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Enter A Strong Password",
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
                                child:  Text("Re-Password:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
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
                                    else if (v.length < 7)
                                      return "Password Can't Be Less Than 7";
                                    return null;
                                  },
                                  onSaved: (v) {this._repassword = v.toString();},
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  autofocus: false,
                                  obscureText: true,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Re-enter Your Password",
                                    hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      _loading ? CircularProgressIndicator() : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });

                          if(_formKey.currentState!.validate()){
                            _formKey.currentState?.save();

                            var response = await Auth.register(
                              name: this._name,
                              email: this._email,
                              password: this._password,
                              repassword: this._repassword
                            );
                            if (response != null) {
                              Navigator.of(context).pop();
                            }else if (response != null && !response[0]){
                              print(response[1]);
                            }
                          }

                          setState(() {
                            _loading = false;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                          child: Text('Sign Up', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already Have An Account ? ', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                          TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        ],
                      ),
                      const Divider(thickness: 0, color: Colors.transparent,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}