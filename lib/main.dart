import 'package:cart_animation_demo/add_to_cart_animation/toss_animation_painter.dart';
import 'package:cart_animation_demo/components/product_list_item.dart';
import 'package:cart_animation_demo/providers/widget_key_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WidgetKeyProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // is not restarted.
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  GlobalKey fabKey = GlobalKey();
  final itemCount = 10;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _startAnimation() {
    _animationController.stop();
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<WidgetKeyProvider>(context, listen: false).setFabKey(fabKey);
    return Scaffold(
      body: CustomPaint(
        foregroundPainter: TossAnimationPainter(
          animation: _animationController,
        ),
        child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: ((context, index) => ProductListItem(index: index)),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        key: fabKey,
        onPressed: _startAnimation,
        child: const Icon(Icons.shopping_basket),
      ),
    );
  }
}
