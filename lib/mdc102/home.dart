import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('HomePage');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
        title: Text('SHRINE'),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: _buildGridCards(context)
//          children: _buildGridCards(10)
//        <Widget>[
//          Card(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                AspectRatio(
//                  aspectRatio: 18.0 / 11.0,
//                  child: Image.asset('assets/diamond.png'),
//                ),
//                Padding(
//                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text('Title'),
//                      SizedBox(height: 8.0),
//                      Text('Secondary Text'),
//                    ],
//                  ),
//                )
//              ],
//            ),
//          ),
//        ],
          ),
    );
  }

  List<Card> _buildGridCards(BuildContext context) {
//    List<Product> loadProducts = ProductsRepository.loadProducts(Category.all);
    var products = ProductsRepository.loadProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[]; //???
    }

    final ThemeData theme = Theme.of(context);

    var numberFormat = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 19 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: theme.textTheme.title,
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      numberFormat.format(product.price),
                      style: theme.textTheme.body2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();

//    List<Card> cards = List.generate(
//      count,
//      (int index) => Card(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                AspectRatio(
//                  aspectRatio: 18.0 / 11.0,
//                  child: Image.asset('assets/diamond.png'),
//                ),
//                Padding(
//                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text('Title'),
//                      SizedBox(height: 8.0),
//                      Text('Secondary Text'),
//                    ],
//                  ),
//                )
//              ],
//            ),
//          ),
//    );
//    return cards;
  }
}
