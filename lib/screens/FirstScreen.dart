import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golektruk_test/bloc/first/first_cubit.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soal Pertama"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: BlocProvider(
            create: (context) => FirstCubit(),
            child: BlocBuilder<FirstCubit, FirstState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _ctrlInput,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          int? parseInteger = int.tryParse(value!);
                          if (value.isEmpty)
                            return "Jumlah Hari tidak boleh kosong";
                          else if (value == "0")
                            return "Minimal Jumlah Hari 1";
                          else if (parseInteger != null && parseInteger > 365)
                            return "Maksimal Jumlah Hari 365";
                          else if (parseInteger == null)
                            return "Jumlah Hari tidak valid";
                          else
                            return null;
                        },
                        decoration: new InputDecoration(
                          labelText: "Masukan Jumlah Hari",
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          final input = _ctrlInput.text;
                          context.read<FirstCubit>().count(int.parse(input));
                        }
                      },
                      child: Text("Hitung"),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.total,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
