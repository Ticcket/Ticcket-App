import 'package:flutter/material.dart';
import 'package:ticcket/core/res/color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
Widget userInput(String hintTitle, TextInputType keyboardType, {bool password=false}) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextFormField(
          autocorrect: false,
          enableSuggestions: false,
          obscureText: password,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

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
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Form(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:  Text("Full Name:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                            ),
                          ),
                          userInput('John Doe', TextInputType.name),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:  Text("E-mail:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                            ),
                          ),
                          userInput('example@example.com', TextInputType.emailAddress),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:  Text("Password:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                            ),
                          ),
                          userInput('******', TextInputType.text, password: true),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:  Text("Re-Password:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
                            ),
                          ),
                          userInput('******', TextInputType.text, password: true),
                          
                        ],
                      ),
                    ),
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
                      onPressed: () {
          
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
          ],
        ),
      ),
    );
  }
}