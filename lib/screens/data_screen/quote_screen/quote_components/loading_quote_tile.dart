import 'package:flutter/material.dart';
import 'package:lojong_app/common/styles.dart';

class LoadingQuoteTile extends StatelessWidget {
  const LoadingQuoteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Styles().lightGrayColor),
    );
  }
}
