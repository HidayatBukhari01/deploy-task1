import 'package:cached_network_image/cached_network_image.dart';
import 'package:diploy_task/widgets/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final dynamic product;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
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
                  color: Colors.grey, backgroundBlendMode: BlendMode.saturation),
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
                    style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text('\u{20B9} ${product["price"].toString()}',
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
