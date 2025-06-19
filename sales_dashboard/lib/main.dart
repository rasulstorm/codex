import 'package:flutter/material.dart';
import 'pages/product_list_page.dart';

void main() {
  runApp(const SalesDashboardApp());
}

class SalesDashboardApp extends StatelessWidget {
  const SalesDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProductListPage(),
    );
  }
}
