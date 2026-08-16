import 'package:flutter/material.dart';

class MBMainInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String placeholder;

  const MBMainInput({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.placeholder = '',
  });

  @override
  State<MBMainInput> createState() => _MBMainInputState();
}

class _MBMainInputState extends State<MBMainInput> {
  final FocusNode _focusNode = FocusNode();
  late bool _obscureText = widget.obscureText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 13, fontFamily: 'Lexend', fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 4),
        AnimatedContainer(
          alignment: Alignment.centerLeft,
          height: 52,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _focusNode.hasFocus ? Colors.cyan : Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              obscureText: _obscureText,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w300,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: _focusNode.hasFocus
                        ? Colors.cyan.shade700
                        : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                hintText: widget.placeholder,
                hintStyle: const TextStyle(color: Colors.black),
                suffixIcon: widget.obscureText
                  ? IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    tooltip: _obscureText ? 'Mostrar senha' : 'Ocultar senha',
                    onPressed: () { setState(() {_obscureText = !_obscureText;}); },
                  ) : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
