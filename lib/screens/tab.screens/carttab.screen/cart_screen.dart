import 'package:cached_network_image/cached_network_image.dart';
import 'package:diploy_task/screens/tab.screens/carttab.screen/cart_view_model.dart';
import 'package:diploy_task/utils/utils.dart';
import 'package:diploy_task/widgets/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartTabScreen extends HookWidget {
  const CartTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dimension = Utils.getDimensions(context, true);
    double cartTotal = 0;
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<CartViewModel>(builder: (context, provider, child) {
        cartTotal = provider.calculateTotal();
        return provider.cartItems.isEmpty
            ? const Center(
                child: Text("No Items Added!"),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: provider.cartItems.length,
                        itemBuilder: (context, index) {
                          dynamic product = provider.cartItems[index];
                          double itemTotal = product["count"] * product["price"];
                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        margin: const EdgeInsets.only(right: 10),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                        ),
                                        foregroundDecoration: const BoxDecoration(
                                            color: Colors.grey,
                                            backgroundBlendMode: BlendMode.saturation),
                                        child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              bottomLeft: Radius.circular(10.0),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: product["image"],
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Skeleton(
                                                height: 120,
                                                width: 120,
                                              ),
                                              errorWidget: (context, url, error) => Skeleton(
                                                height: 120,
                                                width: 120,
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Product name
                                            Text(
                                              product["name"],
                                              style: GoogleFonts.roboto(
                                                  fontSize: 15, fontWeight: FontWeight.w500),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('\u{20B9} ${product["price"].toString()}',
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700)),
                                                Container(
                                                  margin: const EdgeInsets.symmetric(
                                                      horizontal: 8, vertical: 16),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        alignment: Alignment.center,
                                                        height: 40,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius: BorderRadius.circular(7)),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                // if (count == 1) {
                                                                //   widget.cartProvider.removeFromCart(
                                                                //       widget.productId, widget.unit, widget.quantity);
                                                                // } else {
                                                                //   widget.cartProvider.decrementQuantity(
                                                                //       widget.productId, widget.unit, widget.quantity);
                                                                // }
                                                                // product["count"]--;
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
                                                              product["count"].toString(),
                                                              style: GoogleFonts.roboto(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 18),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                // totalCount++;
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
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Total Amount :",
                                          style: GoogleFonts.roboto(
                                              fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "\u{20B9}${itemTotal.toStringAsFixed(2)}",
                                          style: GoogleFonts.roboto(
                                              fontSize: 16, fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  provider.cartItems.isEmpty
                      ? const SizedBox.shrink()
                      : Container(
                          width: dimension["width"],
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          margin: const EdgeInsets.only(top: 8),
                          color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cart Total",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w800, color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                "\u{20B9}${cartTotal.toStringAsFixed(2)}",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w800, color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        )
                ],
              );
      }),
    );
  }
}
