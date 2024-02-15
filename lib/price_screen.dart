import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

//BTC/USD?apikey=$apiKey

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';

  String bitcoinValueInUSD = '?';

  // Getting data from the CoinApi
  void getData() async {
    try {
      double data = await CoinData().getCoinData();

      setState(() {
        bitcoinValueInUSD = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  Widget androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      var dropDownItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropDownItems.add(dropDownItem);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (String? value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  Widget iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        print(selectedCurrency);
        setState(() {});
      },
      itemExtent: 32.0,
      children: pickerItems,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinValueInUSD USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropDown()),
        ],
      ),
    );
  }
}
