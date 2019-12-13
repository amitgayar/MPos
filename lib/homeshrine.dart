

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'shopping_cart.dart';
import 'backdrop.dart';
//import 'expanding_bottom_sheet.dart';
import 'model/app_state_model.dart';
import 'model/product.dart';
import 'supplemental/asymmetric_view.dart';

//import 'package:intl/intl.dart';


class ProductPage extends StatelessWidget {
  final Category category;

  const ProductPage({this.category = Category.all});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) {
          return AsymmetricView(
              products: model.getProducts()

          );
        });
  }
}



class Tiles extends StatefulWidget {
  @override
  MyTiles createState() => MyTiles();
}

class MyTiles extends State<Tiles> {
  List<Widget> _createShoppingCartRows(AppStateModel model) {
    return model.productsInCart.keys
        .map(
          (id) => ShoppingCartRow(
        product: model.getProductById(id),
        quantity: model.productsInCart[id],
        onPressed: () {
          model.removeItemFromCart(id);
        },
      ),
    )
        .toList();
  }
  String total(AppStateModel model) {
    return model.totalCost.toString();
  }
  final TextEditingController _searchController = TextEditingController();


  Widget section1 = SizedBox(
    child: Row(
      children: [
        const Card(
          color: Colors.green,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Cart!'),
          ),
        ),
        const SizedBox(width: 45,),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No Item!'),
          ),
        ),
        const SizedBox(width: 45,),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No Item'),
          ),
        )
      ],
    ),

  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: <Widget>[
             section1,

            const Divider(
              color: Colors.brown, height: 10, thickness: 5
            ),









            Row(
              children: <Widget>[
                Text('Quick Links     '),
                new Container(
                  width: 200,
                  height: 30,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),

                    ),
                  ),
                ),
                SizedBox(height: 30, width: 40,),
                IconButton(icon: Icon(Icons.keyboard_arrow_up), onPressed:null),
              ],
            ),
            const SizedBox(
              height: 150,
              child:    ProductPage(),
            ),
            const Divider(
                color: Colors.brown, height: 20, thickness: 5
            ),






            SizedBox(
              height: 30,
              child: Text(
                'Product :             MRP             SP             QTY             Total',
                textAlign: TextAlign.left,
              ),
            ),
            const Divider(
                color: Colors.brown, height: 10, thickness: 5
            ),





            Container(
              child: SizedBox(
                height: 300,
                child: ScopedModelDescendant<AppStateModel>(
                  builder: (context, child, model) {
                    return ListView (
                      children: _createShoppingCartRows(model),
                    );
                  },
                ),
              ),
            ),
            const Divider(
                color: Colors.brown, height: 10, thickness: 5
            ),





            Container(
              height: 60,
              width: 500,
              child: ScopedModelDescendant<AppStateModel>(
                        builder: (context, child, model) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.delete),onPressed: null,),
                            SizedBox(width: 100,),
                            new Card(
                              color: Colors.lightGreenAccent,
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(total(model)),
                              ),
                            ),

                            SizedBox(width: 100,),
                            IconButton(icon: Icon(Icons.person_add),onPressed: null,),
                          ],
                        );
               })

            ),


          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
//  final ExpandingBottomSheet expandingBottomSheet;
  final Backdrop backdrop;

//  const HomePage({Key key, this.expandingBottomSheet, this.backdrop})
  const HomePage({Key key, this.backdrop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        backdrop,
        Align(child: Text(''), alignment: Alignment.topRight)

      ],
    );
  }
}
