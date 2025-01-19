import 'package:flutter/material.dart';
import 'package:secure_app_switcher/secure_app_switcher.dart';

/// RouteObserver for screen widgets.
///
/// It is used to detect transition events of screen widgets.
final RouteObserver secureAppSwitcherRouteObserver = RouteObserver();

/// Screen mask function class for screen widgets.
///
/// [secureAppSwitcherRouteObserver] must be set to navigatorObservers.
///
/// It has MaterialPageRoute as its parent and wraps the screen widget with [SecureAppSwitcherPage].
/// For iOS, a mask style can be specified.
///
/// ```dart
/// MaterialPageRoute(builder: (context) {
///   return const SecureAppSwitcherPage(
///     style: SecureMaskStyle.blurLight,
///     child: ScreenA(),
///   );
/// )
/// ```
class SecureAppSwitcherPage extends StatefulWidget {
  const SecureAppSwitcherPage({
    super.key,
    required this.child,
    this.style = SecureMaskStyle.light,
  });

  final Widget child;

  /// {@macro SecureMaskStyle}
  final SecureMaskStyle style;

  @override
  SecureAppSwitcherPageState createState() {
    return SecureAppSwitcherPageState();
  }
}

class SecureAppSwitcherPageState extends State<SecureAppSwitcherPage>
    with RouteAware {
  SecureAppSwitcherPageState();

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    secureAppSwitcherRouteObserver.subscribe(
        this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    secureAppSwitcherRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    SecureAppSwitcher.on(iosStyle: widget.style);
    super.didPush();
  }

  @override
  void didPop() {
    SecureAppSwitcher.off();
    super.didPop();
  }

  @override
  void didPopNext() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      SecureAppSwitcher.on(iosStyle: widget.style);
    });
    super.didPopNext();
  }

  @override
  void didPushNext() {
    SecureAppSwitcher.off();
    super.didPushNext();
  }
}
