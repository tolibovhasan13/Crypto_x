// ignore_for_file: file_names
import 'package:crypro_x/second_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class CoinCard extends StatefulWidget {
  CoinCard({
    Key? key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  }) : super(key: key);

  String name;
  String symbol;
  String imageUrl;
  double price;
  double change;
  double changePercentage;

  @override
  State<CoinCard> createState() => _CoinCardState();
}

class _CoinCardState extends State<CoinCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondPage(
                name: widget.name,
                symbol: widget.symbol,
                imageUrl: widget.imageUrl,
                price: widget.price.toDouble(),
                change: widget.change.toDouble(),
                changePercentage: widget.changePercentage.toDouble(),
              ),
            ),
          );
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(4, 4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(4, 4),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  height: 60,
                  width: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
              Expanded(
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.name,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        widget.symbol,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      // ignore: unnecessary_brace_in_string_interps
                      '\$${widget.price}',
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
