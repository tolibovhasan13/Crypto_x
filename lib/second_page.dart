import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage(
      {Key? key,
      required this.name,
      required this.symbol,
      required this.imageUrl,
      required this.price,
      required this.change,
      required this.changePercentage})
      : super(key: key);

  final String name;
  final String symbol;
  final String imageUrl;
  final double price;
  final double change;
  final double changePercentage;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 2,
          backgroundColor: Colors.grey[300],
          title: Text(
            widget.name,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: Column(
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Image', style: TextStyle(fontSize: 18)),
                      // ignore: sized_box_for_whitespace
                      Container(
                        width: 50,
                        height: 50,
                        child: CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                    ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(widget.name)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Symbol', style: TextStyle(fontSize: 18)),
                      Text(widget.symbol)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Price', style: TextStyle(fontSize: 18)),
                      Text('\$${widget.price}')
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Price change 24h',
                          style: TextStyle(fontSize: 18),
                          ),
                      Text(
                        widget.change.toDouble() < 0
                            ? widget.change.toDouble().toString()
                            : '+' + widget.change.toDouble().toString(),
                        style: TextStyle(
                          color: widget.change.toDouble() < 0
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Price change percentage 24h',
                          style: TextStyle(fontSize: 18)),
                      Text(
                        widget.changePercentage.toDouble() < 0
                            ? widget.changePercentage.toDouble().toString() +
                                '%'
                            : '+' +
                                widget.changePercentage.toDouble().toString() +
                                '%',
                        style: TextStyle(
                          color: widget.changePercentage.toDouble() < 0
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}






class SearchListWidget extends StatefulWidget {
  const SearchListWidget({Key? key}) : super(key: key);

  @override
  _SearchListWidgetState createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  final initList = List<String>.generate(10000, (i) => "Search Item $i");
  TextEditingController editingController = TextEditingController();
  // ignore: deprecated_member_use
  var showItemList = <String>[];

  @override
  void initState() {
    showItemList.addAll(initList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: editingController,
          decoration: const InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            filterSearch(value);
          },
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: showItemList.length,
            itemBuilder: (context, index) {
              return ListTile(
                // ignore: unnecessary_string_interpolations
                title: Text('${showItemList[index]}'),
              );
            },
          ),
        ),
      ],
    );
  }

  filterSearch(String query) {
    List<String> searchList = <String>[];
    searchList.addAll(initList);
    if (query.isNotEmpty) {
      List<String> resultListData = <String>[];
      // ignore: avoid_function_literals_in_foreach_calls
      searchList.forEach((item) {
        if (item.contains(query)) {
          resultListData.add(item);
        }
      });
      setState(() {
        showItemList.clear();
        showItemList.addAll(resultListData);
      });
      return;
    } else {
      setState(() {
        showItemList.clear();
        showItemList.addAll(initList);
      });
    }
  }
}