import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'common.dart';

bool _isDemoUsingDynamicColors = false;

// Fictitious brand color.
const _brandBlue = Color(0xFF1E88E5);

const CustomColors lightCustomColors = CustomColors(danger: Color(0xFFE53935));
const CustomColors darkCustomColors = CustomColors(danger: Color(0xFFEF9A9A));

class CompleteExample extends StatelessWidget {
  const CompleteExample({super.key});

  static const title = 'Complete example';

  ColorScheme _processColorScheme(ColorScheme colorScheme) {
    // (Recommended) Harmonize the dynamic color scheme' built-in semantic colors.
    // (Optional) Customize the scheme as desired. For example, one might
    // want to use a brand color to override the dynamic [ColorScheme.secondary].
    return colorScheme.harmonized().copyWith(secondary: _brandBlue);
  }

  @override
  Widget build(BuildContext context) {
    // Wrap MaterialApp with a DynamicColorBuilder.
    return DynamicColorBuilder(
      customBuilder: (schemes) {
        ColorScheme? light;
        // Not yet available
        // ColorScheme? lightMedium;
        ColorScheme? lightHigh;

        ColorScheme? dark;
        // Not yet available
        // ColorScheme? darkMedium;
        ColorScheme? darkHigh;

        if (schemes != null) {
          // On Android S+ devices and other platforms, use the provided dynamic
          // color scheme.
          light = _processColorScheme(schemes.light);
          // lightMedium = _processColorScheme(schemes.lightMediumContrast);
          lightHigh = _processColorScheme(schemes.lightHighContrast);

          dark = _processColorScheme(schemes.dark);
          // darkMedium = _processColorScheme(schemes.darkMediumContrast);
          darkHigh = _processColorScheme(schemes.darkHighContrast);

          _isDemoUsingDynamicColors = true; // ignore, only for demo purposes
        } else {
          light = ColorScheme.fromSeed(
            seedColor: _brandBlue,
          );

          dark = ColorScheme.fromSeed(
            seedColor: _brandBlue,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          theme: ThemeData(
            colorScheme: light,
            extensions: [lightCustomColors.harmonized(light)],
          ),
          // mediumContrastTheme: ThemeData(
          //   colorScheme: lightMedium,
          //   extensions: [lightCustomColors.harmonized(lightMedium ?? light)],
          // ),
          highContrastTheme: ThemeData(
            colorScheme: lightHigh,
            extensions: [lightCustomColors.harmonized(lightHigh ?? light)],
          ),
          darkTheme: ThemeData(
            colorScheme: dark,
            extensions: [darkCustomColors.harmonized(dark)],
          ),
          // mediumContrastDarkTheme: ThemeData(
          //   colorScheme: darkMedium,
          //   extensions: [darkCustomColors.harmonized(darkMedium ?? dark)],
          // ),
          highContrastDarkTheme: ThemeData(
            colorScheme: darkHigh,
            extensions: [darkCustomColors.harmonized(darkHigh ?? dark)],
          ),
          home: const Home(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.danger,
  });

  final Color? danger;

  @override
  CustomColors copyWith({Color? danger}) {
    return CustomColors(
      danger: danger ?? this.danger,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(danger: danger!.harmonizeWith(dynamic.primary));
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
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
    String harmonizedMsg = _isDemoUsingDynamicColors
        ? ' (harmonized with ColorScheme.primary)'
        : ' (not harmonized)';

    return Scaffold(
      body: Container(
        constraints: contentMaxWidth,
        padding: contentPadding,
        child: Column(
          children: [
            ColoredSquare(
              Theme.of(context).colorScheme.primary,
              'ColorScheme.primary$dynamicMsg',
            ),
            ColoredSquare(
              Theme.of(context).extension<CustomColors>()!.danger,
              'CustomColors.danger$harmonizedMsg',
            ),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                errorText: 'This color is ColorScheme.error$dynamicMsg',
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
