class SocialIconState {
  final Set<String> hoveredIcons;

  const SocialIconState({this.hoveredIcons = const {}});

  bool isHovered(String iconId) => hoveredIcons.contains(iconId);

  SocialIconState copyWith({Set<String>? hoveredIcons}) {
    return SocialIconState(
      hoveredIcons: hoveredIcons ?? this.hoveredIcons,
    );
  }
}