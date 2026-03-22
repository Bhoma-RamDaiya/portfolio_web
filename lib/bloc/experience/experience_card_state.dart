class ExperienceCardState {
  final bool isExpanded;
  const ExperienceCardState({this.isExpanded = false});

  ExperienceCardState copyWith({bool? isExpanded}) =>
      ExperienceCardState(isExpanded: isExpanded ?? this.isExpanded);
}