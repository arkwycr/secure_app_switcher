import 'package:flutter/material.dart';
import 'package:secure_app_switcher/secure_app_switcher.dart';

class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure app',
      onGenerateRoute: _generateRoute,
      navigatorObservers: [secureAppSwitcherRouteObserver],
      home: const SecureItemList(),
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) {
          return const SecureItemList();
        });
      case "/new":
        return MaterialPageRoute(builder: (context) {
          return const NewSecureItem();
        });
      case "/new2":
        return MaterialPageRoute(builder: (context) {
          return const SecureAppSwitcherPage(
            style: SecureMaskStyle.blurLight,
            child: NewSecureItem2(),
          );
        });
      case "/new3":
        return MaterialPageRoute(builder: (context) {
          return const SecureAppSwitcherPage(
            style: SecureMaskStyle.blurDark,
            child: NewSecureItem3(),
          );
        });
      default:
        // Some widget here
        return MaterialPageRoute(builder: (context) {
          return const SecureItemList();
        });
    }
  }
}

class SecureItemList extends StatelessWidget {
  const SecureItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Secure Application"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/new"),
              child: const Text("New Secure Item"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/new2"),
              child: const Text("New Secure Item2"),
            ),
          ],
        ),
      ),
    );
  }
}

class NewSecureItem extends StatelessWidget {
  const NewSecureItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Item"),
      ),
      body: const Center(
        child: Text('New Secure Item'),
      ),
    );
  }
}

class NewSecureItem2 extends StatelessWidget {
  const NewSecureItem2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Item2"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('New Secure Item2'),
            ElevatedButton(
              // This will not work for now (try when we add onGenerateRoute)
              onPressed: () => Navigator.of(context).pushNamed("/new3"),
              child: const Text("New Secure Item3"),
            ),
          ],
        ),
      ),
    );
  }
}

class NewSecureItem3 extends StatelessWidget {
  const NewSecureItem3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Item3"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('New Secure Item3'),
            ElevatedButton(
              // This will not work for now (try when we add onGenerateRoute)
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Navigator(
                    onGenerateRoute: (context) => MaterialPageRoute(
                      builder: (context) {
                        return SecureAppSwitcherPage(
                          style: SecureMaskStyle.dark,
                          child: SizedBox(
                            height: 300,
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Close'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: const Text("New Secure Item3"),
            ),
          ],
        ),
      ),
    );
  }
}
