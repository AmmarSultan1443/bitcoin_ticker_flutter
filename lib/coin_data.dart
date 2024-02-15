import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'd0a3aa8f-08d2-481b-b0a6-05fced11808b';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getCoinData() async {
    String requestURL = '$coinAPIURL/BTC/USD?apikey=$apiKey';

    http.Response response = await http.get(Uri.parse(requestURL));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      var lastPrice = decodedData['rate'];

      return lastPrice;
    } else {
      print(response.statusCode);

      throw 'Problem with the get request';
    }
  }
}
