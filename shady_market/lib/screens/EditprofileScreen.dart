import 'package:flutter/material.dart';
import 'package:shady_market/DATA.dart';
import "package:shady_market/model/Person.dart";
import 'package:shady_market/screens/ProductsScreen.dart';
import 'package:shady_market/widgets/URLImagePicker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/EditProfileScreen';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool takingPcitureViaCamera = false;
  File _pickedImage;
  final imageURLController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> locations = <String>["Cairo", "Alex", "PortSaid"];
  String location;

  void save() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    //TODO: implement the save function
  }

  @override
  Widget build(BuildContext context) {
    Person user = ModalRoute.of(context).settings.arguments as Person;
    bool isOwner = user.id == currentUser.id;
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Picture
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: !takingPcitureViaCamera
                      ? URLImagePicker(
                          editingURL: user.pic,
                          imageURLController: imageURLController,
                        )
                      : ClipRRect(
                          child: GestureDetector(
                            child: Container(
                                height: 150,
                                width: 150,
                                child: _pickedImage == null
                                    ? FlutterLogo()
                                    : Image.file(_pickedImage),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(15))),
                            onTap: () async {
                              final source = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(
                                            'Choose the source of your picture'),
                                        content: Text(
                                            'the source of your picture is'),
                                        actions: [
                                          FlatButton.icon(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(ImageSource.camera),
                                              icon: Icon(Icons.camera),
                                              label: Text('Camera')),
                                          FlatButton.icon(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(ImageSource.gallery),
                                              icon: Icon(Icons.photo_library),
                                              label: Text('Gallery'))
                                        ],
                                      ));
                              final image =
                                  await ImagePicker().getImage(source: source);
                              if (image == null) {
                                return;
                              }
                              setState(() {
                                _pickedImage = File(image.path);
                              });
                            },
                          ),
                          borderRadius: BorderRadius.circular(15)),
                ),
                //Name
                Row(
                  children: [
                    Text("Profile Name"),
                    Expanded(
                        child: TextField(
                      controller: nameController,
                    ))
                  ],
                ),
                //Email
                Text('Email:' + user.email),
                //Location
                Row(
                  children: [
                    Text("Location:"),
                    DropdownButton<String>(
                      hint: Text("Select item"),
                      value: location,
                      onChanged: (String Value) {
                        setState(() {
                          location = Value;
                        });
                      },
                      items: locations.map((String user) {
                        return DropdownMenuItem<String>(
                          value: user,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                user,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                //Credit
                Row(
                  children: [
                    Text("Credit"),
                    RaisedButton(
                      onPressed: () {
                        TextEditingController controller =
                            TextEditingController();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              FlatButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop(controller.text);
                                  },
                                  icon: Icon(Icons.add_circle),
                                  label: Text("add")),
                              FlatButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop(null);
                                  },
                                  icon: Icon(Icons.cancel),
                                  label: Text('cancel'))
                            ],
                            content: Row(
                              children: [
                                Text('amount:'),
                                Expanded(
                                    child: TextField(controller: controller))
                              ],
                            ),
                          ),
                        ).then((value) {
                          if (value != null) {
                            currentUser.credit += double.parse(value);
                            //TODO: Update the db
                          }
                        });
                      },
                      child: Text("Add Credit"),
                    )
                  ],
                ),
                //List of Transactions
                RaisedButton(
                  onPressed: () {
                    user.name = nameController.text;
                    user.location = location;
                    Navigator.of(context).pushNamed(
                        ProductsScreen.routeName); //For Showing Transactions
                  },
                  child: Text("Save"),
                ),
                //List of products Owned
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); //For Showing Transactions
                  },
                  child: Text("Discard"),
                ),
              ],
            ),
          ),
        ));
  }
}
