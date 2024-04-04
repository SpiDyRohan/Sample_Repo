import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_sample/RouteDetail/stock_list.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trading App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WatchlistScreen(),
    );
  }
}

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final List<Stock> _watchlist = [];
  final _channel = IOWebSocketChannel.connect('ws://122.179.143.201:8089/websocket?sessionID=ROHIT&userID=ROHIT&apiToken=ROHIT');
  Map<String, dynamic> stocksData1 = {};
  Map<int, Map<String, dynamic>> stocksData2 = {
    7: {
      "symbol": "AARTIIND",
      "company": "AARTI INDUSTRIES LTD",
      "industry": "Specialty Chemicals",
      "sectoralIndex": "NIFTY 500"
    },
    13: {
      "symbol": "ABB",
      "company": "ABB INDIA LIMITED",
      "industry": "Heavy Electrical Equipment",
      "sectoralIndex": "NIFTY INFRASTRUCTURE"
    },
    22: {
      "symbol": "ACC",
      "company": "ACC LIMITED",
      "industry": "Cement & Cement Products",
      "sectoralIndex": "NIFTY COMMODITIES"
    },
    25: {
      "symbol": "ADANIENT",
      "company": "ADANI ENTERPRISES LIMITED",
      "industry": "Trading - Minerals",
      "sectoralIndex": "NIFTY 500"
    },
  };
  List<StockList> matchedStocks = [];


  @override
  void initState() {
    super.initState();
    // Subscribe to initial stocks
    _subscribeToStocks();
    // Listen for WebSocket messages
    _channel.stream.listen((message) {
      // Handle WebSocket messages
      _handleMessage(message);

    }).onError((error){
      print("error ${error.toString()}");
    });
  }

  @override
  void dispose() {
    // Close WebSocket connection
    _channel.sink.close();
    super.dispose();
  }

  void _subscribeToStocks() {

    final tokens = _watchlist.map((stock) => stock.token).toList();
    _channel.sink.add(jsonEncode({
      "Task": "subscribe",
      "Mode": "ltp",
      "Tokens": [3, 7, 13, 17, 19, 22, 25]
    }));
  }

  void _handleMessage(dynamic message) {
    final data = jsonDecode(message);
    stocksData1=data;
    stocksData2.forEach((key1, value1) {
      if (stocksData2.containsKey(key1)) {
        int ltp= 0 ;
        if(stocksData1["${key1}"]!=null){
          ltp = stocksData1["${key1}"];

        }else{

        }

        Map<String, dynamic> stockData2 = stocksData2[key1]!;
        StockList stockList=StockList();
        stockList.key=key1;
        stockList.symbol=stockData2["symbol"];
        stockList.company=stockData2["company"];
        stockList.industry=stockData2["industry"];
        stockList.sectoralIndex=stockData2["sectoralIndex"];
        stockList.ltp="${ltp}";
       if(!matchedStocks.contains(stockList)){
         matchedStocks.add(stockList);
       }else{
         matchedStocks.remove(stockList);
       }
      }
    });

    // print("matchedStocks ${jsonEncode(matchedStocks)}");

/*    if (data['Mode'] == 'ltp') {
      final token = data['Token'];
      final ltp = data['LTP'];
      setState(() {
        final stock = _watchlist.firstWhere((stock) => stock.token == token);
        stock.ltp = ltp;
      });
    }*/
  }

  void _removeStock(int index) {
    final removedStock = matchedStocks.removeAt(index);
    final tokens = [removedStock.key];
    _channel.sink.add(jsonEncode({
      "Task": "unsubscribe",
      "Mode": "ltp",
      "Tokens": [3, 7]
    }));
  }

  @override
  Widget build(BuildContext context) {
    matchedStocks=matchedStocks.toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: ListView.builder(
        itemCount: matchedStocks.length,
        itemBuilder: (context, index) {
          final stock = matchedStocks[index];
          return Dismissible(
            key: Key(stock.key.toString()),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              setState(() {
                _removeStock(index);
              });
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            child: ListTile(
              title: Text(stock.symbol.toString()),
              subtitle: Text('LTP: ${stock.ltp}'),
              trailing: Text("${stock.company}"),
            ),
          );
        },
      ),
    );
  }
}

class Stock {
  final String symbol;
  final int token;
  String ltp;

  Stock({
    required this.symbol,
    required this.token,
    this.ltp = 'N/A',
  });
}
