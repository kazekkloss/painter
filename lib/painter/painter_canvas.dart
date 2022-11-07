import 'package:flutter/material.dart';
import 'package:paint/painter_bloc/painter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/drawn_line.dart';

class PainterCanvas extends StatelessWidget {
  final double height;
  final double width;
  const PainterCanvas({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PainterBloc, PainterState>(
      builder: (context, state) {
        return GestureDetector(
          onPanStart: (details) {
            context
                .read<PainterBloc>()
                .add(OnStartEvent(details: details, context: context));
          },
          onPanUpdate: (details) {
            context
                .read<PainterBloc>()
                .add(OnUpdateEvent(details: details, context: context));
          },
          onPanEnd: (details) {
            context
                .read<PainterBloc>()
                .add(OnEndEvent(details: details, context: context));
          },
          child: Container(
            color: Colors.brown,
            height: height,
            width: width,
            child: Stack(
              children: [
                CustomPaint(
                  painter: Sketcher(
                    lines: [state.line],
                  ),
                ),
                CustomPaint(
                  painter: Sketcher(
                    lines: state.lines,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Sketcher extends CustomPainter {
  final List<DrawnLine> lines;

  Sketcher({required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < lines.length; ++i) {
      if (lines[i] == null) continue;
      for (int j = 0; j < lines[i].path.length - 1; ++j) {
        if (lines[i].path[j] != null && lines[i].path[j + 1] != null) {
          paint.color = lines[i].color;
          paint.strokeWidth = lines[i].width;
          canvas.drawLine(lines[i].path[j], lines[i].path[j + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return true;
  }
}
