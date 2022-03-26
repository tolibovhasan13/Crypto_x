import 'dart:convert';
import 'package:crypro_x/search_list.dart';
// ignore: unused_import
import 'package:crypro_x/second_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'coinCard.dart';
import 'coinModel.dart';


class Home extends StatefulWidget {
  const Home({Key? key,}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      // ignore: prefer_is_empty
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          coinList.add(Coin.fromJson(map));
        }
      }

      return coinList;
    } else {
      return coinList;
    }
  }

  @override
  void initState() {
    fetchCoin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          'CRYPTO X',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchList(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          refreshIndicatorKey.currentState?.show();
          await fetchCoin();
        },
        child: FutureBuilder<List<Coin>>(
            future: fetchCoin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Internet bilan muammo bor',
                    style: TextStyle(fontSize: 30),
                  ),
                );
              } else {
                List<Coin> countries = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    // ignore: unused_local_variable
                    final coinL = coinList[index];
                    return CoinCard(
                      name: coinList[index].name,
                      symbol: coinList[index].symbol,
                      imageUrl: coinList[index].imageUrl,
                      price: coinList[index].price.toDouble(),
                      change: coinList[index].change.toDouble(),
                      changePercentage:
                          coinList[index].changePercentage.toDouble(),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
