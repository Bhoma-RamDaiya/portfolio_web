
class ProjectCardState {
  final bool isExpanded;
  const ProjectCardState({this.isExpanded = false});

  ProjectCardState copyWith({bool? isExpanded}) =>
      ProjectCardState(isExpanded: isExpanded ?? this.isExpanded);
}