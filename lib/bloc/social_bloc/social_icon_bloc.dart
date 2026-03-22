import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/social_bloc/social_icon_event.dart';
import 'package:myapp/bloc/social_bloc/social_ion_state.dart';

class SocialIconBloc extends Bloc<SocialIconEvent, SocialIconState> {
  SocialIconBloc() : super(const SocialIconState()) {
    on<SocialIconHovered>((event, emit) {
      final updated = Set<String>.from(state.hoveredIcons)..add(event.iconId);
      emit(state.copyWith(hoveredIcons: updated));
    });

    on<SocialIconUnhovered>((event, emit) {
      final updated = Set<String>.from(state.hoveredIcons)..remove(event.iconId);
      emit(state.copyWith(hoveredIcons: updated));
    });
  }
}