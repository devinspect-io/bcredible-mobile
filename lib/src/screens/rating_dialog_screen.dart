import 'package:flutter/material.dart';

class RatingDialog extends StatefulWidget {
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 0;
  String _review = 'I rated this business 10/10';

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        // size: 30.0,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
          _stars = starCount;
        });
      },
    );
  }

  Widget _buildTextArea() {
    return TextField(
        maxLines: 3,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(hintText: "Type your comment in here"),
        onChanged: (text) {
          setState(() {
            _review = text;
          });
        });
  }

  Container _addTopMargin(double x) {
    return Container(height: x);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Rate this Business'),
      ),
      content: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildStar(1),
            _buildStar(2),
            _buildStar(3),
            _buildStar(4),
            _buildStar(5),
          ],
        ),
        _addTopMargin(20),
        _buildTextArea()
      ]),
      actions: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.zero,
                child: Text('CANCEL'),
                onPressed: Navigator.of(context).pop,
              ),
              FlatButton(
                padding: EdgeInsets.zero,
                child: Text('SAVE'),
                onPressed: () {
                  Map data = {'stars': _stars, 'review': _review};
                  Navigator.of(context).pop(data);
                },
              )
            ])
      ],
    );
  }
}
