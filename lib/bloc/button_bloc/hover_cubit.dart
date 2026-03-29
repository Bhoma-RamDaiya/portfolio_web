import 'package:flutter_bloc/flutter_bloc.dart';

class HoverState {
  final bool isHovered;
  const HoverState({this.isHovered = false});
}

class HoverCubit extends Cubit<HoverState> {
  HoverCubit() : super(const HoverState());

  void onHoverEnter() => emit(HoverState(isHovered: true));
  void onHoverExit()  => emit(HoverState(isHovered: false));
  void toggle()       => emit(HoverState(isHovered: !state.isHovered));
}