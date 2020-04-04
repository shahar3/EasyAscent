import 'package:easy_ascent/core/enums/enums.dart';
import 'package:easy_ascent/core/providers/authentication.dart';
import 'package:easy_ascent/ui/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _passwordController = TextEditingController();

  void _submit(AuthProvider model) async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    if (_authMode == AuthMode.Login) {
      await model.login(_authData['email'], _authData['password']);
    } else {
      await model.signUp(_authData['email'], _authData['password']);
    }

    //Show error if there is an error
    if (model.errorMessage != null) {
      _showErrorDialog(model.errorMessage);
      model.errorMessage = null;
    } else {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            "Welcome",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22.0,
              fontFamily: "Open_Sans",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 8.0,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(
                  12.0,
                ),
                child: Consumer<AuthProvider>(
                  builder: (ctx, model, _) => Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'E-Mail',
                          icon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password', icon: Icon(Icons.lock)),
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                      ),
                      if (_authMode == AuthMode.Signup)
                        TextFormField(
                          enabled: _authMode == AuthMode.Signup,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              icon: Icon(Icons.lock_outline)),
                          obscureText: true,
                          validator: _authMode == AuthMode.Signup
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                  return null;
                                }
                              : null,
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      if (model.state == ViewState.Busy)
                        CircularProgressIndicator()
                      else
                        RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => _submit(model),
                        ),
                      FlatButton(
                        child: Text(
                            '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                        onPressed: _switchAuthMode,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
