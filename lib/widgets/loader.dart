import 'package:flutter/material.dart';

class Loader {
  static OverlayEntry? currentEntry;
  static OverlayEntry showLoading(BuildContext context) {
    currentEntry?.remove();
    final entry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black38,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
    currentEntry = entry;
    Overlay.of(context)?.insert(entry);
    return entry;
  }

  static void hideLoading() {
    currentEntry?.remove();
    currentEntry = null;
  }
}
