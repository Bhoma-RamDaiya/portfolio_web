abstract class ContactEvent {}

class ContactNameChanged extends ContactEvent {
  final String name;
  ContactNameChanged(this.name);
}

class ContactEmailChanged extends ContactEvent {
  final String email;
  ContactEmailChanged(this.email);
}

class ContactMessageChanged extends ContactEvent {
  final String message;
  ContactMessageChanged(this.message);
}

class ContactSubmitted extends ContactEvent {}