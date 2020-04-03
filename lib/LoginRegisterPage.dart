// import 'package:html/dom.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'MessagesPage.dart';

class LoginRegisterPage extends StatefulWidget {

    final AuthImplementation auth;
    final VoidCallback onsignedIn;

  LoginRegisterPage ({
  @required this.auth,
            this.onsignedIn,
  });

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

enum FormType {
  login, 
  register,
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  bool isSearching = false;
  MessagesPage dialogBox = new MessagesPage();
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;

  String _email;
  String _password;

  //methods are here

  bool validateAndSave() {
    final form = formKey.currentState;
    if(form.validate()) {
      form.save();
      return true;
    }
    else {
      return false;
    }
  }

  void validateAndSubmit() async {
    try {
      if(validateAndSave()) {
        if(_formType == FormType.login) {
          String userId = await widget.auth.SignIn(_email, _password);
          dialogBox.information(context, "Welcome!", "Login Successfull.");
          print("Login UserId : " + userId);
        }
        else {
          String userId = await widget.auth.SignUp(_email, _password);
          dialogBox.information(context, "Congratulation!", "Registration Complete Successfully.");
          print("Register UserId : " + userId);
        }
        widget.onsignedIn();
    }
  }
    catch(e) {
        dialogBox.information(context, "Error", "User Data Looks Invalid");
      }
}

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }
  
  //design is here
  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: AppBar (
          backgroundColor: Colors.pinkAccent.shade100,
          centerTitle: true,
          title: !isSearching ? Text('Sada-e-Niswaan') : TextField(decoration: InputDecoration (
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

      body: new Container (
        margin: EdgeInsets.all(15.0),
        child: new Form (
          key: formKey,
          child: new Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          ),
          ),
      ),
    );
  } //Widget build(BuildContext context)

List<Widget> createInputs() {
    return [
      SizedBox(height: 10.0),
      logo(),
      SizedBox(height: 20.0),

      new TextFormField (
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) {
          return value.isEmpty? 'Email is required!': null;
          },
          onSaved: (value) {
            return _email = value;
            },
      ),

      SizedBox(height: 10.0),

      new TextFormField (
        obscureText: true,
        decoration: new InputDecoration(labelText: 'Password'),
        validator: (value) {
          return value.isEmpty? 'Password is required!': null;
          },
          onSaved: (value) {
            return _password = value;
            },
      ),

      SizedBox(height: 20.0), 
    ];
  }

  Widget logo(){
      return new Hero (
        tag:'hero',
        child: new Container (
          alignment: Alignment.topLeft,
          child: Icon(Icons.person, color: Colors.pinkAccent.shade200, size: 110.0),
        ),  
        );
    }
    
  
    List<Widget> createButtons() {
      if(_formType == FormType.login) {
        return [
          SizedBox(height: 20.0),

          new RaisedButton (
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              ),
            child: new Text("Login", style: new TextStyle(fontSize: 20.0),),
            textColor: Colors.pink, 
            onPressed: validateAndSubmit,
            ),  

            SizedBox(height: 10.0),

            new FlatButton (
            child: new Text("Not have an account?", style: new TextStyle(fontSize: 14.0),),
            textColor: Colors.red, 
            onPressed: moveToRegister,
            )  
        ];
      }
      else {
        return [

          SizedBox(height: 20.0),

          new RaisedButton (
            child: new Text("Register", style: new TextStyle(fontSize: 20.0),),
            textColor: Colors.pink, 
            onPressed: validateAndSubmit,
            ),  

            SizedBox(height: 10.0),

            new FlatButton
            (
            child: new Text("Already have an account?", style: new TextStyle(fontSize: 14.0),),
            textColor: Colors.red, 
           onPressed: moveToLogin,
            )  
        ];
      }
  }
}