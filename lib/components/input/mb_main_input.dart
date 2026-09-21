import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import '../../ui/mb_box_decorations.dart';
import '../../ui/design_tokens/design_tokens.dart';
// import '../../ui/mb_input_decorations.dart';
// import '../../ui/mb_typography.dart';

enum MBInputFieldType {
  generic,
  usernameOrEmail,
  password,
  birthdate,
  cpf,
  phone,
}

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
final _nonDigitsRegex = RegExp(r'\D');
final _digitRegex = RegExp(r'\d');

int _levenshtein(String a, String b) {
  final costs = List<int>.generate(b.length + 1, (i) => i);
  for (var i = 1; i <= a.length; i++) {
    var previous = costs[0];
    costs[0] = i;
    for (var j = 1; j <= b.length; j++) {
      final current = costs[j];
      costs[j] = a[i - 1] == b[j - 1]
          ? previous
          : 1 +
                [
                  previous,
                  costs[j],
                  costs[j - 1],
                ].reduce((x, y) => x < y ? x : y);
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
  if (!_usernameRegex.hasMatch(text)) {
    return 'Usuário contém caracteres inválidos';
  }
  return null;
}

class _BrazilianInputFormatter extends TextInputFormatter {
  final int maxLength;
  final String Function(String digits) format;

  const _BrazilianInputFormatter({
    required this.maxLength,
    required this.format,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(_nonDigitsRegex, '');
    final limitedDigits = digits.substring(
      0,
      digits.length > maxLength ? maxLength : digits.length,
    );
    final formatted = format(limitedDigits);
    final selectionEnd = newValue.selection.baseOffset.clamp(
      0,
      newValue.text.length,
    );
    final digitsBeforeSelection = newValue.text
        .substring(0, selectionEnd)
        .replaceAll(_nonDigitsRegex, '')
        .length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: _selectionOffset(formatted, digitsBeforeSelection),
      ),
    );
  }

  int _selectionOffset(String text, int digitCount) {
    if (digitCount == 0) {
      return 0;
    }

    var foundDigits = 0;
    for (var index = 0; index < text.length; index++) {
      if (_digitRegex.hasMatch(text[index])) {
        foundDigits++;
        if (foundDigits == digitCount) {
          return index + 1;
        }
      }
    }
    return text.length;
  }
}

String _formatBirthdate(String digits) {
  if (digits.length <= 2) {
    return digits;
  }
  if (digits.length <= 4) {
    return '${digits.substring(0, 2)}/${digits.substring(2)}';
  }
  return '${digits.substring(0, 2)}/${digits.substring(2, 4)}/${digits.substring(4)}';
}

String _formatCpf(String digits) {
  if (digits.length <= 3) {
    return digits;
  }
  if (digits.length <= 6) {
    return '${digits.substring(0, 3)}.${digits.substring(3)}';
  }
  if (digits.length <= 9) {
    return '${digits.substring(0, 3)}.${digits.substring(3, 6)}.${digits.substring(6)}';
  }
  return '${digits.substring(0, 3)}.${digits.substring(3, 6)}.${digits.substring(6, 9)}-${digits.substring(9)}';
}

String _formatPhone(String digits) {
  if (digits.length <= 2) {
    return digits.isEmpty ? '' : '($digits';
  }

  final phoneNumber = digits.substring(2);
  if (phoneNumber.length <= 4) {
    return '(${digits.substring(0, 2)}) $phoneNumber';
  }

  final firstPartLength = digits.length <= 10 ? 4 : 5;
  return '(${digits.substring(0, 2)}) ${phoneNumber.substring(0, firstPartLength)}-${phoneNumber.substring(firstPartLength)}';
}

List<TextInputFormatter> _inputFormattersFor(MBInputFieldType fieldType) {
  return switch (fieldType) {
    MBInputFieldType.birthdate => const [
      _BrazilianInputFormatter(maxLength: 8, format: _formatBirthdate),
    ],
    MBInputFieldType.cpf => const [
      _BrazilianInputFormatter(maxLength: 11, format: _formatCpf),
    ],
    MBInputFieldType.phone => const [
      _BrazilianInputFormatter(maxLength: 11, format: _formatPhone),
    ],
    _ => const [],
  };
}

TextInputType _keyboardTypeFor(MBInputFieldType fieldType) {
  return switch (fieldType) {
    MBInputFieldType.birthdate ||
    MBInputFieldType.cpf ||
    MBInputFieldType.phone => TextInputType.number,
    _ => TextInputType.text,
  };
}

class MBMainInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final bool readOnly;
  final String placeholder;
  final String? error;
  final MBInputFieldType fieldType;
  final Future<String?> Function(String value)? onAsyncValidate;
  final EdgeInsetsGeometry? padding;

  const MBMainInput({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.placeholder = '',
    this.error,
    this.fieldType = MBInputFieldType.generic,
    this.onAsyncValidate,
    this.padding,
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
    if (widget.readOnly) {
      return (border: Colors.grey[400]!, background: Colors.grey[300]!);
    }
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
          )
        : null;
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
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final state = _visualState;
    final isNeutralGray =
        widget.readOnly ||
        (_effectiveError == null &&
            (!_focusNode.hasFocus || widget.controller.text.isEmpty));
    final labelColor = isNeutralGray ? Colors.grey[500] : state.border;

    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0.0),
      child: Column(
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
                decoration: BoxDecoration(
                    color: widget.readOnly ? AppColors.grey300 : AppColors.white,
                    border: Border.all(
                      color: state.border,
                      width: 1.5,
                    ),
                    borderRadius: AppRadius.allLg
                ),
                //AppBoxDecorations.borderedBoxDecoration(state.border),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 16, 0),
                        child: Text(
                          widget.label,
                          textAlign: TextAlign.left,
                          style: AppTextStyles.snackbar(labelColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: SizedBox(
                        height: 32,
                        child: IgnorePointer(
                          ignoring: widget.readOnly,
                          child: TextField(
                            focusNode: _focusNode,
                            controller: widget.controller,
                            obscureText: _obscureText,
                            enabled: !widget.readOnly,
                            keyboardType: _keyboardTypeFor(widget.fieldType),
                            inputFormatters: _inputFormattersFor(
                              widget.fieldType,
                            ),
                            style: AppTextStyles.bodyLarge.copyWith(
                              letterSpacing: -0.5,
                            ),
                            decoration: InputDecoration(
                                hintText: widget.placeholder,
                                icon: _obscureTextIcon(
                                  widget.obscureText && !widget.readOnly,
                                ),
                                filled: widget.readOnly,
                                fillColor: widget.readOnly ? state.background : AppColors.grey300,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 12)
                            ),
                            // AppInputDecorations.transparentInput(
                            //   _obscureTextIcon(
                            //     widget.obscureText && !widget.readOnly,
                            //   ),
                            //   widget.placeholder,
                            // ),
                            readOnly: widget.readOnly,
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
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
      )
    );
  }
}
