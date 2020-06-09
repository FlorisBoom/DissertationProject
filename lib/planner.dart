import 'package:flutter/material.dart';

class Planner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PlannerForm(),
      ),
    );
  }
}

class PlannerForm extends StatefulWidget {
  @override
  PlannerFormState createState() {
    return PlannerFormState();
  }
}

enum SingingCharacter { car, transit }

class PlannerFormState extends State<PlannerForm> {
  final _formKey = GlobalKey<FormState>();
  SingingCharacter _character = SingingCharacter.car;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 400.0,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Point of departure",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                )
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 400.0,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Destination",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                )
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ListTile(
            title: const Text('Car'),
            leading: Radio(
              value: SingingCharacter.car, 
              groupValue: _character, 
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Public Transport'),
            leading: Radio(
              value: SingingCharacter.transit, 
              groupValue: _character, 
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}