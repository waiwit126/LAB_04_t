import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {},
            child: const Text("Click", style: textStyle),
          ),
          const SizedBox(height: 10),
          FilledButton(
            onPressed: () {},
            child: const Text("Click", style: textStyle),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {},
            child: const Text("Click", style: textStyle),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Click", style: textStyle),
          ),
        ],
      ),
    );
  }
}