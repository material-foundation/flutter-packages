import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

bool _isDemoUsingDynamicColors = false;

class CompleteExample extends StatelessWidget {
  const CompleteExample({Key? key}) : super(key: key);

  static const title = 'DynamicColorBuilder + ColorScheme';

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (CorePalette? corePalette) {
        // One can create ColorSchemes from scratch, but we'll start from the
        // default schemes.
        ColorScheme colorScheme = const ColorScheme.light();
        ColorScheme darkColorScheme = const ColorScheme.dark();

        if (corePalette != null) {
          // On Android S+ devices, use the 40 and 80 tones of the dynamic
          // primary tonal palette for the light and dark schemes, respectively.
          colorScheme = colorScheme.copyWith(
            primary: corePalette.primary.tone40,
          );
          darkColorScheme = darkColorScheme.copyWith(
            primary: corePalette.primary.tone80,
          );

          // Harmonize the dynamic color schemes' semantic colors.
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
      body: Column(
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
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                errorText: 'The text color is colorScheme.error$dynamicMsg',
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
