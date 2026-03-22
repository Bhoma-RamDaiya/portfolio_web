import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/project_card_bloc.dart';
import 'package:myapp/bloc/project_card_event.dart';

class ProjectCardBloc extends Bloc<ProjectCardEvent, ProjectCardState> {
  ProjectCardBloc() : super(const ProjectCardState()) {
    on<ToggleProjectCard>((event, emit) {
      emit(state.copyWith(isExpanded: !state.isExpanded));
    });
  }
}