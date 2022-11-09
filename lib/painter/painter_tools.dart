import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:paint/painter/config/sketcher.dart';
import 'package:paint/painter_bloc/painter_bloc.dart';

class PainterTools extends StatelessWidget {
  const PainterTools({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PainterBloc, PainterState>(
      builder: (context, state) {
        var strokeWidth = state.sketch.width.toInt();
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: const Color.fromARGB(255, 255, 255, 255),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(6, 6),
                  spreadRadius: -9,
                  blurRadius: 24,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
                BoxShadow(
                  offset: Offset(-6, -6),
                  spreadRadius: -9,
                  blurRadius: 24,
                  color: Color.fromRGBO(0, 0, 0, 1),
                )
              ]),
          child: SizedBox(
            height: 600,
            width: 350,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 211, 211, 211),
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<PainterBloc>()
                                .add(ChangeModeEvent(mode: DrawingMode.pencil));
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            context
                                .read<PainterBloc>()
                                .add(ChangeModeEvent(mode: DrawingMode.line));
                          },
                          icon: const Icon(Icons.line_axis_outlined)),
                      IconButton(
                          onPressed: () {
                            context
                                .read<PainterBloc>()
                                .add(ChangeModeEvent(mode: DrawingMode.square));
                          },
                          icon: const Icon(Icons.rectangle_outlined)),
                      IconButton(
                          onPressed: () {
                            context
                                .read<PainterBloc>()
                                .add(ChangeModeEvent(mode: DrawingMode.circle));
                          },
                          icon: const Icon(Icons.circle_outlined)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      const Text(
                        'Fill Shape: ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Checkbox(
                        value: state.sketch.filled,
                        onChanged: (val) {
                          !state.sketch.filled
                              ? context
                                  .read<PainterBloc>()
                                  .add(SetFilledEvent(filled: true))
                              : context
                                  .read<PainterBloc>()
                                  .add(SetFilledEvent(filled: false));
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Slider(
                        value: state.sketch.width,
                        min: 1,
                        max: 40,
                        onChanged: (val) {
                          context
                              .read<PainterBloc>()
                              .add(SkechWidthEvent(width: val));
                        }),
                    Text(strokeWidth.toString())
                  ],
                ),
                Center(
                  child: CircleColorPicker(
                    textStyle: const TextStyle(fontSize: 0),
                    onChanged: (color) {
                      context
                          .read<PainterBloc>()
                          .add(ChangeColorEvent(color: color));
                    },
                    size: const Size(240, 240),
                    strokeWidth: 10,
                    thumbSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<PainterBloc>().add(UndoEvent());
                      },
                      icon: const Icon(
                        Icons.undo,
                        size: 50,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<PainterBloc>().add(ClearEvent());
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
