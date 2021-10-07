import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/product_provider.dart';
import 'package:test/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget popularProducts(BuildContext context) {
      return Consumer<ProductProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.hasData) {
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 20,
              staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var product = state.products;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCard(
                    product[index],
                  ),
                );
              },
              itemCount: state.products.length,
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('List Data'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/cart');
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_bag),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.grey.shade50,
            ),
          ],
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: const [
                Icon(Icons.list),
                Text('Category'),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.filter_list),
                Text('Filter'),
              ],
            )
          ],
        ),
      ),
      body: popularProducts(context),
    );
  }
}
