import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shady_market/providers/ProductsListProvider.dart';
import 'package:shady_market/widget/AnimatedButton.dart';

class ProfilePicture extends StatelessWidget {
  var URL;
  final isEditing;
  void Function(String newValue) onSave ;
   ProfilePicture({this.URL, @required this.isEditing,@required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: Stack(alignment: Alignment.topCenter, children: [
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Colors.red, Colors.blue]),
            ),
            height: 200,
            width: double.infinity,
          ),
        ),
        Container(
            height: 150.0,
            width: 150.0,
            margin: EdgeInsets.only(left: 20, right: 20, top: 100),
            child: Stack(
              children: [
                ClipOval(
                    child: Image.network(
                  this.URL,
                  fit: BoxFit.fill,
                )),
                if (isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: AnimatedButton(
                      child: Icon(Icons.camera),
                      onPressed: () {
                        TextEditingController controller = TextEditingController();
                        showDialog(
                            context: context,
                            child: AlertDialog(
                                title: Text("Add Photo"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Please add The URL of your picture"),
                                    TextField(controller: controller,)
                                  ],
                                ),actions: [
                                  FlatButton.icon(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.done), label: Text("Done")),
                                  FlatButton.icon(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.cancel), label: Text("Cancel"))
                                ],)).then((value) {
                                  onSave(controller.text);
                                  Provider.of<ProdcutsListProvider>(context, listen: false).fetchProducts();
                                });
                      },
                    ),
                  )
              ],
            )),
      ]),
    );
  }
}


