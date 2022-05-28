import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const AlertDialog(
        content: SizedBox(height: 50, child: Center(child: CircularProgressIndicator()),),    
      );
    }
  );
}
