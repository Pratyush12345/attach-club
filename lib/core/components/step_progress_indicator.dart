import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  final int totalBars;
  final int selectedBars;
  final double padding;

  const StepProgressIndicator({
    super.key,
    required this.padding,
    required this.totalBars,
    required this.selectedBars,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final barWidth = (width - (2*padding) - ((totalBars - 1) * 6))/totalBars;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for(int i=0; i<selectedBars; i++)
          Container(
            width: barWidth,
            height: 3,
            color: Colors.white,
          ),
        for(int i=0; i<(totalBars-selectedBars); i++)
          Container(
            width: barWidth,
            height: 3,
            color: Colors.white.withOpacity(0.2),
          )
      ],
    );
  }
}
