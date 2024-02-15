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

const apiKey = 'fdd8e34b-f586-40ea-b6c7-ec440f14905b';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getEthData(String currency) async {
    String requestURL = '$coinAPIURL/ETH/$currency?apikey=$apiKey';

    http.Response response = await http.get(Uri.parse(requestURL));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      var lastPrice = decodedData['rate'];
      print(lastPrice);

      return lastPrice;
    } else {
      print(response.statusCode);

      throw 'Problem with the get request';
    }
  }

  Future getLightCoinData(String currency) async {
    String requestURL = '$coinAPIURL/LTC/$currency?apikey=$apiKey';

    http.Response response = await http.get(Uri.parse(requestURL));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      var lastPrice = decodedData['rate'];
      print(lastPrice);

      return lastPrice;
    } else {
      print(response.statusCode);

      throw 'Problem with the get request';
    }
  }

  Future getBitCoinData(String currency) async {
    String requestURL = '$coinAPIURL/BTC/$currency?apikey=$apiKey';

    http.Response response = await http.get(Uri.parse(requestURL));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);

      var lastPrice = decodedData['rate'];
      print(lastPrice);

      return lastPrice;
    } else {
      print(response.statusCode);

      throw 'Problem with the get request';
    }
  }
}
