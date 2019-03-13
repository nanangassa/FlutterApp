import 'package:flutter/material.dart';
import 'redirect.dart';
import 'translate.dart';
import 'database/Database.dart';

class CodeInput extends StatefulWidget {
  @override
  _CodeInputState createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String language = allTranslations.currentLanguage;
    final String buttonText = language == 'fr' ? '=> English' : '=> Français';
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            color: Colors.orange,
            splashColor: Colors.teal,
            textColor: Colors.white,
            child: Text(buttonText),
            onPressed: () async {
              await allTranslations
                  .setNewLanguage(language == 'fr' ? 'en' : 'fr');
              setState(() {});
            },
          ),
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              autovalidate: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: myController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                    decoration: InputDecoration(
                        labelText: allTranslations.text('enterCode'),
                        labelStyle: TextStyle(
                          color: Colors.orange,
                          fontSize: 20.0,
                        ),
                        fillColor: Colors.orange),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 57.0),
                  ),
                  MaterialButton(
                    height: 50.0,
                    minWidth: 150.0,
                    color: Colors.orange,
                    splashColor: Colors.teal,
                    textColor: Colors.white,
                    child: Text(allTranslations.text('validate')),
                    onPressed: () async {
                      var peopleList = await DBProvider.db
                          .getPeopleList(int.parse(myController.text));

                      if (peopleList.isNotEmpty) {
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Redirect(peopleList)),
                        );
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text(allTranslations.text('invalidInput'))));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
