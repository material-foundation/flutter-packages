import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const demoWidthConstraints = BoxConstraints(maxWidth: 400);
bool _isDemoUsingDynamicColors = false;

class CompleteExample extends StatelessWidget {
  const CompleteExample({Key? key}) : super(key: key);

  static const title = 'DynamicColorBuilder + ColorScheme';

  @override
  Widget build(BuildContext context) {
    // First let's wrap our MaterialApp with a DynamicColorBuilder.
    return DynamicColorBuilder(
      builder: (ColorScheme? light, ColorScheme? dark) {
        // One can create ColorSchemes from scratch, but we'll start from the
        // default schemes.
        ColorScheme colorScheme = const ColorScheme.light();
        ColorScheme darkColorScheme = const ColorScheme.dark();

        if (light != null && dark != null) {
          // On Android S+ devices, use the dynamic primary color.
          colorScheme = colorScheme.copyWith(
            primary: light.primary,
          );
          darkColorScheme = darkColorScheme.copyWith(
            primary: dark.primary,
          );

          // Harmonize the dynamic color schemes' error and onError colors
          // (which are built-in semantic colors).
          colorScheme = colorScheme.harmonized();
          darkColorScheme = darkColorScheme.harmonized();

          _isDemoUsingDynamicColors = true; // ignore, only for demo purposes
        } else {
          // Otherwise, use a fallback scheme and customize as needed.
          colorScheme = colorScheme.copyWith(
            primary: Colors.orange.shade600,
          );
          darkColorScheme = colorScheme.copyWith(
            primary: Colors.orange.shade200,
          );
        }

        return MaterialApp(
          theme: ThemeData(
            colorScheme: colorScheme,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
          ),
          home: const Home(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dynamicMsg =
        _isDemoUsingDynamicColors ? ' (dynamic)' : ' (not dynamic)';

    return Scaffold(
      body: Center(
        child: Container(
          constraints: demoWidthConstraints,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              Text(
                'The square\'s color is colorScheme.primary$dynamicMsg',
              ),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  errorText: 'The text color is colorScheme.error$dynamicMsg',
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
