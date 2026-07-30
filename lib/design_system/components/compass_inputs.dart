import 'package:flutter/material.dart';
import 'package:kompas/design_system/icons/compass_icons.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

class CompassInput extends StatelessWidget {
  const CompassInput({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      enabled: enabled,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class CompassSearchField extends StatelessWidget {
  const CompassSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.hint = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return CompassInput(
      controller: controller,
      focusNode: focusNode,
      hint: hint,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      prefixIcon: const Icon(CompassIcons.search),
      suffixIcon: onClear == null
          ? null
          : IconButton(
              tooltip: 'Clear',
              onPressed: onClear,
              icon: const Icon(CompassIcons.close),
            ),
    );
  }
}

/// Helper for showing Compass-styled bottom sheets.
abstract final class CompassBottomSheets {
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: true,
      builder: builder,
    );
  }
}

/// Helper for Compass dialogs.
abstract final class CompassDialogs {
  static Future<T?> showAlert<T>({
    required BuildContext context,
    required String title,
    required String body,
    String confirmLabel = 'OK',
    String? cancelLabel,
    VoidCallback? onConfirm,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            if (cancelLabel != null)
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(cancelLabel),
              ),
            FilledButton(
              onPressed: () {
                onConfirm?.call();
                Navigator.of(context).pop(true);
              },
              child: Text(confirmLabel),
            ),
          ],
        );
      },
    );
  }
}

/// Floating snackbars with consistent styling.
abstract final class CompassSnackbars {
  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          action: actionLabel == null
              ? null
              : SnackBarAction(
                  label: actionLabel,
                  onPressed: onAction ?? () {},
                ),
        ),
      );
  }
}

/// Decorative sheet handle — usually provided by theme; available for custom sheets.
class CompassSheetHandle extends StatelessWidget {
  const CompassSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(bottom: CompassSpacing.md),
        decoration: BoxDecoration(
          color: scheme.outline.withOpacity(0.7),
          borderRadius: BorderRadius.circular(CompassRadii.pill),
        ),
      ),
    );
  }
}
