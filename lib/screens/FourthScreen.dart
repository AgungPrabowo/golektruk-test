import 'package:flutter/material.dart';

class FourthScreen extends StatefulWidget {
  const FourthScreen({Key? key}) : super(key: key);

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class _FourthScreenState extends State<FourthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlName = TextEditingController();
  final _ctrlEmail = TextEditingController();
  final _ctrlAge = TextEditingController();
  final _ctrlPhone = TextEditingController();
  final _ctrlEducation = TextEditingController();

  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soal Keempat"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _ctrlName,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "Nama tidak boleh kosong";
                        else if (value.length < 5)
                          return "Min 5 karakter";
                        else
                          return null;
                      },
                      decoration: new InputDecoration(
                        labelText: "Nama",
                      ),
                    ),
                    TextFormField(
                      controller: _ctrlEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "Email tidak boleh kosong";
                        if (!value.isValidEmail())
                          return "Email tidak valid";
                        else
                          return null;
                      },
                      decoration: new InputDecoration(
                        labelText: "Email",
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      value: gender,
                      hint: Text("Jenis Kelamin"),
                      onChanged: (value) => setState(() => gender = gender),
                      validator: (value) => value == null
                          ? 'Jenis Kelamin tidak boleh kosong'
                          : null,
                      items: ['Pria', 'Wanita']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      controller: _ctrlAge,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        int? parseInteger = int.tryParse(value!);
                        if (value.isEmpty)
                          return "Umur tidak boleh kosong";
                        else if (parseInteger == null)
                          return "Umur tidak valid";
                        else if (parseInteger < 10)
                          return "Minimal 10";
                        else if (parseInteger > 100)
                          return "Maksimal 100";
                        else
                          return null;
                      },
                      decoration: new InputDecoration(
                        labelText: "Umur",
                      ),
                    ),
                    TextFormField(
                      controller: _ctrlPhone,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "No Telepon tidak boleh kosong";
                        else if (value.length < 9)
                          return "Minimal 9 Karakter";
                        else if (value.length > 14)
                          return "Maksimal 14 Karakter";
                        else
                          return null;
                      },
                      decoration: new InputDecoration(
                        labelText: "No Telepon",
                      ),
                    ),
                    TextFormField(
                      controller: _ctrlEducation,
                      validator: (value) {
                        if (value!.length < 5 && value.isNotEmpty)
                          return "Min 5 karakter";
                        else
                          return null;
                      },
                      decoration: new InputDecoration(
                        labelText: "Pendidikan",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
