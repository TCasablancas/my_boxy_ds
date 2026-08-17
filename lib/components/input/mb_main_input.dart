import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_boxy_ds/ui/mb_box_decorations.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';
import 'package:my_boxy_ds/ui/mb_input_decorations.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';

enum MBInputFieldType { generic, usernameOrEmail, password }

const _commonEmailDomains = [
  'gmail.com',
  'hotmail.com',
  'outlook.com',
  'yahoo.com',
  'icloud.com',
  'live.com',
  'uol.com.br',
  'bol.com.br',
  'hotmail.com.br',
  'outlook.com.br',
];

final _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}(\.[a-zA-Z]{2,})?$');
final _usernameRegex = RegExp(r'^[A-Za-z0-9_.-]+$');

int _levenshtein(String a, String b) {
  final costs = List<int>.generate(b.length + 1, (i) => i);
  for (var i = 1; i <= a.length; i++) {
    var previous = costs[0];
    costs[0] = i;
    for (var j = 1; j <= b.length; j++) {
      final current = costs[j];
      costs[j] = a[i - 1] == b[j - 1]
          ? previous
          : 1 + [previous, costs[j], costs[j - 1]].reduce((x, y) => x < y ? x : y);
      previous = current;
    }
  }
  return costs[b.length];
}

String? _closestDomain(String domain) {
  String? closest;
  var bestDistance = 3;
  for (final candidate in _commonEmailDomains) {
    final distance = _levenshtein(domain, candidate);
    if (distance > 0 && distance < bestDistance) {
      bestDistance = distance;
      closest = candidate;
    }
  }
  return closest;
}

String? _validateEmail(String text) {
  if (!_emailRegex.hasMatch(text)) return 'E-mail inválido';
  final domain = text.split('@').last.toLowerCase();
  if (_commonEmailDomains.contains(domain)) return null;
  final closest = _closestDomain(domain);
  if (closest != null) return 'Você quis dizer @$closest?';
  return null;
}

String? _validateUsernameOrEmail(String text) {
  if (text.contains('@')) return _validateEmail(text);
  if (text.length < 3) return 'Usuário deve ter no mínimo 3 caracteres';
  if (!_usernameRegex.hasMatch(text)) return 'Usuário contém caracteres inválidos';
  return null;
}

class MBMainInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String placeholder;
  final String? error;
  final MBInputFieldType fieldType;
  final Future<String?> Function(String value)? onAsyncValidate;

  const MBMainInput({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.placeholder = '',
    this.error,
    this.fieldType = MBInputFieldType.generic,
    this.onAsyncValidate,
  });

  @override
  State<MBMainInput> createState() => _MBMainInputState();
}

class _MBMainInputState extends State<MBMainInput> {
  final FocusNode _focusNode = FocusNode();
  late bool _obscureText = widget.obscureText;
  final Duration _duration = Duration(milliseconds: 300);

  Timer? _debounce;
  String? _validationError;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MBMainInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _obscureText = widget.obscureText;
    }
  }

  void _onTextChanged() {
    setState(() {});

    if (widget.fieldType != MBInputFieldType.usernameOrEmail) return;

    _debounce?.cancel();
    final text = widget.controller.text;

    if (text.isEmpty) {
      setState(() {
        _validationError = null;
        _isValid = false;
      });
      return;
    }

    final localError = _validateUsernameOrEmail(text);
    if (localError != null) {
      setState(() {
        _validationError = localError;
        _isValid = false;
      });
      return;
    }

    if (widget.onAsyncValidate == null) {
      setState(() {
        _validationError = null;
        _isValid = text.contains('@');
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      final asyncError = await widget.onAsyncValidate!(text);
      if (!mounted || widget.controller.text != text) return;
      setState(() {
        _validationError = asyncError;
        _isValid = asyncError == null;
      });
    });
  }

  String? get _effectiveError {
    if (widget.error != null) return widget.error;
    if (widget.fieldType == MBInputFieldType.password) return null;
    return _validationError;
  }

  ({Color border, Color background}) get _visualState {
    if (_effectiveError != null) {
      return (border: AppColors.error, background: AppColors.errorLight);
    }
    if (!_focusNode.hasFocus || widget.controller.text.isEmpty) {
      return (border: Colors.grey[400]!, background: Colors.grey[300]!);
    }
    if (widget.fieldType == MBInputFieldType.usernameOrEmail && _isValid) {
      return (border: AppColors.focus, background: AppColors.focusLight);
    }
    return (border: AppColors.primary, background: AppColors.primaryLight);
  }

  IconButton? _obscureTextIcon(bool obscureText) {
    return obscureText
      ? IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        tooltip: _obscureText ? 'Mostrar senha' : 'Ocultar senha',
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ) : null;
  }

  Widget? _showErrorMessage(String? error) {
    return error != null
      ? SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            error,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'SFMono',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.75,
              color: AppColors.error,
            ),
          ),
        ),
      ): null;
  }

  @override
  Widget build(BuildContext context) {
    final state = _visualState;
    final isNeutralGray = _effectiveError == null &&
        (!_focusNode.hasFocus || widget.controller.text.isEmpty);
    final labelColor = isNeutralGray ? Colors.grey[500] : state.border;

    return Column(
      children: [
        AnimatedContainer(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          decoration: BoxDecoration(
            color: state.background,
            borderRadius: BorderRadius.circular(12),
          ),
          duration: _duration,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: AnimatedContainer(
              duration: _duration,
              decoration: AppBoxDecorations.borderedBoxDecoration(state.border),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 16, 0),
                      child: Text(
                        widget.label,
                        textAlign: TextAlign.left,
                        style: AppTypography.setSnackbarStyle(labelColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SizedBox(
                      height: 32,
                      child: TextField(
                        focusNode: _focusNode,
                        controller: widget.controller,
                        obscureText: _obscureText,
                        style: AppTypography.setInputStyle(),
                        decoration: AppInputDecorations.transparentInput(
                          _obscureTextIcon(widget.obscureText),
                          widget.placeholder,
                        ),
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _showErrorMessage(_effectiveError) ?? SizedBox.shrink(),
      ],
    );
  }
}
