import 'package:DissertationProject/results.dart';
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

enum RadioOptions { Car, Transit }

class PlannerFormState extends State<PlannerForm> {
  final _formKey = GlobalKey<FormState>();
  final _departureController = TextEditingController(text: "Newcastle"); 
  final _destinationController = TextEditingController(text: "London"); 
  RadioOptions _radioOptions = RadioOptions.Car;


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
              controller: _departureController,
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
              controller: _destinationController,
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
              value: RadioOptions.Car, 
              groupValue: _radioOptions, 
              onChanged: (RadioOptions value) {
                print(value);
                setState(() {
                  _radioOptions = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Public Transport'),
            leading: Radio(
              value: RadioOptions.Transit, 
              groupValue: _radioOptions, 
              onChanged: (RadioOptions value) {
                print(value);
                setState(() {
                  _radioOptions = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => Results(transportSort: _radioOptions.toString()))
                  );
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