import 'dart:io';

import 'package:flutter/material.dart';
import 'package:secure_app_switcher/secure_app_switcher.dart';

class SecureAppSwitcherLayer extends StatefulWidget {
  final bool allowAndroidScreenshot;
  final SecureMaskStyle style;
  final Widget child;

  const SecureAppSwitcherLayer({
    super.key,
    this.allowAndroidScreenshot = false,
    this.style = SecureMaskStyle.light,
    required this.child,
  });

  @override
  State<SecureAppSwitcherLayer> createState() => _SecureAppSwitcherLayerState();
}

class _SecureAppSwitcherLayerState extends State<SecureAppSwitcherLayer>
    with WidgetsBindingObserver {
  bool get isAndroidWithScreenshotAllowed =>
      Platform.isAndroid && widget.allowAndroidScreenshot;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (!isAndroidWithScreenshotAllowed) {
      SecureAppSwitcher.on(iosStyle: widget.style);
    } else {
      SecureAppSwitcher.off();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!isAndroidWithScreenshotAllowed) return;

    if (state == AppLifecycleState.resumed) {
      SecureAppSwitcher.off();
    } else {
      SecureAppSwitcher.on(iosStyle: widget.style);
    }
  }

  @override
  void dispose() {
    SecureAppSwitcher.off();

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
