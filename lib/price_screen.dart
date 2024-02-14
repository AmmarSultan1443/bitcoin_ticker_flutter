import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

const apiKey = 'C3104D33-7A73-4A1A-8418-15B5D13B623C';
const url = 'https://rest.coinapi.io/v1/exchangerate/BTC/';
//BTC/USD?apikey=$apiKey

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';
  String textMessage = '1 BTC = ? USD';

  dynamic data;

  // Getting data from the CoinApi
  void getData() async {
    CoinData coinData = CoinData();
    String fullUrl = url + selectedCurrency! + '?apiKey=' + apiKey;
    print(fullUrl);
    data = await coinData.getCoinData(fullUrl);
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
          updateUI(data);
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
        setState(() {
          updateUI(data);
        });
      },
      itemExtent: 32.0,
      children: pickerItems,
    );
  }

  void updateUI(dynamic coinApiResponse) {
    setState(() {
      if (coinApiResponse != null) {
        double rate = coinApiResponse['rate'];
        String formattedRate = rate.toStringAsFixed(2);
        textMessage = '1 BTC = $formattedRate $selectedCurrency';
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    updateUI(data);
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
                  textMessage,
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
