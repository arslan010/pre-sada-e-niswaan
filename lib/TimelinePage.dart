import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'about.dart';
import 'help.dart';
import 'privacy_policy.dart';
import 'report_problem.dart';
import 'PictureUpload.dart';
import 'Authentication.dart';
import 'Posts.dart';

class TimelinePage extends StatefulWidget {

  TimelinePage({
    this.auth,
    this.onSignedOut,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  bool isSearching = false;

  List<Posts> postsList =  [];

  @override
  void initState() {
    super.initState();
    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Posts");
    postsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postsList.clear();

      for(var individualKey in KEYS) {
        Posts posts  = Posts(
            DATA[individualKey]['image'],
            DATA[individualKey]['description'],
            DATA[individualKey]['date'],
            DATA[individualKey]['time'],
          );
          postsList.add(posts);
      }
      setState(() {
        print('Lenght : $postsList.lenght');
      }); 
    });
  }

  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    }
    catch(e) {
      print("Error : " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold (

      appBar: AppBar (
          backgroundColor: Colors.pinkAccent.shade100,
          centerTitle: true,
          title: !isSearching ? Text('SADA-E-NISWA') : TextField(decoration: InputDecoration (
           //  icon: Icon(Icons.search),
              hintText: "Search here..."
              ),
          ),

          actions: <Widget> [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                setState(() {
                  this.isSearching = !this.isSearching;
                });
              },
            ),
          ],
        ),


      drawer: Drawer(
          child: ListView(
            children: <Widget>[


              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.apps),
                ),
                title: Text("About"),
                subtitle: Text("app development"),
                onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return About();
                }));
              },
              ),

              Divider(),

              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.help),

                ),

                title: Text("Help"),
                subtitle: Text("any problem?"),
                onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Help();
                }));
              },

              ),

              Divider(),

              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.print),

                ),

                title: Text("Privacy Policy"),
                subtitle: Text("we are confident about our application"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PrivacyPolicy();
                }));
              },

              ),

              Divider(),

              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.report_problem),
                ),

                title: Text("Report a Problem"),
                subtitle: Text("feel free to ask"),
                onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ReportProblem();
                }));
              },
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.account_box),

                ),

                title: Text("Logout"),
                subtitle: Text("session will be closed"),
                onTap: _logoutUser,
              )


            ],
          ),
        ),

      body: new Container (
        // child: new Image.asset("images/arslan.JPG"),
        child: postsList.length == 0 ? new Text("No Posts To Show") : new ListView.builder (
          itemCount: postsList.length,
          itemBuilder: (_, index) {
            return postsUI (
              postsList[index].image,
              postsList[index].description,
              postsList[index].date,
              postsList[index].time, 
            );
          }
        ),
      ),

      bottomNavigationBar: new BottomAppBar (
        color: Colors.pinkAccent.shade100,

        child: new Container (
          margin: EdgeInsets.only(left: 70.0, right: 70.0),
          child: new Row (

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget> [

              new IconButton (
                icon: new Icon(Icons.exit_to_app),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: _logoutUser,
              ),

              new IconButton (
                icon: new Icon(Icons.add_a_photo),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.push (
                    context, 
                    MaterialPageRoute(builder: (context) {
                      return new PictureUpload();
                    }
                    )
                    );
                }
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget postsUI(String image, String description, String date, String time) {
    return new Card (
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),

      child: new Container (
        padding: EdgeInsets.all(14.0),

        child: new Column (
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget> [

            new Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget> [

                new Text (
                  date,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),

                new Text (
                  time,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            SizedBox(height: 10.0,),
            new Image.network(image, fit: BoxFit.cover),
            SizedBox(height: 10.0,),

            new Text (
                  description,
                  style: Theme.of(context).textTheme.subhead,
                  textAlign: TextAlign.center,
                ),
          ],
        ),
      ),
    );
  }
}