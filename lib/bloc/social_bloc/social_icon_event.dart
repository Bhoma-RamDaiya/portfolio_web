abstract class SocialIconEvent {}

class SocialIconHovered extends SocialIconEvent {
  final String iconId;
  SocialIconHovered(this.iconId);
}

class SocialIconUnhovered extends SocialIconEvent {
  final String iconId;
  SocialIconUnhovered(this.iconId);
}