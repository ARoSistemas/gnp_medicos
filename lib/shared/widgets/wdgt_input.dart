import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A customizable text form field that automatically 
/// validates when it loses focus.
///
/// This widget wraps a standard [TextFormField] and adds the functionality to
/// trigger validation as soon as the user navigates away from the field. This
/// provides immediate feedback without waiting for a form submission.
///
/// It accepts all the common properties of a [TextFormField], such as a
/// [controller], [validator], and [decoration], making it a flexible and
/// easy-to-use replacement.
///
/// ### Example Usage:
///
/// ```dart
/// Form(
///   key: _formKey,
///   child: InputField(
///     controller: _emailController,
///     decoration: InputDecoration(
///       labelText: 'Email',
///       hintText: 'Enter your email',
///     ),
///     validator: (value) {
///       if (value == null || !value.contains('@')) {
///         return 'Please enter a valid email';
///       }
///       return null;
///     },
///     keyboardType: TextInputType.emailAddress,
///   ),
/// )
/// ```
class InputField extends StatefulWidget {
  /// Creates a text form field that validates on focus loss.
  const InputField({
    required this.controller,
    super.key,
    this.validator,
    this.decoration,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
  });

  @override
  State<InputField> createState() => _InputFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<TextEditingController>('controller', controller),
      )
      ..add(
        ObjectFlagProperty<FormFieldValidator<String>?>.has(
          'validator',
          validator,
        ),
      )
      ..add(
        DiagnosticsProperty<InputDecoration?>('decoration', decoration),
      )
      ..add(
        DiagnosticsProperty<TextInputType?>('keyboardType', keyboardType),
      )
      ..add(DiagnosticsProperty<bool>('obscureText', obscureText))
      ..add(DiagnosticsProperty<bool?>('enabled', enabled));
  }

  /// Controls whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  /// Whether the text field is interactive. Defaults to true.
  final bool enabled;

  /// The controller for the text being edited.
  final TextEditingController controller;

  /// The decoration to show around the text field.
  final InputDecoration? decoration;

  /// An optional method that validates an input. Returns an error string 
  /// to display if the input is invalid, or null otherwise.
  final FormFieldValidator<String>? validator;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;
}

class _InputFieldState extends State<InputField> {
  final _focusNode = FocusNode();
  final _fieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _fieldKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _fieldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextFormField(
    key: _fieldKey,
    enabled: widget.enabled,
    obscureText: widget.obscureText,
    controller: widget.controller,
    focusNode: _focusNode,
    decoration: widget.decoration,
    validator: widget.validator,
    keyboardType: widget.keyboardType,
  );
}
