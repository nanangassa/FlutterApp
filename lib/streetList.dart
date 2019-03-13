import 'package:flutter/material.dart';
import 'package:forecanvass/model/PersonModel.dart';
import 'streetNumberList.dart';
import 'text.dart';
import 'translate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    final List<Person> peopleList= null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      
      home: StreetList(peopleList),
    );
  }
}

class StreetList extends StatefulWidget {
  final List<Person> peopleList;

  const StreetList(
    this.peopleList, {
    Key key,
  }) : super(key: key);

  @override
  _StreetListState createState() => _StreetListState();
}

class _StreetListState extends State<StreetList> {
  final AllText allText = AllText();
  @override
  Widget build(BuildContext context) {
    final String language = allTranslations.currentLanguage;
    final String buttonText = language == 'fr' ? '=> English' : '=> Français';

    List<String> streetList = [];

    // Loop to get all steet names in a list
    for (int i = 0; i < widget.peopleList.length; i++) {
      if (!streetList.contains(widget.peopleList[i].streetName))
        streetList.add(widget.peopleList[i].streetName);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          allTranslations.text('streets'),
        ),
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
      body: Container(
        child: ListView.builder(
          itemCount: streetList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(streetList[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StreetNumberList(
                        widget.peopleList, (streetList[index])),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
