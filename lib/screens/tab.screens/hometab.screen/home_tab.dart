import 'package:diploy_task/screens/tab.screens/hometab.screen/home_tab_view_model.dart';
import 'package:diploy_task/screens/tab.screens/hometab.screen/widgets/product_description.dart';
import 'package:diploy_task/utils/utils.dart';
import 'package:diploy_task/widgets/product.card/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class HomeTabScreen extends HookWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dimension = Utils.getDimensions(context, true);
    final useViewModel = useMemoized(() => Provider.of<HomeTabViewModel>(context, listen: false));
    useEffect(() {
      if (useViewModel.products.isEmpty) {
        useViewModel.loadProducts(context);
      }
    }, []);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Consumer<HomeTabViewModel>(builder: (context, provider, child) {
        return provider.productsLoader
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : provider.products.isEmpty
                ? const Center(
                    child: Text("No Products Found!"),
                  )
                : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        color: Colors.white,
                        height: dimension['height']! * 0.09,
                        width: dimension['width']!,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          controller: provider.searchController,
                          decoration: InputDecoration(
                            suffixIcon: provider.searchController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      provider.clearSearch(context);
                                    },
                                    child: const Icon(Icons.close),
                                  )
                                : null,
                            hintText: 'Search "Gaming Console"',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey.shade100),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          onChanged: (value) {
                            provider.filterProducts(value);
                          },
                        ),
                      ),
                      Expanded(
                        child: Consumer<HomeTabViewModel>(builder: (context, provider, child) {
                          return ListView.builder(
                            itemCount: provider.filteredProducts.isEmpty
                                ? provider.products.length
                                : provider.filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = provider.products[index];
                              return GestureDetector(
                                  onTap: () {
                                    // Utils.model(context, ProductDescription());
                                    Navigator.of(context, rootNavigator: true).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDescription(product: product)));
                                  },
                                  child: ProductCard(product: product));
                            },
                          );
                        }),
                      )
                    ],
                  );
      }),
    );
  }
}
