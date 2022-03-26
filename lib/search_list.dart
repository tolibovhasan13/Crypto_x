import 'package:flutter/material.dart';


class SearchList extends StatefulWidget {
  const SearchList({ Key? key,}) : super(key: key);
  

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final initList = List<String>.generate(10000, (i) => "Search Item $i");
  TextEditingController editingController = TextEditingController();
  var showItemList = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: editingController,
          decoration: const InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            
          },
        ),
      ),
    );
  }
}