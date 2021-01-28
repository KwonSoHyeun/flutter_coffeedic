//import 'package:coffeedic/screens/login/coffee_create.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeedic/models/coffee.dart';
import 'package:coffeedic/screens/firestore/coffeebase_edit.dart';

//CoffeebaseList
class CoffeebaseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Coffee>>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Coffee 목록'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProduct()));
              },
            )
          ],
        ),
        body: (products != null)
            ? ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(products[index].name +
                        ":" +
                        products[index].coffeeId.toString()),
                    trailing: Text(products[index].country.toString()),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProduct(products[index])));
                    },
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}
