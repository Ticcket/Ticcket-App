import 'package:flutter/material.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/models/user.dart';
import 'package:ticcket/services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email = "";
  String _password = "";
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
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
                              child: TextFormField(
                                validator: (v) => v == null || v == "" ? "Can't Be Empty": null,
                                onSaved: (v) {this._email = v.toString();},
                                autocorrect: false,
                                enableSuggestions: false,
                                autofocus: false,
                                decoration: InputDecoration.collapsed(
                                  hintText: "example@example.com",
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
                                  if(v!.length < 7){
                                    return 'Password Can\'t Be Less Than 7';
                                  }
                                  return null;
                                },
                                onSaved: (v) {this._password = v.toString();},
                                autocorrect: false,
                                enableSuggestions: false,
                                obscureText: true,
                                autofocus: false,
                                decoration: InputDecoration.collapsed(
                                  hintText: "******",
                                  hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
                                ),
                                keyboardType: TextInputType.text,
                              ),
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
                              if(this._formKey.currentState!.validate()) {
                                this._formKey.currentState?.save();
                                var response = await Auth.login(email: this._email, password: this._password);
                                if (response != null && response[0]) {
                                  var user = User.fromJson(response[1]);
                                  Navigator.of(context).pushReplacementNamed('/home', arguments: user);
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
                              child: Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account yet ? ', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                              TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/signup");
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 0, color: Colors.transparent,)
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