import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shady_market/model/Product.dart';
import 'package:shady_market/widgets/URLImagePicker.dart';
import 'package:validators/validators.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/EditProductScreen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  Product editingProduct;
  bool isEditing = false;

  File _pickedImage;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageURLController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool takingPcitureViaCamera = false;

  void save() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    //TODO: implement the save function
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      setState(() {
        final Product _product =
            ModalRoute.of(context).settings.arguments as Product;
        if (_product == null) {
          editingProduct = Product(
              null, null, null, null, null, null, null, null, null, null);
          isEditing = false;
        } else {
          editingProduct = _product;
          nameController.text = _product.name;
          priceController.text = _product.price.toString();
          descriptionController.text = _product.discription;
          imageURLController.text = _product.pic;
          isEditing = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${isEditing ? 'Editing' : 'Adding'} Prodcut'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: nameController,
                  onSaved: (newValue) => editingProduct.name = newValue,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  validator: (value) =>
                      isFloat(value) ? null : 'entre a valid number,please',
                  onSaved: (newValue) =>
                      editingProduct.price = double.parse(newValue),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                  onSaved: (newValue) => editingProduct.discription = newValue,
                  maxLines: null,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: !takingPcitureViaCamera
                      ? URLImagePicker(
                          editingURL: editingProduct.pic,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(takingPcitureViaCamera
                        ? 'Picking from device'
                        : 'URL image'),
                    Switch(
                      value: takingPcitureViaCamera,
                      onChanged: (value) {
                        setState(() {
                          takingPcitureViaCamera = value;
                        });
                      },
                    )
                  ],
                )
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: save,
        child: Icon(Icons.save),
      ),
    );
  }
}
