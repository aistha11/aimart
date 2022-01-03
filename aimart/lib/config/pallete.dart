import 'package:flutter/material.dart';

class Pallete {
  static const Color primaryCol = Colors.cyan;
  static const Color backgroundColor = Colors.white70;
  static  Color cyan100 = Colors.cyan.shade100;
  static  Color inputFillColor = Colors.grey.shade400;

  static Color getOrderColor(String orderState){
    switch (orderState) {
      case "Pending":
        return Colors.cyan;
      case "Processing":
        return Colors.yellow;
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Pallete.primaryCol;
    }
  }
  static IconData getOrderIcon(String orderState){
    switch (orderState) {
      case "Pending":
        return Icons.pending_outlined;
      case "Processing":
        return Icons.hourglass_top_outlined;
      case "Completed":
        return Icons.done;
      case "Cancelled":
        return Icons.cancel_outlined;
      default:
        return Icons.pending;
    }
  }
}
