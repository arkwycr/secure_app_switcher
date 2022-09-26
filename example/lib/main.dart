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
    case "/a":
      return MaterialPageRoute(builder: (context) {
        return const SecureAppSwitcherPage(
          style: SecureMaskStyle.blurLight,
          child: ScreenA(),
        );
      });
    case "/b":
      return MaterialPageRoute(builder: (context) {
        return const ScreenB();
      });
    case "/c":
      return MaterialPageRoute(builder: (context) {
        return const SecureAppSwitcherPage(
          style: SecureMaskStyle.blurDark,
          child: ScreenC(),
        );
      });
    case "/d":
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Switching', style: Theme.of(context).textTheme.headlineSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => SecureAppSwitcher.on(),
                child: const Text('ON'),
              ),
              TextButton(
                onPressed: () => SecureAppSwitcher.off(),
                child: const Text('OFF'),
              ),
            ],
          ),
          const Divider(),
          Text('Set per screen',
              style: Theme.of(context).textTheme.headlineSmall),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed("/a"),
            child: const Text('Screen A'),
          )
        ],
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: const [
              Text('SecureAppSwitcher : on'),
              Text('SecureMaskStyle : blurLight (only iOS)'),
            ],
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed("/b"),
            child: const Text('Screen B'),
          )
        ],
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: const [
              Text('SecureAppSwitcher : off'),
            ],
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed("/c"),
            child: const Text('Screen C'),
          )
        ],
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: const [
              Text('SecureAppSwitcher : on'),
              Text('SecureMaskStyle : blurDark (only iOS)'),
            ],
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Navigator(
                  onGenerateRoute: (context) =>
                      generateRoute(const RouteSettings(name: '/d')),
                ),
              );
            },
            child: const Text('Screen D'),
          )
        ],
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
          children: const [
            Text('SecureAppSwitcher : on'),
            Text('SecureMaskStyle : dark (only iOS)'),
          ],
        ),
      ),
    );
  }
}
