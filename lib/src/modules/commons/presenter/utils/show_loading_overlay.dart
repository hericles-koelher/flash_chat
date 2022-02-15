import 'package:flutter/material.dart';

/// Create and insert a loading overlay that covers
/// the screen.
OverlayEntry showLoadingOverlay(BuildContext context) {
  var overlayState = Overlay.of(context);

  var overlayEntry = OverlayEntry(
    builder: (_) => Stack(
      children: [
        Container(
          color: Colors.grey[400]!.withOpacity(0.3),
        ),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    ),
  );

  overlayState!.insert(overlayEntry);

  return overlayEntry;
}
