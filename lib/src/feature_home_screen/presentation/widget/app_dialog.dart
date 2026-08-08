import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  static Future<T?> show<T>({
    required Widget child,
    String? title,
    bool barrierDismissible = true,
  }) {
    return Get.dialog<T>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
          maxHeight: 500,
          minHeight: 50,
          minWidth: 50
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Text(title),
              const SizedBox(height: 16),
            ],
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}