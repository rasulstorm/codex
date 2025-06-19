import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}
class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> _futureProducts;
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductService.fetchProducts();
  }
  List<Product> _applyFilter(List<Product> products) {
    switch (_filter) {
      case 'below100':
        return products.where((p) => p.price < 100).toList();
      case '100to500':
        return products.where((p) => p.price >= 100 && p.price <= 500).toList();
      case 'above500':
        return products.where((p) => p.price > 500).toList();
      default:
        return products;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Dashboard')),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          }
          final products = _applyFilter(snapshot.data ?? []);
          return ListView(
            children: products
                .map((p) => ListTile(
                      title: Text(p.title),
                      subtitle: Text('\$' + p.price.toString()),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProductDetailPage(product: p)),
                      ),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
