import 'package:cached_network_image/cached_network_image.dart';
import 'package:diploy_task/screens/tab.screens/carttab.screen/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:diploy_task/utils/utils.dart';
import 'package:diploy_task/widgets/skeleton/skeleton.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDescription extends HookWidget {
  const ProductDescription({super.key, required this.product});
  final dynamic product;

  @override
  Widget build(BuildContext context) {
    final dimension = Utils.getDimensions(context, true);
    final useViewModel = useMemoized(() => Provider.of<CartViewModel>(context, listen: false));
    int totalCount = 0;
    useEffect(() {
      totalCount = useViewModel.getCount(product["id"]);
    }, []);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: product["image"],
                    fit: BoxFit.cover,
                    width: dimension["width"],
                    placeholder: (context, url) => Skeleton(
                      height: dimension["height"]! * 0.4,
                      width: dimension["width"]!,
                    ),
                    errorWidget: (context, url, error) => Skeleton(
                      height: dimension["height"]! * 0.4,
                      width: dimension["width"]!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      product["name"],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Price \u{20B9}${product["price"].toString()}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      product["description"],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer<CartViewModel>(builder: (context, provider, child) {
            return !provider.checkIfAdded(product["id"])
                ? GestureDetector(
                    onTap: () {
                      totalCount = 1;
                      provider.addToCart(product, 1);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: dimension["width"]!,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.blue,
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Total",
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "\u{20B9}${(product["price"] * totalCount).toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.blue, borderRadius: BorderRadius.circular(7)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  totalCount--;
                                  provider.removeFromCart(product);
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                    VerticalDivider(
                                      color: Colors.white,
                                      thickness: 1.5,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                totalCount.toString(),
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  totalCount++;
                                  provider.addToCart(product, 1);
                                },
                                child: const Row(
                                  children: [
                                    VerticalDivider(
                                      color: Colors.white,
                                      thickness: 1.5,
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
