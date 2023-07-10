import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class AppHeatmap extends StatelessWidget {
  const AppHeatmap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      colorsets: {
        0: Colors.white,
        1: Colors.green[50]!,
        2: Colors.green[100]!,
        3: Colors.green[200]!,
        4: Colors.green[300]!,
        5: Colors.green[400]!,
        6: Colors.green,
        7: Colors.green[600]!,
        8: Colors.green[700]!,
        9: Colors.green[800]!,
        10: Colors.green[900]!,
      },
      colorMode: ColorMode.color,
      textColor: Theme.of(context).colorScheme.onBackground,
      datasets: {
        DateTime(2023, 7, 10): 9,
        DateTime(2023, 7, 9): 5,
      },
      defaultColor: Theme.of(context).colorScheme.surfaceVariant,
      scrollable: true,
      size: 24,
    );
  }
}
