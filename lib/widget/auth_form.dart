import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);
  final void Function(
      String email, String password, String username, bool isLogin,BuildContext ctx) submitFn;

  

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmtit() {
    final isValid = _formKey.currentState!
        .validate(); // this wil trigger all the validatos in the form
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context
      );
      /*
    line 18 will go to the all the text form filds and is will
    trigger onSaved function
    onSaved: will bascially save the fianl value
    */
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return 'please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                      onSaved: (value) {
                        _userEmail = value!; // we know its valid
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return "please enter at least 4 characters";
                          }
                        },
                        decoration: InputDecoration(labelText: 'Username'),
                        onSaved: (value) {
                          _userName = value!;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return "password must be at least 7 char long";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'password'),
                      onSaved: (value) {
                        _userPassword = value!;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: _trySubmtit,
                      child: Text(_isLogin ? "Login" : 'SignUP'),
                    ),
                    Text(
                      "Not registered yet?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? "create a new account"
                            : 'I already have an account'))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
