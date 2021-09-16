import 'package:flutter/material.dart';

import '../product_detail/product_detail_screen.dart';

class ProductItem extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ProductItem(this.id, this.title, this.imageUrl);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool favPressed = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName,
                  arguments: widget.id,
                );
              },
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            footer: SizedBox(
              height: constraints.maxHeight * .3,
              child: GridTileBar(
                backgroundColor: Colors.black54,
                leading: IconBtnBuilder(
                  context,
                  iconData: favPressed ? Icons.favorite : Icons.favorite_border,
                  onTapHandler: () {
                    setState(() {
                      favPressed = !favPressed;
                    });
                  },
                ),
                title: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: IconBtnBuilder(
                  context,
                  iconData: Icons.shopping_cart,
                  onTapHandler: () {},
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class IconBtnBuilder extends StatelessWidget {
  final IconData iconData;
  final Function() onTapHandler;
  final BuildContext buildContext;

  const IconBtnBuilder(
    this.buildContext, {
    required this.iconData,
    required this.onTapHandler,
  });

  @override
  Widget build(BuildContext context) {
    context = buildContext;
    return IconButton(
      constraints: BoxConstraints.tight(const Size(20, 20)),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      iconSize: 15,
      icon: Icon(iconData),
      onPressed: onTapHandler,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
