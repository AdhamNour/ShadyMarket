import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shady_market/models/Person.dart';
import 'package:shady_market/utils.dart';

class SellerWidget extends StatefulWidget {
  final Person owner;
  final Function onTap;
  SellerWidget(this.owner, {this.onTap});

  @override
  _SellerWidgetState createState() => _SellerWidgetState();
}

class _SellerWidgetState extends State<SellerWidget> {
  String userName = '', imageURL = '';
  @override
  void initState() {
    super.initState();
    if (widget != null) {
      userName = widget.owner.name;
      imageURL = widget.owner.pictureUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        child: imageURL != null
            ? CachedNetworkImage(
                imageUrl: imageURL,
                height: 50,
                width: 50,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 50,
                ),
              )
            : Container(),
      ),
      title: Text(userName),
      onTap: widget.onTap,
    );
  }
}
