import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  TextEditingController controller = new TextEditingController();
  dynamic onChanged;
  SearchWidget(this.controller, this.onChanged);
  @override
  Widget build(BuildContext context) {
    return _createSearch(controller, onChanged);
  }

  Widget _createSearch(TextEditingController controller, dynamic onChanged) {
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
          controller: controller,
          onChanged: onChanged,
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
