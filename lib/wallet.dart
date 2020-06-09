import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [WalletAmount()],
            ),
          ],
        ),
      )
    );
  }
}

class WalletAmount extends StatefulWidget {
  @override
  State<WalletAmount> createState() => WalletAmountState();
}

class WalletAmountState extends State<WalletAmount> {
  int _money = 0;

  @override
  void initState() {
    super.initState();
    _loadWallet();
  }

  _loadWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _money = (prefs.getInt('money') ?? 0);
    });
    print('Initial money load = $_money');  
  }

  _updateWallet(topUpAmount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _money = _money += topUpAmount;
      prefs.setInt('money', _money);
    });
  }

  Future<int> _openTopUpForm(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Amount to top up'),
          content: TextFormField(
            controller: _textController,
            keyboardType: TextInputType.number,
          ),
          actions: [
            MaterialButton(
              elevation: 5.0,
              child: Text('Top up!'),
              onPressed: () {
                Navigator.of(context).pop(int.parse(_textController.text.toString()));
              },
              color: Colors.blue,
            )
          ],
        );
      },// barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Text('\$ $_money'),
            SizedBox(height: 10),
            RaisedButton(
              padding: EdgeInsets.all(10),
              color: Colors.blue,
              child: Text('Top up', style: TextStyle(color: Colors.white)),
              onPressed: () { 
                _openTopUpForm(context).then((value) {
                  _updateWallet(value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}