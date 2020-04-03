import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  static String tag = "privacy-policy";
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {

    final place_of_peace = Container(
      alignment: Alignment.topLeft,
      child: Icon(Icons.people,color: Colors.pinkAccent,size: 40.0),
    );

    final text_1= Text(
      "Place of Peace\n",
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.black26,
        fontWeight: FontWeight.normal,
      ),
    );


    final text_privacy_policy= Text(
      "This app provide the full profe security for the users. Developers tried their best to make app properly secure which can't be hack, user privacy will be the safe on their accounts. \n\n\n\n\n",
      style: TextStyle(
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.w400,
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

  body: Center(
    child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      children: <Widget>[
        SizedBox(height: 20.0,),

        place_of_peace,
        text_1,
        text_privacy_policy,

      ],
    ),
  ),

);

  }
}
