import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final List<String> listtext;
  const ItemCard(this.listtext, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text;
    listtext.removeWhere((element) => element == null);
    listtext.isNotEmpty ? text = listtext.join(" ") : text = "Unknow name";

    // listtext.join(" ");

    //listtext.map((e) => e != null ? listtext.join(" ") : listtext.join(""));
    return Card(
        shadowColor: Colors.blue[100],
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.blue[300]],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                  text: text,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            )));
  }
}
