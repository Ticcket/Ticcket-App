import 'package:flutter/material.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/services/events_controller.dart';
import 'package:ticcket/widgets/loading.dart';
import 'package:ticcket/widgets/star_rating.dart';

class AddFeedbackScreen extends StatefulWidget {
  final int event_id;
  const AddFeedbackScreen({Key? key, required this.event_id}) : super(key: key);

  @override
  State<AddFeedbackScreen> createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _message = "";
  double _rating = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add A New Feedback'),),
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
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: StarRating(
                        color: Colors.yellow,
                        rating: _rating,
                        onRatingChanged: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20,),
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
                          keyboardType: TextInputType.text,
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
                          onSaved: (v) {this._message = v.toString();},
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
                          var resp = await EventsController.addFeedback(widget.event_id, _rating, _message);
                          if(resp.isNotEmpty) {
                            if(resp['success'] == false) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("${resp['message']}"),
                                duration: Duration(seconds: 1),
                              ));
                            }
                            
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
                        child: Text('Post Feedback', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
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