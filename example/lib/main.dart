import 'package:flutter/material.dart';
import 'package:secure_app_switcher/secure_app_switcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure App Switcher',
      onGenerateRoute: generateRoute,
      navigatorObservers: [secureAppSwitcherRouteObserver],
      initialRoute: '/',
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      });
    case "/screen_a":
      return MaterialPageRoute(builder: (context) {
        return const ScreenA();
      });
    case "/screen_b":
      return MaterialPageRoute(builder: (context) {
        return const SecureAppSwitcherPage(
          style: SecureMaskStyle.blurLight,
          child: ScreenB(),
        );
      });

    case "/screen_c":
      return MaterialPageRoute(builder: (context) {
        return const SecureAppSwitcherPage(
          style: SecureMaskStyle.blurDark,
          child: ScreenC(),
        );
      });
    case "/screen_d":
      return MaterialPageRoute(builder: (context) {
        return const SecureAppSwitcherPage(
          style: SecureMaskStyle.dark,
          child: ScreenD(),
        );
      });
    default:
      return MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      });
  }
}

/// -------------------------------------------------------------------------------

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _secureEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 10,
          children: [
            Text('Arbitrary Processing',
                style: Theme.of(context).textTheme.titleLarge),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('SecureAppSwitcher'),
                  Switch(
                    value: _secureEnable,
                    onChanged: (value) {
                      setState(() {
                        _secureEnable = value;
                        if (value) {
                          SecureAppSwitcher.on();
                        } else {
                          SecureAppSwitcher.off();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Text('Specific Screens',
                style: Theme.of(context).textTheme.titleLarge),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _secureEnable = false;
                      SecureAppSwitcher.off();
                    });
                    Navigator.of(context).pushNamed("/screen_a");
                  },
                  child: Column(
                    children: [
                      Text(
                        'Screen A',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Text('SecureAppSwitcher : off'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen A'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('SecureAppSwitcher : off',
                style: Theme.of(context).textTheme.bodyLarge),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/screen_b");
              },
              child: Column(
                children: [
                  Text(
                    'Screen B',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text('SecureAppSwitcher : on'),
                  const Text('SecureMaskStyle : blurLight (only iOS)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen B'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('SecureAppSwitcher : on',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('SecureMaskStyle : blurLight (only iOS)',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/screen_c");
              },
              child: Column(
                children: [
                  Text(
                    'Screen C',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text('SecureAppSwitcher : on'),
                  const Text('SecureMaskStyle : blurDark (only iOS)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen C'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('SecureAppSwitcher : on',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('SecureMaskStyle : blurDark (only iOS)',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Navigator(
                    onGenerateRoute: (context) =>
                        generateRoute(const RouteSettings(name: '/screen_d')),
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    'Modal Screen D',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text('SecureAppSwitcher : on'),
                  const Text('SecureMaskStyle : dark (only iOS)'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ScreenD extends StatelessWidget {
  const ScreenD({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen D'),
        leading: IconButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          icon: const Icon(Icons.close),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('SecureAppSwitcher : on',
                style: Theme.of(context).textTheme.bodyLarge),
            Text('SecureMaskStyle : dark (only iOS)',
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
