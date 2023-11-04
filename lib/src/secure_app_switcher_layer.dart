import 'dart:io';

import 'package:flutter/material.dart';
import 'package:secure_app_switcher/secure_app_switcher.dart';

class SecureAppSwitcherLayer extends StatefulWidget {
  /// A flag that controls Android screenshot behavior.
  ///
  /// When set to `true`, Android's `FLAG_SECURE` flag is cleared when the app is in the [AppLifecycleState.resumed] state, allowing for screenshots. The flag is set back to prevent screenshots at other times.
  final bool allowAndroidScreenshot;

  /// {@macro SecureMaskStyle}
  final SecureMaskStyle style;
  final Widget child;

  /// Hides the app screen when user enters the app switcher.
  ///
  /// This widget is designed to be used as the root widget when you want to hide all screens of the app. It provides an option to allow screenshots on Android.
  ///
  /// In case you want to hide specific screens, use [SecureAppSwitcherPage] instead.
  ///
  /// [allowAndroidScreenshot] determines whether Android screenshots are allowed.
  /// [style] sets the mask style for iOS. It defaults to [SecureMaskStyle.light].
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
