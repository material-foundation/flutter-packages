import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class IsCorePaletteSupportedApiExample extends StatefulWidget {
  const IsCorePaletteSupportedApiExample({Key? key}) : super(key: key);

  static const title = 'DynamicColorPlugin.isCorePaletteSupported()';

  @override
  State<IsCorePaletteSupportedApiExample> createState() =>
      _IsCorePaletteSupportedApiExampleState();
}

class _IsCorePaletteSupportedApiExampleState
    extends State<IsCorePaletteSupportedApiExample> {
  late Future<bool> isCorePaletteSupported;

  @override
  void initState() {
    super.initState();

    isCorePaletteSupported = DynamicColorPlugin.isCorePaletteSupported();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FutureBuilder<bool>(
                  future: DynamicColorPlugin.isCorePaletteSupported(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(
                        'isCorePaletteSupported: ${snapshot.data}',
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
