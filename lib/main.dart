import 'package:cart_animation_demo/components/product_list_item.dart';
import 'package:cart_animation_demo/providers/widget_key_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WidgetKeyProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
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
    Provider.of<WidgetKeyProvider>(context, listen: false).setFabKey(fabKey);
    return Scaffold(
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: ((context, index) => ProductListItem(
              index: index,
              fabKey: fabKey,
            )),
      ),
      floatingActionButton: FloatingActionButton.large(
        key: fabKey,
        onPressed: () {},
        child: const Icon(Icons.shopping_basket),
      ),
    );
  }
}
