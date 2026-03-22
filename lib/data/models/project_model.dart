
class Project {
  final String title;
  final String description;
  final String tech;
  final String? url;

  Project({
    required this.title,
    required this.description,
    required this.tech,
    this.url,
  });
}
