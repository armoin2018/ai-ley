// utils/performance_helpers.dart
import 'package:flutter/material.dart';

class PerformanceOptimizedList extends StatelessWidget {
  final List<dynamic> items;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool shrinkWrap;

  const PerformanceOptimizedList({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: shrinkWrap,
      physics: const AlwaysScrollableScrollPhysics(),
      cacheExtent: 200.0, // Cache items for smooth scrolling
      itemBuilder: itemBuilder,
    );
  }
}

// Memoization for expensive calculations
class MemoizedWidget extends StatelessWidget {
  final String data;

  const MemoizedWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildExpensiveWidget();
  }

  Widget _buildExpensiveWidget() {
    // Use compute() for heavy operations
    return FutureBuilder<String>(
      future: _processDataInBackground(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!);
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future<String> _processDataInBackground() async {
    return await compute(_expensiveFunction, data);
  }

  static String _expensiveFunction(String data) {
    // Heavy computation here
    return data.toUpperCase();
  }
}