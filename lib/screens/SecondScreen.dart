import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golektruk_test/bloc/second/second_cubit.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyB = GlobalKey<FormState>();
  final _ctrlInput = TextEditingController();
  final _ctrlInputB = TextEditingController();
  final _ctrlInputBA = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soal Kedua"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: BlocProvider(
              create: (context) => SecondCubit(),
              child: BlocBuilder<SecondCubit, SecondState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "A.",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: _ctrlInput,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      int? parseInteger = int.tryParse(value!);
                                      if (value.isEmpty)
                                        return "Jumlah Tabungan tidak boleh kosong";
                                      else if (parseInteger != null &&
                                          parseInteger < 100000)
                                        return "Minimal Jumlah Tabungan 100000";
                                      else if (parseInteger == null)
                                        return "Jumlah Tabungan tidak valid";
                                      else
                                        return null;
                                    },
                                    decoration: new InputDecoration(
                                      labelText: "Masukan Jumlah Tabungan",
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    final input = _ctrlInput.text;
                                    context
                                        .read<SecondCubit>()
                                        .countA(double.parse(input));
                                  }
                                },
                                child: Text("Simpan"),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 12),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.interestA.length,
                              itemBuilder: (context, index) {
                                final item = state.interestA[index];
                                return ListTile(
                                  title:
                                      Text("Bulan ke ${index + 1} : Rp. $item"),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "B.",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Form(
                                  key: _formKeyB,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _ctrlInputB,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          int? parseInteger =
                                              int.tryParse(value!);
                                          if (value.isEmpty)
                                            return "Jumlah Tabungan tidak boleh kosong";
                                          else if (parseInteger != null &&
                                              parseInteger < 100000)
                                            return "Minimal Jumlah Tabungan 100000";
                                          else if (parseInteger == null)
                                            return "Jumlah Tabungan tidak valid";
                                          else
                                            return null;
                                        },
                                        decoration: new InputDecoration(
                                          labelText: "Masukan Jumlah Tabungan",
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _ctrlInputBA,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          int? parseInteger =
                                              int.tryParse(value!);
                                          if (value.isEmpty)
                                            return "Jumlah Bulan tidak boleh kosong";
                                          else if (parseInteger == null)
                                            return "Jumlah Bulan tidak valid";
                                          else
                                            return null;
                                        },
                                        decoration: new InputDecoration(
                                          labelText: "Masukan Jumlah Bulan",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKeyB.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    final input = _ctrlInputB.text;
                                    final month = _ctrlInputBA.text;
                                    context.read<SecondCubit>().countB(
                                        double.parse(input), int.parse(month));
                                  }
                                },
                                child: Text("Simpan"),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 12),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.interestB.length,
                              itemBuilder: (context, index) {
                                final item = state.interestB[index];
                                return ListTile(
                                  title:
                                      Text("Bulan ke ${index + 1} : Rp. $item"),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
