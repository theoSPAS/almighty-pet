import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);
  static const routeName = '/message';

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final _formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerMessage = TextEditingController();

  Widget buildTextField(String title, TextEditingController controller,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          maxLines: maxLines,
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        )
      ],
    );
  }

  Future sendEmail(String name, String email, String message) async {
    final serviceId ='service_eujavok';
    final templateId = 'template_w9vu4bc';
    final userId = 'zaOJJXkdx-MnmfZfO';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_message': message,
        }
      }),
    );
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('AlmightyPet'),
        ),
        body: Center(
          child: Container(
            height: 450,
            width: 400,
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                      spreadRadius: 1,
                      color: Colors.grey[300]!)
                ]),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Contact Us',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: controllerName,
                    decoration: const InputDecoration(hintText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controllerEmail,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Required*';
                      } else if (!email.contains('@')) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: controllerMessage,
                    decoration: const InputDecoration(hintText: 'Message'),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 45,
                    width: 110,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: const Color(0xff151534),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await sendEmail(
                              controllerName.value.text,
                              controllerEmail.value.text,
                              controllerMessage.value.text);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(response == 200
                                  ? const SnackBar(
                                      content: Text('Message Sent!'),
                                      backgroundColor: Colors.green,
                                    )
                                  : const SnackBar(
                                      content: Text('Failed to send message!'),
                                      backgroundColor: Colors.red,
                                    ));
                          controllerName.clear();
                          controllerEmail.clear();
                          controllerMessage.clear();
                        }
                      },
                      child: const Text('Send', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
