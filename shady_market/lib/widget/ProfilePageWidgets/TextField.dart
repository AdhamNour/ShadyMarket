import 'package:flutter/material.dart';

class ProfileInfo extends StatefulWidget {
  final title, info, edit;
  final TextEditingController controller;

  ProfileInfo({this.title, this.info, this.edit, @required this.controller});

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  TextEditingController data;
  var value;
  final IconList = {
    "Name": Icon(
      Icons.person,
      color: Colors.blue,
    ),
    "Email": Icon(
      Icons.email,
      color: Colors.blue,
    ),
    "Location": Icon(
      Icons.location_history,
      color: Colors.blue,
    )
  };
  @override
  void initState() {
    super.initState();
    data = widget.controller;
    data.text = this.widget.info;
    value = this.widget.info;
    data.addListener(() {
      setState(() {
        value = data.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var View = Card(
        child: Container(
            decoration: BoxDecoration(
                border: Border.fromBorderSide(BorderSide(
              style: BorderStyle.solid,
              width: 1,
              color: Colors.blue,
            ))),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: IconList[widget.title],
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      value,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
            )));
    var Edit = TextField(
      controller: data,
      style: TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          labelText: this.widget.title,
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.blue, style: BorderStyle.solid))),
    );

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
        child: widget.edit ? Edit : View);
  }
}
