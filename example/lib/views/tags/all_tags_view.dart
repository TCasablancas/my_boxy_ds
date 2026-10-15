import 'package:flutter/material.dart';
import 'package:my_boxy_ds/components/containers/mb_main_view.dart';

class AllTagsView extends StatefulWidget {

  const AllTagsView({
    super.key,
  });

  @override
  State<AllTagsView> createState() => _AllTagsViewState();
}

class _AllTagsViewState extends State<AllTagsView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MBMainView(
      viewTitle: 'AllTagsView',
      child: Center(
          child: Text('AllTagsView')
      ),
    );
  }
}