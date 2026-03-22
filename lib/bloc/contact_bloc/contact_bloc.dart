import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/data/models/contact_state.dart';
import 'contact_event.dart';


class ContactBloc extends Bloc<ContactEvent, ContactState> {

  static const String _botToken = '8719347113:AAHgvluE0B2yz6EI9vAU_NfSjo_Q1MeaF6M';
  static const String _chatId   = '6973104387';

  ContactBloc() : super(const ContactState()) {
    on<ContactNameChanged>((e, emit) => emit(
        state.copyWith(name: e.name, status: ContactStatus.initial)));

    on<ContactEmailChanged>((e, emit) => emit(
        state.copyWith(email: e.email, status: ContactStatus.initial)));

    on<ContactMessageChanged>((e, emit) => emit(
        state.copyWith(message: e.message, status: ContactStatus.initial)));

    on<ContactSubmitted>(_onSubmit);
  }

  Future<void> _onSubmit(
      ContactSubmitted event,
      Emitter<ContactState> emit,
      ) async {
    if (!state.isFormValid) return;

    emit(state.copyWith(status: ContactStatus.loading));

    try {
      // ── This is the message you receive on Telegram ──
      final String text = '''
👋 *New Portfolio Contact*

👤 *Name:* ${state.name}
📧 *Email:* ${state.email}

💬 *Message:*
${state.message}
      ''';

      final response = await http.post(
        Uri.parse(
          'https://api.telegram.org/bot$_botToken/sendMessage',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'chat_id':    _chatId,
          'text':       text,
          'parse_mode': 'Markdown',
        }),
      );

      if (response.statusCode == 200) {
        emit(state.copyWith(status: ContactStatus.success));
      } else {
        emit(state.copyWith(
          status: ContactStatus.failure,
          errorMessage: 'Something went wrong. Please try again.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ContactStatus.failure,
        errorMessage: 'No internet connection.',
      ));
    }
  }
}