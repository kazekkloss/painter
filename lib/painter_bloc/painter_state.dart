part of 'painter_bloc.dart';

@immutable
class PainterState {
  final List<Sketch> listSketch;
  final Sketch sketch;

  const PainterState({required this.sketch, required this.listSketch});
}
