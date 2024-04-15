import 'package:attach_club/models/connection_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Fire extends StatefulWidget {
  const Fire({super.key});

  @override
  State<Fire> createState() => _FireState();
}

class _FireState extends State<Fire> {
  final fromController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: fromController,
              decoration: const InputDecoration(
                hintText: "From",
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: "From Phone No.",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final currentUser = FirebaseAuth.instance.currentUser;
                final db = FirebaseFirestore.instance;
                final request = ConnectionRequest(
                  phoneNo: phoneController.text,
                  status: "Received",
                  updateTime: "5 April 2024 at 17:12:56 UTC+5:30",
                  uid: fromController.text,
                );
                if (currentUser != null) {
                  await db
                      .collection("users")
                      .doc(currentUser.uid)
                      .collection("requests")
                      .doc(fromController.text)
                      .set(request.toMap());

                  final sentRequest = ConnectionRequest(
                    phoneNo: phoneController.text,
                    status: "Sent",
                    updateTime: "5 April 2024 at 17:12:56 UTC+5:30",
                    uid: currentUser.uid,
                  );
                  await db
                      .collection("users")
                      .doc(fromController.text)
                      .collection("requests")
                      .doc(currentUser.uid)
                      .set(sentRequest.toMap());
                }
              },
              child: const Text(
                "Send Request",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
