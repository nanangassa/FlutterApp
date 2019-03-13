import 'package:flutter/material.dart';
import 'package:forecanvass/model/PersonModel.dart';
import 'map.dart';
import 'streetList.dart';
import 'translate.dart';

class Redirect extends StatefulWidget {
  final List<Person> peopleList;

  const Redirect(
    this.peopleList, {
    Key key,
  }) : super(key: key);
  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  Widget build(BuildContext context) {
    final String language = allTranslations.currentLanguage;
    final String buttonText = language == 'fr' ? '=> English' : '=> Français';
    return Scaffold(
        appBar: AppBar(
          title: Text(
            allTranslations.text('ChooseOption'),
          ),
          actions: <Widget>[
            RaisedButton(
              color: Colors.orange,
              elevation: 5,
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Map(widget.peopleList)),
                  );
                },
                textColor: Colors.white,
                color: Colors.red[500],
                padding: const EdgeInsets.all(10.0),
                child: new Text(allTranslations.text('Map')),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StreetList(widget.peopleList)),
                  );
                },
                textColor: Colors.white,
                color: Colors.red[400],
                padding: const EdgeInsets.all(10.0),
                child: new Text(allTranslations.text('App')),
              ),
            ],
          ),
        ));
  }
}
