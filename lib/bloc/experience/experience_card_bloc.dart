import 'package:flutter_bloc/flutter_bloc.dart';

import 'experience_card_event.dart';
import 'experience_card_state.dart';

class ExperienceCardBloc extends Bloc<ExperienceCardEvent, ExperienceCardState> {
  ExperienceCardBloc() : super(const ExperienceCardState()) {
    on<ToggleExperienceCard>((event, emit) {
      emit(state.copyWith(isExpanded: !state.isExpanded));
    });
  }
}