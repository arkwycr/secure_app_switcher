# secure_app_switcher

Apply a safe masking effect to the app screen on the app switcher or task list.

Functions can be enabled/disabled within any process. It also provides a mechanism for switching functions on a screen-by-screen basis.

The effect is different for iOS and Android.

## Usage

### Use functions within arbitrary processing

```dart
import 'package:secure_app_switcher/secure_app_switcher.dart';

// ON
SecureAppSwitcher.on();

// OFF
SecureAppSwitcher.off();
```

### Use functions on specific screens

It is necessary to set `secureAppSwitcherRouteObserver` to switch the function at the time of screen transition.

Wrap the target screen widget with `MaterialPageRoute` and `SecureAppSwitcherPage`.

- secureAppSwitcherRouteObserver

```dart
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure App Switcher',
      onGenerateRoute: generateRoute,
      navigatorObservers: [secureAppSwitcherRouteObserver], // add
      initialRoute: '/',
    );
  }
```

- SecureAppSwitcherPage, MaterialPageRoute

```dart
// Example: Case where the function is enabled on screen A

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      });    
    case "/screenA":
      return MaterialPageRoute(builder: (context) {
        return const SecureAppSwitcherPage( // add
          style: SecureMaskStyle.dark,
          child: ScreenA(),
        );
      });
  }
}
```

## iOS

For iOS, you can specify the type of mask effect.

```dart
SecureAppSwitcher.on(iosStyle: SecureMaskStyle.blurLight);
```

- Types of mask effects

| Light | Dark | BlurLight | BlurDark |
| :---: | :---: | :---: | :---: |
| <img width="250" src="https://user-images.githubusercontent.com/113876527/192409757-3289a563-b0df-43a5-9993-bea528019da6.png" />  | <img width="250" src="https://user-images.githubusercontent.com/113876527/192409756-0484c91c-e8c2-4289-89ef-a23522a26a5d.png" />  | <img width="250" src="https://user-images.githubusercontent.com/113876527/192409751-335f586e-89d7-4e13-8099-b15903065227.png" />  | <img width="250" src="https://user-images.githubusercontent.com/113876527/192409701-57af88e0-35eb-4e25-ae38-f96fe6d0a664.png" />  |

## Android

`FLAG_SECURE` of WindowManager LayoutParams is used.

> [WindowManager.LayoutParams | Android Developers](http://developer.android.com/reference/android/view/WindowManager.LayoutParams.html#FLAG_SECURE)

| switching apps | screenshot disabled |
| :---: | :---: |
| <img width="250" src="https://user-images.githubusercontent.com/113876527/192409761-960d19ea-0b41-40eb-bbab-bd2a3c4cd2f9.png" /> | <img width="250" src="https://user-images.githubusercontent.com/113876527/192409760-5ae06e9a-7d47-4352-9b59-f0efa81a5064.png"/> |

- The type of mask effect cannot be specified like iOS.
- In Android 11 or later, the mask effect is reflected by switching other apps once according to the specifications of Android OS.
- Taking screenshots is not allowed when the feature is enabled.

## Features and bugs

Please file feature requests and bugs on the [issue tracker](https://github.com/arkwycr/secure_app_switcher/issues).
