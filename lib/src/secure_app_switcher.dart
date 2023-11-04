import 'package:flutter/services.dart';

/// {@template SecureMaskStyle}
/// Select a screen mask style.
///
/// Applies to iOS only
/// {@endtemplate}
enum SecureMaskStyle {
  /// UIColor.white is applied.
  light,

  /// UIColor.black is applied.
  dark,

  /// UIBlurEffect(style: .light) is applied.
  blurLight,

  /// UIBlurEffect(style: .dark) is applied.
  blurDark,
}

/// Class for working with screen masks on switcher.
///
/// The class does not need to be instantiated directly
class SecureAppSwitcher {
  static const _methodChannel = MethodChannel('secure_app_switcher');

  /// Enable screen mask.
  /// For iOS, a mask style can be specified. Default is [SecureMaskStyle.light].
  static void on({SecureMaskStyle iosStyle = SecureMaskStyle.light}) {
    _methodChannel.invokeMethod('on', {
      'style': iosStyle.index,
    });
  }

  /// Disable screen mask.
  static void off() {
    _methodChannel.invokeMethod('off');
  }
}
