import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Results extends StatelessWidget {
  final String transportSort;

  const Results({Key key, this.transportSort}) : super(key: key);

  Widget build(BuildContext context) {
    if (transportSort == "RadioOptions.Car") {
      return Scaffold(
        appBar: AppBar(
          title: Text('Two drivers found nearby!'),
        ),
        body: Column(
          children: [
            Padding( 
              padding: EdgeInsets.only(top: 10),
              child: Text("Tap the card to book driver", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Center(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          _book(context, 160, "Car drive from Newcastle - London; £160");
                        },
                        child: Container(
                          width: 300,
                          height: 100,
                          padding: EdgeInsets.all(30),
                          child: Text('Greg is available in a Mercedes-Benz CLK500 and charges £160'),
                        ),
                      )
                    )
                  ),
                  Center(
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          _book(context, 155, "Car drive from Newcastle - London; £155");
                        },
                        child: Container(
                          width: 300,
                          height: 100,
                          padding: EdgeInsets.all(30),
                          child: Text('Emily is available in Volvo V70 and charges £155'),
                        ),
                      )
                    )
                  ),
                ],
              )
            )
          ]
        )
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Transit schedule'),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Center(
                child: Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      _book(context, 80, "Train trip from Newcastle - London at 12:30; £80");
                    },
                    child: Container(
                      width: 300,
                      height: 100,
                      padding: EdgeInsets.all(30),
                      child: Text('Train from Newcastle - London £80 - 12:30'),
                    ),
                  )
                )
              ),
              Center(
                child: Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      _book(context, 80, "Train trip from Newcastle - London at 13:30; £80");
                    },
                    child: Container(
                      width: 300,
                      height: 100,
                      padding: EdgeInsets.all(30),
                      child: Text('Train from Newcastle - London £80 - 13:30'),
                    ),
                  )
                )
              ),
            ],
          )
        )
      );
    }
  }
}

_book(BuildContext context, int price, String _bookingDetails) async {
  int _money;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _money = (prefs.getInt('money') ?? 0);
  print(_money);
  if (price > _money) {
    return showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
          title: Text('Not enough money!'),
          actions: [
            MaterialButton(
              elevation: 5.0,
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.blue,
            )
          ],
        );
      }
    );
  } else {
    _money -= price;
    prefs.setInt('money', _money);
    prefs.setString('lastestBooking', _bookingDetails);
    return showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
          title: Text('Booking made!'),
          actions: [
            MaterialButton(
              elevation: 5.0,
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.blue,
            )
          ],
        );
      }
    );
  }
}

