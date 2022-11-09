import 'package:flutter/material.dart';
import 'package:paint/painter_bloc/painter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/sketcher.dart';

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
            color: const Color.fromARGB(255, 255, 255, 255),
            height: height,
            width: width,
            child: Stack(
              children: [
                CustomPaint(
                  painter: Sketcher(
                    sketches: state.listSketch,
                  ),
                ),
                CustomPaint(
                  painter: Sketcher(
                    sketches: [state.sketch],
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
