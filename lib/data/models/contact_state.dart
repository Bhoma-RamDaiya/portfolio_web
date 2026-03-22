enum ContactStatus { initial, loading, success, failure }

class ContactState {
  final String name;
  final String email;
  final String message;
  final ContactStatus status;
  final String? errorMessage;

  const ContactState({
    this.name = '',
    this.email = '',
    this.message = '',
    this.status = ContactStatus.initial,
    this.errorMessage,
  });

  // ── Validation — UI logic stays in state ──
  bool get isNameValid    => name.trim().isNotEmpty;
  bool get isEmailValid   =>
      RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  bool get isMessageValid => message.trim().isNotEmpty;
  bool get isFormValid    => isNameValid && isEmailValid && isMessageValid;

  ContactState copyWith({
    String? name,
    String? email,
    String? message,
    ContactStatus? status,
    String? errorMessage,
  }) =>
      ContactState(
        name:         name         ?? this.name,
        email:        email        ?? this.email,
        message:      message      ?? this.message,
        status:       status       ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}