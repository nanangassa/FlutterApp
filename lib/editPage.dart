import 'package:flutter/material.dart';
import 'package:forecanvass/model/PersonModel.dart';
import 'package:forecanvass/database/Database.dart';
import 'text.dart';
import 'translate.dart';

class EditPage extends StatefulWidget {
  final List<Person> peopleList;
  final int personId;

  const EditPage(
    this.peopleList,
    this.personId, {
    Key key,
  }) : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  int lawnSignStatus = -1;
  int donateStatus = -1;
  int volunteerStatus = -1;

  final _formKey = GlobalKey<FormState>();

  final AllText allText = AllText();

  // Variables to collect checkbox values to be able to save only when check button
  // gets pressed at the end.
  int signValue = 0;
  int donateValue = 0;
  int volunteerValue = 0;

  @override
  Widget build(BuildContext context) {
    final String language = allTranslations.currentLanguage;
    final String buttonText = language == 'fr' ? '=> English' : '=> Français';

    int peopleListIndex;

    for (int i = 0; i < widget.peopleList.length; i++) {
      if (widget.peopleList[i].personId == widget.personId) {
        peopleListIndex = i;
        break;
      }
    }

    String phoneNumber;
    // Prints 'null' in the phoneNumber field if not set to '' due to toString().
    if (widget.peopleList[peopleListIndex].phoneNumber == null) {
      phoneNumber = '';
    } else {
      phoneNumber = widget.peopleList[peopleListIndex].phoneNumber.toString();
    }

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
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            children: <Widget>[
              TextFormField(
                initialValue: widget.peopleList[peopleListIndex].firstName,
                decoration: InputDecoration(
                  labelText: (allTranslations.text('First Name')),
                  icon: Icon(Icons.person),
                  hintText: widget
                      .peopleList[peopleListIndex].firstName, // First name
                ),
                onSaved: (value) {
                  widget.peopleList[peopleListIndex].firstName = value;
                },
              ),
              TextFormField(
                initialValue: widget.peopleList[peopleListIndex].lastName,
                decoration: InputDecoration(
                  labelText: (allTranslations.text('Last Name')),
                  icon: Icon(Icons.person),
                  hintText:
                      widget.peopleList[peopleListIndex].lastName, // Last name
                ),
                onSaved: (value) {
                  widget.peopleList[peopleListIndex].lastName = value;
                },
              ),
              TextFormField(
                initialValue: phoneNumber,
                decoration: InputDecoration(
                  labelText: (allTranslations.text('Phone Number')),
                  icon: Icon(Icons.phone),
                  hintText: phoneNumber, //Phone #
                ),
                onSaved: (value) {
                  widget.peopleList[peopleListIndex].phoneNumber =
                      int.parse('phoneNumber');
                },
              ),
              TextFormField(
                initialValue: widget.peopleList[peopleListIndex].email,
                decoration: InputDecoration(
                  labelText: (allTranslations.text('Email')),
                  icon: Icon(Icons.email),
                  hintText: widget.peopleList[peopleListIndex].email, //Email
                ),
                onSaved: (value) {
                  widget.peopleList[peopleListIndex].email = value;
                },
              ),
              TextFormField(
                initialValue: widget.peopleList[peopleListIndex].mark,
                decoration: InputDecoration(
                  labelText: (allTranslations.text('Support Level')),
                  icon: Icon(Icons.add),
                  hintText: widget.peopleList[peopleListIndex].mark, // Support
                ),
                onSaved: (value) {
                  widget.peopleList[peopleListIndex].mark = value;
                },
              ),
              TextFormField(
                initialValue: widget.peopleList[peopleListIndex].notes,
                decoration: InputDecoration(
                  labelText: (allTranslations.text('Notes')),
                  icon: Icon(Icons.message), // Notes
                ),
                onSaved: (value) {
                  widget.peopleList[peopleListIndex].notes = value;
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: 10),
              ),

              //Shows the radio buttons for questions "Lawn Sign", "Donate", and "Volunteer"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 130,
                    child: Text(
                      allText.lawnSign + '?',
                      style: TextStyle(fontSize: allText.radioTextSize),
                    ),
                  ),
                  Checkbox(
                      value: DBProvider.db.intToBool(signValue),
                      onChanged: (value) {
                        setState(() {
                          signValue = DBProvider.db.boolToInt(value);
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 130,
                    child: Text(
                      allText.donate + '?',
                      style: TextStyle(fontSize: allText.radioTextSize),
                    ),
                  ),
                  Checkbox(
                      value: DBProvider.db.intToBool(donateValue),
                      onChanged: (value) {
                        setState(() {
                          donateValue = DBProvider.db.boolToInt(value);
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 130,
                    child: Text(
                      allText.volunteer + '?',
                      style: TextStyle(fontSize: allText.radioTextSize),
                    ),
                  ),
                  Checkbox(
                      value: DBProvider.db.intToBool(volunteerValue),
                      onChanged: (value) {
                        setState(() {
                          volunteerValue = DBProvider.db.boolToInt(value);
                        });
                      }),
                ],
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  widget.peopleList[peopleListIndex].sign = signValue;
                  widget.peopleList[peopleListIndex].donate = donateValue;
                  widget.peopleList[peopleListIndex].volunteer = volunteerValue;
                  DBProvider.db
                      .updatePerson(widget.peopleList[peopleListIndex]);
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Information saved!")));
                  _formKey.currentState.save();
                },
                child: Icon(Icons.check),
              )
            ],
          ),
        );
      }),
    );
  }
}
