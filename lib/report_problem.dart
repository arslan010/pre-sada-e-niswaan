import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pre_sada_e_niswa/LoginRegisterPage.dart';
import 'package:pre_sada_e_niswa/TimelinePage.dart';
class ReportProblem extends StatefulWidget {
  static String tag = "report-problem";
  @override
  _ReportProblemState createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  @override
  Widget build(BuildContext context) {


    final place_of_peace = Container(
      alignment: Alignment.topLeft,
      child: Icon(Icons.people,color: Colors.pinkAccent,size: 40.0),
    );

    final text_1 = Text(
      "Place of Peace\n",
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.black26,
        fontWeight: FontWeight.normal,
      ),
    );

    final problem = TextField(
      keyboardType: TextInputType.multiline,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1000),
      ],
      maxLines: null,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Tell us Problem',
        hintText: "What's on your mind...",
        contentPadding: EdgeInsets.fromLTRB(30.0, 100.0, 10.0, 100.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

      ),

    );


    final submit = Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        onPressed: () {

          //Navigator.of(context).pushNamed(SignupPage.tag);

          Navigator.push(context,
              MaterialPageRoute(builder: (context){
                return TimelinePage();
              }
              )
          );

        },
        padding: EdgeInsets.all(5),
        color: Colors.pinkAccent,
        child: Text(
            'Submit', style: TextStyle(color: Colors.white, fontSize: 15.0)),
      ),
    );






    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pinkAccent.shade100,
        title: Center(child: Text("SADA-E-NISWA")),


        actions: <Widget>[
          PopupMenuButton(
            // ignore: missing_return
            itemBuilder: (context){
              var popupMenuItem = PopupMenuItem(
                child: ListView(
                  children: <Widget>[
                  ],
                ),
              );
            },
          )
        ],

      ),

      backgroundColor: Colors.white,

      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 20.0,),
            place_of_peace,
            text_1,
            problem,
            submit,

          ],
        ),
      ),
    );




  }
}
