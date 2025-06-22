import 'package:flutter/material.dart';

import 'planet_painter.dart';

/// Renders the interactive 3-D planet.
/// Rebuilds only when [_mouse] changes; the rest of the page
/// stays untouched, so performance remains high.
class PlanetWidget extends StatelessWidget {
  const PlanetWidget({Key? key, required this.mouse}) : super(key: key);

  /// ValueNotifier supplied by HomeView; emits the global mouse position.
  final ValueNotifier<Offset> mouse;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ValueListenableBuilder<Offset>(
        valueListenable: mouse,
        builder: (_, pos, __) {
          return SizedBox(
            width: 360,
            height: 360,
            child: CustomPaint(
              painter: PlanetPainter(
                mousePosition: pos,
                screenSize: MediaQuery.of(context).size,
              ),
            ),
          );
        },
      ),
    );
  }
}
