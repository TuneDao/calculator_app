import 'package:calculator_app/Button/button_values.dart';
import 'package:calculator_app/const.dart';
import 'package:calculator_app/provider/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // lấy giá trị khung hình
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // output
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Consumer<CalculatorProvider>(
                    builder: (context, provider, child) {
                      return Text(
                        provider.output,
                        style: textOuputStyle,
                        textAlign: TextAlign.right,
                      );
                    },
                  ),
                ),
              ),
            ),
            // buttons
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                        width: value == Btn.n0
                            ? screenSize.width / 2
                            : (screenSize.width / 4),
                        height: screenSize.width / 5,
                        child: buildButton(context, value)),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String value) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
          color: provider.getBtnColor(value),
          clipBehavior: Clip.hardEdge,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: const BorderSide(color: Colors.white24)),
          child: InkWell(
              onTap: () => provider.onBtnTap(value),
              child: Center(
                  child: Text(
                value,
                style: textBtnStyle,
              )))),
    );
  }
}
