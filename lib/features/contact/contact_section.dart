import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/contact_bloc/contact_bloc.dart';
import 'package:myapp/bloc/contact_bloc/contact_event.dart';
import 'package:myapp/data/models/contact_state.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../widgets/neon_button.dart';

class ContactSection extends StatelessWidget {
  final BoxConstraints constraints;
  const ContactSection({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactBloc(),
      child: _ContactView(constraints: constraints),
    );
  }
}

class _ContactView extends StatelessWidget {
  final BoxConstraints constraints;
  const _ContactView({required this.constraints});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = constraints.maxWidth < 600;

    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        // ── Show snackbar on success or failure ──
        if (state.status == ContactStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Message sent successfully!'),
              backgroundColor: AppColors.accent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        if (state.status == ContactStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Something went wrong.'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 48,
          vertical: 48,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Get in Touch', style: AppStyles.sectionTitle(constraints)),
            const SizedBox(height: 16),
            Text(
              'Have a project in mind? Want to collaborate? Feel free to reach out!',
              style: AppStyles.bodyText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: BlocBuilder<ContactBloc, ContactState>(
                builder: (context, state) {
                  final bool isLoading =
                      state.status == ContactStatus.loading;
                  final bool isSuccess =
                      state.status == ContactStatus.success;

                  // ── Success state — replace form ──
                  if (isSuccess) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: AppColors.accent,
                          size: 64,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Message Sent!',
                          style: AppStyles.skillName.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Thanks for reaching out. I will get back to you soon.',
                          style: AppStyles.bodyText,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }

                  // ── Form state ──
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      // ── Name ──
                      TextFormField(
                        enabled: !isLoading,
                        style: AppStyles.bodyText,
                        onChanged: (v) => context
                            .read<ContactBloc>()
                            .add(ContactNameChanged(v)),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: AppStyles.bodyText
                              .copyWith(color: Colors.white54),
                          filled: true,
                          fillColor: AppColors.glassmorphismBg,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: AppColors.accent.withAlpha(77)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: AppColors.accent, width: 1.5),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: AppColors.accent.withAlpha(30)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ── Email ──
                      TextFormField(
                        enabled: !isLoading,
                        style: AppStyles.bodyText,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (v) => context
                            .read<ContactBloc>()
                            .add(ContactEmailChanged(v)),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: AppStyles.bodyText
                              .copyWith(color: Colors.white54),
                          // ── Show error only after user types ──
                          errorText: state.email.isNotEmpty &&
                              !state.isEmailValid
                              ? 'Enter a valid email'
                              : null,
                          filled: true,
                          fillColor: AppColors.glassmorphismBg,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: AppColors.accent.withAlpha(77)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: AppColors.accent, width: 1.5),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: AppColors.accent.withAlpha(30)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Colors.redAccent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Colors.redAccent, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ── Message ──
                      TextFormField(
                        enabled: !isLoading,
                        style: AppStyles.bodyText,
                        maxLines: 5,
                        onChanged: (v) => context
                            .read<ContactBloc>()
                            .add(ContactMessageChanged(v)),
                        decoration: InputDecoration(
                          labelText: 'Message',
                          labelStyle: AppStyles.bodyText
                              .copyWith(color: Colors.white54),
                          filled: true,
                          fillColor: AppColors.glassmorphismBg,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: AppColors.accent.withAlpha(77)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: AppColors.accent, width: 1.5),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: AppColors.accent.withAlpha(30)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ── Submit button — your existing NeonButton ──
                      isLoading
                          ? CircularProgressIndicator(
                        color: AppColors.accent,
                      )
                          : NeonButton(
                        text: 'Submit',
                        // ── Disabled until form is valid ──
                        onPressed: state.isFormValid
                            ? () => context
                            .read<ContactBloc>()
                            .add(ContactSubmitted())
                            : (){},
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
