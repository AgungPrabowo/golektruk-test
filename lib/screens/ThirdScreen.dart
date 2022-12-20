import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golektruk_test/bloc/third/third_cubit.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final _formKeyA = GlobalKey<FormState>();
  final _formKeyB = GlobalKey<FormState>();
  final operandList = ["+", "-", "x", "/"];

  @override
  Widget build(BuildContext context) {
    snackBar(String msg) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
    }

    buildFormCalc(
      String title,
      GlobalKey<FormState> formKey,
      BuildContext ctx,
      List<QuestionClass> question,
      String answer,
      String operand, {
      bool showDeleteBtn = false,
    }) {
      return Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: question
                      .map(
                        (e) => Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: e.ctrl,
                                readOnly: !e.isCheck,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (e.isCheck) {
                                    int? parseInteger = int.tryParse(value!);
                                    if (value.isEmpty)
                                      return "Nilai tidak boleh kosong";
                                    else if (parseInteger == null)
                                      return "Nilai tidak valid";
                                    else
                                      return null;
                                  } else
                                    return null;
                                },
                                decoration: new InputDecoration(
                                  labelText: "Masukan Nilai",
                                ),
                                onChanged: (String? value) {
                                  final idx = question.indexOf(e);
                                  if (showDeleteBtn) {
                                    ctx
                                        .read<ThirdCubit>()
                                        .onChangeValueB(value ?? "", idx);
                                  } else {
                                    ctx
                                        .read<ThirdCubit>()
                                        .onChangeValueA(value ?? "", idx);
                                  }
                                },
                              ),
                            ),
                            Checkbox(
                              value: e.isCheck,
                              onChanged: (bool? value) {
                                final idx = question.indexOf(e);
                                if (showDeleteBtn) {
                                  ctx
                                      .read<ThirdCubit>()
                                      .onCheckB(value ?? false, idx);
                                } else {
                                  ctx
                                      .read<ThirdCubit>()
                                      .onCheckA(value ?? false, idx);
                                }
                              },
                            ),
                            if (showDeleteBtn)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                onPressed: () {
                                  final idx = question.indexOf(e);
                                  ctx.read<ThirdCubit>().removeField(idx);
                                },
                                child: Text("Hapus"),
                              )
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 12),
              if (showDeleteBtn)
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ctx.read<ThirdCubit>().addField();
                      },
                      child: Text("Tambah Field"),
                    ),
                  ],
                ),
              SizedBox(height: 8),
              Row(
                children: operandList
                    .map(
                      (e) => Flexible(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(e),
                          leading: Radio<String>(
                            value: e,
                            groupValue: operand,
                            onChanged: (String? value) {
                              if (showDeleteBtn) {
                                ctx
                                    .read<ThirdCubit>()
                                    .onChangeRadioB(value ?? "");
                              } else {
                                ctx
                                    .read<ThirdCubit>()
                                    .onChangeRadioA(value ?? "");
                              }
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (operand.isEmpty)
                    snackBar("Operand tidak boleh kosong");
                  else {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(ctx).unfocus();
                      final listValue =
                          question.where((e) => e.value.isNotEmpty);
                      final isZeroExist =
                          listValue.any((e) => int.parse(e.value) * 1 == 0);
                      if (isZeroExist && operand == "/")
                        snackBar("Operand pembagian tidak boleh ada nilai 0");
                      else {
                        final fieldSelected =
                            question.where((e) => e.isCheck).length;
                        if (fieldSelected > 1) {
                          if (showDeleteBtn)
                            ctx.read<ThirdCubit>().countB();
                          else
                            ctx.read<ThirdCubit>().countA();
                        } else
                          snackBar("Minimal field terpilih 2");
                      }
                    }
                  }
                },
                child: Text("Hitung"),
              ),
              SizedBox(height: 24),
              if (answer.isNotEmpty)
                Text(
                  "Hasil : Kalkulasi $operand = $answer",
                ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Soal Ketiga"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: BlocProvider(
              create: (context) => ThirdCubit(),
              child: BlocBuilder<ThirdCubit, ThirdState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      buildFormCalc(
                        "A",
                        _formKeyA,
                        context,
                        state.questionA,
                        state.answerA,
                        state.operandA,
                      ),
                      buildFormCalc(
                        "B.",
                        _formKeyB,
                        context,
                        state.questionB,
                        state.answerB,
                        state.operandB,
                        showDeleteBtn: true,
                      )
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
