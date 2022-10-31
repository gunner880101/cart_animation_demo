import 'package:cart_animation_demo/components/product_list_item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey fabKey = GlobalKey();
  final itemCount = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: itemCount,
            itemBuilder: ((context, index) => ProductListItem(index: index)),
          ),
          const ProductListItem(index: 0),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        key: fabKey,
        onPressed: (() => debugPrint('123')),
        child: const Icon(Icons.shopping_basket),
      ),
    );
  }
}
