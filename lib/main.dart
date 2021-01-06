import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        builder: (context) => ProductBloc(),
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    ProductBloc bloc = BlocProvider.of<ProductBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo ListView Builder"),
      ),
      body: Column(
        children: [
          RaisedButton(
            child: Text("Gen Data"),
            onPressed: () {
              bloc.dispatch(random.nextInt(10));
            },
          ),
          BlocBuilder<ProductBloc, List<Product>>(
            builder: (context, state) => Expanded(
              child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) => Text(state[index].name + "  "+ state[index].price.toString()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  String imageUrl;
  String name;
  int price;

  Product({this.imageUrl = "", this.name = "", this.price = 0});
}

class ProductBloc extends Bloc<int, List<Product>> {
  @override
  List<Product> get initialState => [];

  @override
  Stream<List<Product>> mapEventToState(int event) async* {
    List<Product> products = [];
    for (int i = 0; i < event; i++) {
      products.add(Product(
          imageUrl:
              "https://avatars3.githubusercontent.com/u/45892408?s=460&u=94158c6479290600dcc39bc0a52c74e4971320fc&v=4",
          name: "Product " + i.toString(),
          price: (i + 1) * 5000));
    }
    yield products;
  }
}
