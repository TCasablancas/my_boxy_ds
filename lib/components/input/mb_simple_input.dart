import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui/design_tokens/app_colors.dart';
import '../../ui/design_tokens/app_fonts.dart';
import '../../ui/design_tokens/app_sizes.dart';
import '../../ui/design_tokens/app_text_styles.dart';

class MBSimpleInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? label;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final TextAlign textAlign;
  final EdgeInsetsGeometry contentPadding;
  final Duration lineAnimationDuration;

  const MBSimpleInput({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.label,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: AppSizes.small,
      vertical: AppSizes.small,
    ),
    this.lineAnimationDuration = const Duration(milliseconds: 250),
  }) : assert(maxLines > 0),
       assert(minLines > 0),
       assert(minLines <= maxLines);

  @override
  State<MBSimpleInput> createState() => _MBSimpleInputViewState();
}

class _MBSimpleInputViewState extends State<MBSimpleInput> {
  late FocusNode _focusNode;
  late bool _ownsFocusNode;

  @override
  void initState() {
    super.initState();
    _setFocusNode(widget.focusNode);
  }

  @override
  void didUpdateWidget(covariant MBSimpleInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.removeListener(_handleFocusChanged);
      if (_ownsFocusNode) {
        _focusNode.dispose();
      }
      _setFocusNode(widget.focusNode);
    }
  }

  void _setFocusNode(FocusNode? focusNode) {
    _ownsFocusNode = focusNode == null;
    _focusNode = focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChanged);
  }

  void _handleFocusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChanged);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus && widget.enabled;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTextStyles.labelSmall),
          const SizedBox(height: AppSizes.small),
        ],
        Container(
          padding: EdgeInsets.only(bottom: 12),
          height: 30,
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autofocus,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            minLines: widget.obscureText ? 1 : widget.minLines,
            maxLength: widget.maxLength,
            textAlign: widget.textAlign,
            style: AppTextStyles.bodyLarge.copyWith(
                fontFamily: AppFonts.primary,
                fontSize: 14,
                letterSpacing: -0.5,
                height: 1.0
            ),
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyles.bodyLarge.copyWith(
                fontFamily: AppFonts.primary,
                fontSize: 14,
                color: AppColors.grey500,
              ),
              // contentPadding: widget.contentPadding,
              contentPadding:EdgeInsets.all(4.0),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            height: AppSizes.xs,
            child: Stack(
              children: [
                SizedBox(
                  width: constraints.maxWidth,
                  height: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.xs),
                      color: AppColors.grey300,
                    ),
                  ),
                ),
                AnimatedContainer(
                  key: const ValueKey('mb-simple-input-focus-line'),
                  duration: widget.lineAnimationDuration,
                  curve: Curves.easeOutCubic,
                  width: isFocused ? constraints.maxWidth : 0,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
