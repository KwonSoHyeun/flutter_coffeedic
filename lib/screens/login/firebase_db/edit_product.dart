import 'package:coffeedic/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/provider/product_provider.dart';

class EditProduct extends StatefulWidget {
  final Coffee product;

  EditProduct([this.product]);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final nameController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();

  final acidityController = TextEditingController();
  final balanceController = TextEditingController();
  final biternessController = TextEditingController();
  final bodyController = TextEditingController();
  final descController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();

    acidityController.dispose();
    balanceController.dispose();
    biternessController.dispose();
    bodyController.dispose();
    descController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.product == null) {
      //New Record
      nameController.text = "";
      countryController.text = "";
      cityController.text = "";

      acidityController.text = "";
      balanceController.text = "";
      biternessController.text = "";
      bodyController.text = "";
      descController.text = "";
      imageController.text = "";

      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(Coffee());
      });
    } else {
      //Controller Update
      print("############ui update:" + widget.product.coffeeId.toString());
      nameController.text = widget.product.name;
      countryController.text = widget.product.country;
      cityController.text = widget.product.city;

      acidityController.text = widget.product.acidity.toString();
      balanceController.text = widget.product.balance.toString();
      biternessController.text = widget.product.bitterness.toString();
      bodyController.text = widget.product.body.toString();
      descController.text = widget.product.desc;
      imageController.text = widget.product.image;

      //State Update
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(widget.product);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Coffee Name'),
              onChanged: (value) {
                productProvider.changeName(value);
              },
            ),
            TextField(
              controller: countryController,
              decoration: InputDecoration(hintText: 'Country'),
              onChanged: (value) => productProvider.changeCountry(value),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(hintText: 'City'),
              onChanged: (value) => productProvider.changeCity(value),
            ),
            TextField(
              controller: acidityController,
              decoration: InputDecoration(hintText: 'Acidity'),
              onChanged: (value) => productProvider.changeAcidity(value),
            ),
            TextField(
              controller: balanceController,
              decoration: InputDecoration(hintText: 'Balance'),
              onChanged: (value) => productProvider.changeBalance(value),
            ),
            TextField(
              controller: biternessController,
              decoration: InputDecoration(hintText: 'Bitterness'),
              onChanged: (value) => productProvider.changeBitterness(value),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(hintText: 'Body'),
              onChanged: (value) => productProvider.changeBody(value),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(hintText: 'Description'),
              onChanged: (value) => productProvider.changeDesc(value),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(hintText: 'Image Path'),
              onChanged: (value) => productProvider.changeImage(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                productProvider.saveProduct();
                Navigator.of(context).pop();
              },
            ),
            (widget.product != null)
                ? RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Delete'),
                    onPressed: () {
                      productProvider.removeProduct(widget.product.coffeeId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
