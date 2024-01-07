// overview_order.dart
import 'package:bitz/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class OverviewOrderPage extends StatelessWidget {
  const OverviewOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Overview Order',
        onDeleteTap: () {
          // TODO: Delete the current item & go back to home screen
        },
      ),
      body: SingleChildScrollView(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [],
      ),
    );
  }
}
