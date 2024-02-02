import 'package:flutter/material.dart';

import 'add_permintaan_widget.dart';

class AddFloatingButtonWidget extends StatelessWidget {
  const AddFloatingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) {
            return const AddPermintaanWidget();
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
