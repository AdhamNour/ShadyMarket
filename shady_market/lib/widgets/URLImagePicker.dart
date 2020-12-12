import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class URLImagePicker extends StatefulWidget {
  URLImagePicker({
    Key key,
    @required this.imageURLController,
    @required this.editingURL,
  }) : super(key: key);

  final TextEditingController imageURLController;
  String editingURL;

  @override
  _URLImagePickerState createState() => _URLImagePickerState();
}

class _URLImagePickerState extends State<URLImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: widget.imageURLController.text.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: widget.imageURLController.text,
                    width: 150,
                    height: 150,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error,
                            size: 50,
                            color: Theme.of(context).errorColor,
                          ),
                          Text('InValid URL')
                        ],
                      ),
                    ),
                  )
                : Container(
                    child: FlutterLogo(),
                    width: 150,
                    height: 150,
                  ),
          ),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15)),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: 'imageURL'),
            controller: widget.imageURLController,
            validator: (value) => isURL(value) ? null : 'not a valid URL',
            onSaved: (newValue) => widget.editingURL = newValue,
            onChanged: (value) {
              setState(() {});
            },
          ),
        ))
      ],
    );
  }
}
