import 'package:flutter/material.dart';
import 'package:groupr/pages/loading.dart';
import 'package:groupr/pages/services/auth.dart';


class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        title: Text('Login to Groupr'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person_add, color: Colors.white,),
            label: Text('Register', style: TextStyle(color: Colors.white),),
            onPressed: () {
              widget.toggleView();
            }
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        // Email and password form for login
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Text('Please log in to your Groupr account.'),
              SizedBox(height: 20.0),
              // Email
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.email)
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              // Password
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.vpn_key),
                ),
                obscureText: true,
                validator: (val) => val.length < 5 ? 'Enter a password greater than 5 characters long.' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.indigo,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.loginAccount(email, password);

                    if (result == null) {
                      setState(() => error = 'Invalid login, please try again.');
                      loading = false;
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
