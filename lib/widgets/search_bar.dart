import 'package:flutter/material.dart';
import 'package:coffeedic/models/coffee.dart';

class SearchBar extends StatefulWidget {
  final Function setkeyword;

  SearchBar({Key key, this.setkeyword}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2, right: 0),
      child: Row(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blueGrey[800],
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "찾고 싶은 원두명을 적어보세요",
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.blueGrey[300],
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueGrey[300],
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
                onChanged: (text) {
                  if (text == "")
                    widget.setkeyword(_searchControl.text.toString());
                }),
          )),
          IconButton(
            padding: new EdgeInsets.only(left: 12),
            icon: Icon(Icons.search),
            tooltip: 'Search name',
            onPressed: () {
              widget.setkeyword(_searchControl.text.toString());
            },
          ),
        ],
      ),
    );
  }
}
