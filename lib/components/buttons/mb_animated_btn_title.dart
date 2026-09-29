import 'package:flutter/material.dart';

/// Button title that animates whenever [text] changes.
///
/// The current title slides up and out of a clipped box sized to its own
/// width, then the new title slides in from below.
class MBAnimatedButtonTitle extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Duration duration;

  const MBAnimatedButtonTitle({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<MBAnimatedButtonTitle> createState() => _MBAnimatedButtonTitleState();
}

class _MBAnimatedButtonTitleState extends State<MBAnimatedButtonTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offset;
  late String _outgoing;

  @override
  void initState() {
    super.initState();
    _outgoing = widget.text;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: 1,
    );
    _offset = _controller.drive(
      TweenSequence<Offset>([
        TweenSequenceItem(
          tween: Tween(begin: Offset.zero, end: const Offset(0, -1))
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween(begin: const Offset(0, 1), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50,
        ),
      ]),
    );
  }

  @override
  void didUpdateWidget(covariant MBAnimatedButtonTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.duration;
    if (oldWidget.text == widget.text) return;

    // Mid slide-out: the outgoing text is still leaving, just swap the target.
    if (_isShowingOutgoing) return;

    _outgoing = oldWidget.text;
    _controller.forward(from: 0);
  }

  bool get _isShowingOutgoing =>
      _controller.isAnimating && _controller.value < 0.5;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => FractionalTranslation(
          translation: _offset.value,
          child: Text(
            _isShowingOutgoing ? _outgoing : widget.text,
            textAlign: widget.textAlign,
            style: widget.style,
          ),
        ),
      ),
    );
  }
}
