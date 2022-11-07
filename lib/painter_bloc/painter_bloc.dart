import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:paint/painter/model/drawn_line.dart';

part 'painter_event.dart';
part 'painter_state.dart';

class PainterBloc extends Bloc<PainterEvent, PainterState> {
  PainterBloc()
      : super(
          PainterState(
            lines: const <DrawnLine>[],
            line: DrawnLine(
              path: [],
              color: Colors.black,
              width: 3.0,
            ),
          ),
        ) {
    on<OnStartEvent>(_onStartEventToState);
    on<OnUpdateEvent>(_onUpdateEventToState);
    on<OnEndEvent>(_onEndEventToState);
  }

  void _onStartEventToState(OnStartEvent event, Emitter<PainterState> emiter) {
    var color = state.line.color;
    var width = state.line.width;
    var lines = state.lines;
    final box = event.context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(event.details.globalPosition);
    emit(PainterState(
        line: DrawnLine(path: [offset], color: color, width: width),
        lines: lines));
  }

  void _onUpdateEventToState(
      OnUpdateEvent event, Emitter<PainterState> emiter) {
    var line = state.line;
    var color = state.line.color;
    var width = state.line.width;
    final box = event.context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(event.details.globalPosition);

    List<Offset> path = List.from(line.path)..add(offset);
    line = DrawnLine(path: path, color: color, width: width);
    emit(PainterState(line: line, lines: state.lines));
  }

  void _onEndEventToState(OnEndEvent event, Emitter<PainterState> emitter) {
    var lines = List<DrawnLine>.from(state.lines)..add(state.line);
    emit(PainterState(line: state.line, lines: lines));
  }
}
