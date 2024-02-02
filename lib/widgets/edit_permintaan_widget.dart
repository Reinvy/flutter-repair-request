import 'package:flutter/material.dart';

import '../datasources/remote_datasources.dart';
import '../models/request_model.dart';

class EditPermintaanWidget extends StatefulWidget {
  const EditPermintaanWidget({super.key, required this.permintaan});

  final RequestModel permintaan;

  @override
  State<EditPermintaanWidget> createState() => _EditPermintaanWidgetState();
}

class _EditPermintaanWidgetState extends State<EditPermintaanWidget> {
  final formKey = GlobalKey<FormState>();
  final kerusakanC = TextEditingController();
  final catatanC = TextEditingController();

  @override
  void initState() {
    kerusakanC.text = widget.permintaan.permintaanPerbaikan;
    catatanC.text = widget.permintaan.catatanPermintaan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Buat Permintaan")),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Kerusakan"),
            const SizedBox(
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
            const SizedBox(
              height: 12,
            ),
            const Text("Catatan"),
            const SizedBox(
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
          child: const Text("Batal"),
        ),
        FilledButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              RemoteDatasource()
                  .editRequest(
                    RequestModel(
                      id: widget.permintaan.id,
                      permintaanPerbaikan: kerusakanC.text,
                      catatanPermintaan: catatanC.text,
                      statusPengerjaan: widget.permintaan.statusPengerjaan,
                      catatanPengerjaan: widget.permintaan.catatanPengerjaan,
                      createdAt: widget.permintaan.createdAt,
                      updatedAt: DateTime.now(),
                    ),
                  )
                  .then(
                    (value) => RemoteDatasource().sendNotification(
                      "Permintaan Perbaikan Baru",
                      kerusakanC.text,
                    ),
                  )
                  .then(
                (value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );
            }
          },
          child: const Text("Edit"),
        ),
      ],
    );
  }
}
