import 'package:flutter/material.dart';

import '../../../utils/app_styles.dart';

class FailedWidget extends StatelessWidget {
  const FailedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber,color: Colors.redAccent,),
            Text(
              'Something Wrong',
              style: AppStyles.whiteBold14,
            ),
          ],
        ),
      ),
    );
  }
}
