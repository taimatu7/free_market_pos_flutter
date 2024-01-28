import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_market_pos_flutter/presentation/sale/payment/view/payment_screen.dart';

class Cart extends ConsumerStatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Cart({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {
  final bool _isInCart = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _isInCart
          ? const badges.Badge(
              badgeContent: Text("2", style: TextStyle(fontSize: 10)),
              child: Icon(
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
