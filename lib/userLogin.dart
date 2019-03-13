import 'package:flutter/material.dart';
import 'package:forecanvass/codeInput.dart';
import 'text.dart';
import 'usernamesAndPasswords.dart';

class UserLogin extends StatefulWidget {

    UserLogin({Key key, this.title}) : super(key: key);
      final String title;


  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  var allText = AllText();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  //Controllers to get values from textfields later.
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(allText.loginText),
        ),
        resizeToAvoidBottomPadding: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  //stack ???
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                      child: Text(
                                 
                        'LogIn',
                         key: Key('log'),
                         
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(220.0, 50.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            hintText: 'Write Username here',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange))),
                        controller: userNameController,
                       // validator: (value) {
                       //   if (value.isEmpty) {
                        //    return 'Username can not be empty';
                        //  }
                       // },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'Password ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            hintText: 'Write password here',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange))),
                        obscureText: true,
                        //  validator: (value) {
                        //    if (value.isEmpty) {
                        //      return 'Password cannot be empty';
                        //    }
                        //  },
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(top: 15.0, left: 20.0),
                        child: InkWell(
                          child: Text('Forgot Password',
                                        key: Key('password'),

                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                decoration: TextDecoration.underline,
                              )),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Container(
                          height: 40.0,
                          child: Material(
                            
                            key: Key('login'),

                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.orangeAccent,
                            color: Colors.orange[400],
                            elevation: 7.0,
                            child: InkWell(

                                            key: Key('loginvalidation'),

                              onTap: () {
                                //if (_formKey.currentState.validate()) {
                                  if (loginValidation(userNameController.text,
                                      passwordController.text)) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CodeInput()),
                                    );
                                  } else {
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text(
                                               'Invalid Username or Password')));
                                  }
                               // }
                              },
                              child: Center(
                                child: Text(

                                  
                                  'Log In',

                                    key: Key('logintext'),

                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserLogin()),
                              );
                            },
                            child: Center(
                              child: Text('Go Back',
                                            key: Key('gobacktext'),

                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'New to NDP?',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    child: Text('Register',
                        style: TextStyle(
                            color: Colors.orange,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                  )
                ],
              )
            ]));
  }
}

bool loginValidation(String userName, String password) {

  for (int i = 0; i < users.length; i++) {
    if (users[i].userName == userName && users[i].password == password) {
      return true;
    }
  }
  return false;
}
