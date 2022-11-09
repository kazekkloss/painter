part of 'painter_bloc.dart';

@immutable
abstract class PainterEvent {}

class OnStartEvent extends PainterEvent {
  final BuildContext context;
  final DragStartDetails details;
  OnStartEvent({required this.details, required this.context});
}

class OnUpdateEvent extends PainterEvent {
  final BuildContext context;
  final DragUpdateDetails details;
  OnUpdateEvent({required this.details, required this.context});
}

class OnEndEvent extends PainterEvent {
  final BuildContext context;
  final DragEndDetails details;
  OnEndEvent({required this.details, required this.context});
}

class SkechWidthEvent extends PainterEvent {
  final double width;
  SkechWidthEvent({required this.width});
}

class ChangeColorEvent extends PainterEvent {
  final Color color;
  ChangeColorEvent({required this.color});
}

class ChangeModeEvent extends PainterEvent {
  final DrawingMode mode;
  ChangeModeEvent({required this.mode});
}

class SetFilledEvent extends PainterEvent {
  final bool filled;
  SetFilledEvent({required this.filled});
}

class UndoEvent extends PainterEvent {}

class ClearEvent extends PainterEvent {}
