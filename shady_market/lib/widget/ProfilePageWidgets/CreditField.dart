import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/providers/CurrentUserProvider.dart';

class CreditField extends StatefulWidget {
  final title, info, isEdit, savingFunction;
  // function save
  const CreditField({this.title, this.info, this.isEdit, this.savingFunction});

  @override
  _CreditFieldState createState() => _CreditFieldState();
}

class _CreditFieldState extends State<CreditField> {
  var value, save, Title;

  @override
  void initState() {
    super.initState();
    value = widget.info;
    if (widget.title == null) {
      Title = 'Credit';
    } else {
      Title = widget.title;
    }
    if (widget.savingFunction == null) {
      save = (data) {
        setState(() {
          Provider.of<CurrentUserProvider>(context, listen: false).credit =
              double.parse(data);

          print(value);
        });
      };
    } else {
      save = widget.savingFunction;
    }
  }

  void _addCredit({context}) {
    var data = value;
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              void add() {
                setState(() {
                  data = (num.parse(data) + 1).toString();
                });
              }

              void subtract() {
                setState(() {
                  data = (num.parse(data) - 1).toString();
                });
              }

              void close() {
                Navigator.pop(context);
              }

              return AlertDialog(
                title: Text("Change " + Title),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(onPressed: subtract, child: Icon(Icons.remove)),
                    Container(
                      child: Text(data),
                    ),
                    FlatButton(onPressed: add, child: Icon(Icons.add)),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: close,
                      child: Text(
                        'Discard',
                        style: TextStyle(color: Colors.red),
                      )),
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          value = data.toString();
                        });
                        save(data);
                        close();
                      },
                      child: Text('Save')),
                ],
              );
            })).then((_) => setState(() {}));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
      child: Row(
        children: [
          Credit(value: value),
          widget.isEdit
              ? (Container(
                  margin: EdgeInsets.only(left: 15.0),
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _addCredit(context: context);
                      });
                    },
                    child: Text("Add " + this.Title),
                  ),
                ))
              : Container()
        ],
      ),
    );
  }
}

class Credit extends StatelessWidget {
  Credit({Key key, @required this.value, this.ICON}) : super(key: key);

  var value, ICON;

  @override
  Widget build(BuildContext context) {
    var val = this.ICON == null ? Icons.monetization_on : this.ICON;
    return Expanded(
      child: Card(
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
                  child: Icon(
                    val,
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    value,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ],
            )),
      ),
    );
  }
}
