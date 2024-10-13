import 'package:calculator_app/bloc/calculator.state.dart';
import 'package:calculator_app/bloc/calculator_bloc.dart';
import 'package:calculator_app/bloc/calculator_event.dart';
import 'package:calculator_app/button/button_values.dart';
import 'package:calculator_app/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreenBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => CalculatorBloc(),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Hiển thị kết quả
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(16),
                    child: BlocBuilder<CalculatorBloc, CalculatorState>(
                      builder: (context, state) {
                        return Text(
                          state.result,
                          style: textOuputStyle,
                          textAlign: TextAlign.end,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Các nút bấm
              Wrap(
                children: Btn.buttonValues.map((value) {
                  return SizedBox(
                    width: value == Btn.n0
                        ? screenSize.width / 2
                        : screenSize.width / 4,
                    height: screenSize.width / 5,
                    child: buildButton(context, value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        child: InkWell(
          onTap: () => onBtnTap(context, value),
          child: Center(child: Text(value, style: textBtnStyle)),
        ),
      ),
    );
  }

  void onBtnTap(BuildContext context, String value) {
    final bloc = context.read<CalculatorBloc>();

    if (value == Btn.del) {
      bloc.add(DeletePressed());
    } else if (value == Btn.clr) {
      bloc.add(ClearPressed());
    } else if (value == Btn.per) {
      bloc.add(ConvertToPercentagePressed());
    } else if (value == Btn.calculate) {
      bloc.add(CalculateResultPressed());
    } else if ([Btn.add, Btn.subtract, Btn.multiply, Btn.divide]
        .contains(value)) {
      bloc.add(OperatorPressed(value));
    } else {
      bloc.add(NumberPressed(value));
    }
  }

  Color getBtnColor(String value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.blueGrey
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate,
          ].contains(value)
            ? Colors.orange
            : Colors.black87;
  }
}
