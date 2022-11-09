import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:paint/painter/config/sketcher.dart';
import 'package:paint/painter/model/sketch.dart';

part 'painter_event.dart';
part 'painter_state.dart';

class PainterBloc extends Bloc<PainterEvent, PainterState> {
  PainterBloc()
      : super(
          PainterState(
            listSketch: const <Sketch>[],
            sketch: Sketch(
              points: [],
              color: Colors.black,
              width: 10.0,
              mode: DrawingMode.pencil,
              filled: false,
            ),
          ),
        ) {
    on<OnStartEvent>(_onStartEventToState);
    on<OnUpdateEvent>(_onUpdateEventToState);
    on<OnEndEvent>(_onEndEventToState);
    on<SkechWidthEvent>(_skechWidthEventToState);
    on<ChangeColorEvent>(_changeColorEventToState);
    on<ChangeModeEvent>(_changeTypeEventToState);
    on<SetFilledEvent>(_setFilledEventToState);
    on<UndoEvent>(_undoEventToState);
    on<ClearEvent>(_clearEventToState);
  }

  void _onStartEventToState(OnStartEvent event, Emitter<PainterState> emit) {
    try {
      final box = event.context.findRenderObject() as RenderBox;
      final offset = box.globalToLocal(event.details.globalPosition);
      emit(PainterState(
          sketch: Sketch(
              points: [offset],
              color: state.sketch.color,
              width: state.sketch.width,
              mode: state.sketch.mode,
              filled: state.sketch.filled),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onUpdateEventToState(OnUpdateEvent event, Emitter<PainterState> emit) {
    try {
      var sketch = state.sketch;
      final box = event.context.findRenderObject() as RenderBox;
      final offset = box.globalToLocal(event.details.localPosition);

      List<Offset> path = List.from(sketch.points)..add(offset);
      sketch = Sketch(
          points: path,
          color: state.sketch.color,
          width: state.sketch.width,
          mode: state.sketch.mode,
          filled: state.sketch.filled);
      emit(PainterState(sketch: sketch, listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onEndEventToState(OnEndEvent event, Emitter<PainterState> emit) {
    try {
      var lines = List<Sketch>.from(state.listSketch)..add(state.sketch);
      emit(PainterState(sketch: state.sketch, listSketch: lines));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _skechWidthEventToState(
      SkechWidthEvent event, Emitter<PainterState> emit) {
    try {
      emit(PainterState(
          sketch: Sketch(
              color: state.sketch.color,
              points: state.sketch.points,
              width: event.width,
              mode: state.sketch.mode,
              filled: state.sketch.filled),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _changeColorEventToState(
      ChangeColorEvent event, Emitter<PainterState> emit) {
    try {
      emit(PainterState(
          sketch: Sketch(
              color: event.color,
              points: [],
              width: state.sketch.width,
              mode: state.sketch.mode,
              filled: state.sketch.filled),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _changeTypeEventToState(
      ChangeModeEvent event, Emitter<PainterState> emit) {
    try {
      emit(PainterState(
          sketch: Sketch(
              points: [],
              color: state.sketch.color,
              width: state.sketch.width,
              mode: event.mode,
              filled: state.sketch.filled),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _setFilledEventToState(
      SetFilledEvent event, Emitter<PainterState> emit) {
    try {
      emit(PainterState(
          sketch: Sketch(
              points: [],
              color: state.sketch.color,
              width: state.sketch.width,
              mode: state.sketch.mode,
              filled: event.filled),
          listSketch: state.listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _undoEventToState(UndoEvent event, Emitter<PainterState> emit) {
    try {
      final listSketch = state.listSketch;
      if (listSketch.isNotEmpty) {
        listSketch.remove(listSketch.last);
      }
      emit(PainterState(
          sketch: Sketch(
              points: [],
              color: state.sketch.color,
              width: state.sketch.width,
              mode: state.sketch.mode,
              filled: state.sketch.filled),
          listSketch: listSketch));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _clearEventToState(ClearEvent event, Emitter<PainterState> emit) {
    try {
      emit(PainterState(
          sketch: Sketch(
              points: [],
              color: state.sketch.color,
              width: state.sketch.width,
              mode: state.sketch.mode,
              filled: state.sketch.filled),
          listSketch: const []));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
