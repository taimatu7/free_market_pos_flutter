import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../sale/payment/view/payment_screen.dart';
import '../view_model/cart_model.dart';
import '../view_model/cart_view_model.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {
  bool _isInCart = true;
  @override
  Widget build(BuildContext context) {
    ref.listen<CartModel>(cartViewModelProvider, (previous, next) {
      if (next.products.isNotEmpty) {
        setState(() {
          _isInCart = true;
        });
      } else {
        setState(() {
          _isInCart = false;
        });
      }
    });
    final model = ref.read(cartViewModelProvider);

    return GestureDetector(
      child: _isInCart
          ? badges.Badge(
              badgeContent: Text(
                model.products.length.toString(),
                style: const TextStyle(fontSize: 15),
              ),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.yellow,
              ),
              child: const Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
              ),
            )
          : const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
      onTap: () => setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const PaymentScreen();
        }));
      }),
    );
  }
}
