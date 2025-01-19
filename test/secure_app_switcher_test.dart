import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:secure_app_switcher/secure_app_switcher.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('secure_app_switcher');
  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      log.add(methodCall);
      return null; // Adjust based on the expected mock response if needed
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    log.clear();
  });

  test('on', () async {
    SecureAppSwitcher.on();
    SecureAppSwitcher.on(iosStyle: SecureMaskStyle.light);
    SecureAppSwitcher.on(iosStyle: SecureMaskStyle.dark);
    SecureAppSwitcher.on(iosStyle: SecureMaskStyle.blurLight);
    SecureAppSwitcher.on(iosStyle: SecureMaskStyle.blurDark);

    expect(
      log,
      <Matcher>[
        isMethodCall(
          'on',
          arguments: <String, int>{
            'style': 0,
          },
        ),
        isMethodCall(
          'on',
          arguments: <String, int>{
            'style': 0,
          },
        ),
        isMethodCall(
          'on',
          arguments: <String, int>{
            'style': 1,
          },
        ),
        isMethodCall(
          'on',
          arguments: <String, int>{
            'style': 2,
          },
        ),
        isMethodCall(
          'on',
          arguments: <String, int>{
            'style': 3,
          },
        )
      ],
    );
  });

  test('off', () async {
    SecureAppSwitcher.off();

    expect(
      log,
      <Matcher>[isMethodCall('off', arguments: null)],
    );
  });
}
