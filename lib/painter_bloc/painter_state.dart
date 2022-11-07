part of 'painter_bloc.dart';

@immutable
class PainterState {
  final List<DrawnLine> lines;
  final DrawnLine line;

  const PainterState({required this.line, required this.lines});
}

