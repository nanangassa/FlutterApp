import 'package:flutter/material.dart';
import 'package:forecanvass/model/PersonModel.dart';
import 'editPage.dart';
import 'text.dart';
import 'translate.dart';

class TenantList extends StatefulWidget {
  final List<Person> peopleList;
  final String streetName;
  final int streetNumber;

  const TenantList(this.peopleList, this.streetName, this.streetNumber,
      {Key key})
      : super(key: key);

  @override
  _TenantListState createState() => _TenantListState();
}

class _TenantListState extends State<TenantList> {
  final AllText allText = AllText();
  @override
  Widget build(BuildContext context) {
    final String language = allTranslations.currentLanguage;
    final String buttonText = language == 'fr' ? '=> English' : '=> Français';

    List<Person> tenantList = [];

    // Loop to get all tenants at address.
    for (int i = 0; i < widget.peopleList.length; i++) {
      if (widget.peopleList[i].streetName == widget.streetName) {
        if (widget.peopleList[i].streetNumber == widget.streetNumber) {
          tenantList.add(widget.peopleList[i]);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(allText.tenantListTitle),
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
          itemCount: tenantList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tenantList[index].firstName +
                  ' ' +
                  tenantList[index].lastName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditPage(
                          widget.peopleList, tenantList[index].personId)),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
