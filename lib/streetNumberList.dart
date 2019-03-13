import 'package:flutter/material.dart';
import 'package:forecanvass/model/PersonModel.dart';
import 'tenantList.dart';
import 'text.dart';
import 'translate.dart';

class StreetNumberList extends StatefulWidget {
  final List<Person> peopleList;
  final String streetName;

  const StreetNumberList(
    this.peopleList,
    this.streetName, {
    Key key,
  }) : super(key: key);
  @override
  _StreetNumberListState createState() => _StreetNumberListState();
}

class _StreetNumberListState extends State<StreetNumberList> {
  final AllText allText = AllText();

  String streetName;
  bool descend = false;
  int mode = 0;
  IconData sort = Icons.arrow_upward, filter = Icons.filter;
  List<int> allList = [], evenList = [], oddList = [];

  Future<List<int>> getList(int mode, bool descend) async {
    allList.sort();
    evenList.sort();
    oddList.sort();

    if(descend)
    {
      allList = allList.reversed.toList();
      oddList = oddList.reversed.toList();
      evenList = evenList.reversed.toList();
    }

    switch (mode) {
      case 0:
        return allList;
      case 1:
        return oddList;
      case 2:
        return evenList;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final String language = allTranslations.currentLanguage;
    final String buttonText = language == 'fr' ? '=> English' : '=> Français';

    // Loop to get all street numbers in a list.
    for (int i = 0; i < widget.peopleList.length; i++) {
      if (widget.peopleList[i].streetName == widget.streetName) {
        //same street
        if (!allList.contains(widget.peopleList[i].streetNumber)) {
          //different numbers
          if (widget.peopleList[i].streetNumber % 2 == 0) // evens
            evenList.add(widget.peopleList[i].streetNumber);
          else
            oddList.add(widget.peopleList[i].streetNumber);
          allList.add(widget.peopleList[i].streetNumber);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.streetName),
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
      body: FutureBuilder<List<int>>(
        future: getList(mode, descend),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data[index].toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TenantList(widget.peopleList,
                            widget.streetName, snapshot.data[index]),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "Sorting",
              child: Icon(sort),
              onPressed: () async {
                if (descend) {
                  descend = false;
                  sort = Icons.arrow_upward;
                } else {
                  descend = true;
                  sort = Icons.arrow_downward;
                }
                setState(() {});
              },
            ),
            FloatingActionButton(
              heroTag: "Filtering",
              child: Icon(filter),
              onPressed: () async {
                switch (mode) {
                  case 0:
                    filter = Icons.filter_1;
                    mode = 1;
                    break;
                  case 1:
                    filter = Icons.filter_2;
                    mode = 2;
                    break;
                  case 2:
                    filter = Icons.filter;
                    mode = 0;
                    break;
                }
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
