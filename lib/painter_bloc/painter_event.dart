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
