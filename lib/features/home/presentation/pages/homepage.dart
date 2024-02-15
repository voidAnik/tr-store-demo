import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const path = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true; // Initially, data is loading

  @override
  void initState() {
    super.initState();
    // Simulate a network request or data loading delay
    Future.delayed(const Duration(seconds: 2), () {
      // After the delay, set loading to false
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _isLoading ? _loadingBar(context) : _products(context),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        centerTitle: false,
        title: const Text('Discover'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ActionChip(
              label: const Text('\$ Total Money'),
              avatar: const Icon(Icons.shopping_bag),
              onPressed: () {
                // Placeholder for action
              },
            ),
          ),
        ],
      );

  Center _loadingBar(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _products(BuildContext context) => GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 10, // Placeholder for dynamic item count
        itemBuilder: (context, index) => Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.shopping_bag),
              Text('Item $index'),
            ],
          ),
        ),
      );
}
