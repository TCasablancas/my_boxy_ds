import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/buttons/mb_rounded_icon_btn.dart';
import 'package:my_boxy_ds/ui/mb_typography.dart';
import 'package:my_boxy_ds/ui/mb_design_tokens.dart';

class MBMainView extends StatefulWidget {
  final String? viewTitle;
  final bool? backButton;
  final Widget child;
  final Color? backgroundColor;
  final List<Widget>? rightActions;

  const MBMainView({
    super.key,
    required this.child,
    this.backgroundColor,
    this.viewTitle,
    this.backButton,
    this.rightActions,
  });

  @override
  State<MBMainView> createState() => _MBMainViewState();
}

class _MBMainViewState extends State<MBMainView> {

  TextStyle _appBarStyle() {
    return AppTypography.body1Fn(Colors.grey[500]!, FontWeight.w700);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.viewTitle != null ? Text(widget.viewTitle!, style: _appBarStyle()) : null,
        automaticallyImplyLeading: false, 
        leading: widget.backButton != false
          ? Container(
              margin: const EdgeInsets.only(left: 16.0),
              alignment: Alignment.centerLeft,
              child: MBRoundedIconButton(
                icon: Icon(Icons.arrow_back, color: Colors.grey[700]),
                // buttonSize: MBRoundedIconButtonSize.small,
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          : null,
        actions: widget.rightActions,
        backgroundColor: widget.backgroundColor ?? AppColors.lightBackground,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.backgroundColor ?? AppColors.lightBackground,
      body: SafeArea(
        child: widget.child,
      ),
    );
  }
}