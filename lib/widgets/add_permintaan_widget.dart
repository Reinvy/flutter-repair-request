import 'package:flutter/material.dart';

import '../datasources/remote_datasources.dart';
import '../models/request_model.dart';

class AddPermintaanWidget extends StatelessWidget {
  const AddPermintaanWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final kerusakanC = TextEditingController();
    final catatanC = TextEditingController();
    return AlertDialog(
      title: const Center(child: Text("Buat Permintaan")),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Kerusakan"),
            SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: kerusakanC,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                hintText: "Kerusakan",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Field tidak boleh kosong";
                }
                return null;
              },
            ),
            SizedBox(
              height: 12,
            ),
            const Text("Catatan"),
            SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: catatanC,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                hintText: "Catatan",
                border: OutlineInputBorder(),
              ),
              minLines: 1,
              maxLines: 4,
            ),
          ],
        ),
      ),
      actions: [
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Batal"),
        ),
        FilledButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              RemoteDatasource()
                  .addRequest(
                    RequestModel(
                      id: "id",
                      permintaanPerbaikan: kerusakanC.text,
                      catatanPermintaan: catatanC.text,
                      statusPengerjaan: "Belum Dikerjakan",
                      catatanPengerjaan: "-",
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  )
                  .then(
                    (value) => RemoteDatasource().sendNotification(
                      "Permintaan Perbaikan",
                      kerusakanC.text,
                    ),
                  )
                  .then(
                    (value) => Navigator.pop(context),
                  );
            }
          },
          child: Text("Buat"),
        ),
      ],
    );
  }
}
