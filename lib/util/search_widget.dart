import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _createSearch();
  }

  Widget _createSearch() {
    return Container(
        height: 35,
        margin: EdgeInsets.only(left: 16, right: 16),
        padding: EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300]),
        child: new TextFormField(
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              icon: Icon(Icons.search),
              contentPadding: EdgeInsets.only(bottom: 11, top: 11),
              hintText: "Pesquisar"),
        ));
  }
}
