import 'package:dynamic_colors/dynamic_colors_builder.dart';
import 'package:dynamic_colors/harmonization.dart';
import 'package:dynamic_colors/tonal_palette.dart';
import 'package:flutter/material.dart';

bool _isDemoUsingDynamicColors = false;

class CompleteExample extends StatelessWidget {
  const CompleteExample({Key? key}) : super(key: key);

  static const title = 'DynamicColorsBuilder + ColorScheme';

  @override
  Widget build(BuildContext context) {
    return DynamicColorsBuilder(
      builder: (TonalPalette? dynamicColors) {
        // One can create ColorSchemes from scratch, but we'll start from the default schemes.
        ColorScheme colorScheme = const ColorScheme.light();
        ColorScheme darkColorScheme = const ColorScheme.dark();

        if (dynamicColors != null) {
          // On Android S+ devices, use the 600 and 200 shades of the dynamic
          // primary tonal range for the light and dark schemes, respectively.
          colorScheme = colorScheme.copyWith(
            primary: dynamicColors.primary.shade600,
          );
          darkColorScheme = darkColorScheme.copyWith(
            primary: dynamicColors.primary.shade200,
          );

          // Harmonize the dynamic color schemes' semantic colors.
          colorScheme = colorScheme.harmonized();
          darkColorScheme = darkColorScheme.harmonized();

          _isDemoUsingDynamicColors = true; // ignore, only for demo purposes
        } else {
          // On other platforms, default to 600 and 200 shades of amber for the
          // light and dark schemes, respectively. By design, we use colors
          // with the same tonal values.
          colorScheme = colorScheme.copyWith(
            primary: Colors.amber.shade600,
          );
          darkColorScheme = colorScheme.copyWith(
            primary: Colors.amber.shade200,
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
        _isDemoUsingDynamicColors ? ' is dynamic and using' : '';

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The background color$dynamicMsg ColorScheme.primary'),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                errorText: 'The text color$dynamicMsg ColorScheme.error',
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
