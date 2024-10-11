import 'package:calculator_app/Button/button_values.dart';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String number1 = ""; // 0-9
  String operand = ""; // +, -, *, /,
  String number2 = ""; // 0-9

  String get output =>
      "$number1$operand$number2".isEmpty ? "0" : "$number1$operand$number2";

  void calculate() {
    if (number1.isEmpty || operand.isEmpty || number2.isEmpty) return;
    double num1 = double.parse(number1);
    double num2 = double.parse(number2);
    var result = 0.0;
    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
    }
    number1 = "$result";
    if (number1.endsWith(".0")) {
      number1 = number1.substring(0, number1.length - 2);
    }
    operand = "";
    number2 = "";
    notifyListeners();
  }

  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  void convertToPercentage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      // final res = number1 operand number2
      // number1 = res; trả ra kq và gán vào number1 để hiển thị
      calculate();
    }
    if (operand.isNotEmpty) {
      return;
    }
    final number = double.parse(number1);

    number1 = "${(number / 100)}";
    operand = "";
    number2 = "";
    notifyListeners();
  }

  void clearAll() {
    number1 = "";
    operand = "";
    number2 = "";
    notifyListeners();
  }

  void delete() {
    if (number2.isNotEmpty) {
      // 12314141 =>1231414 when press delete
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    notifyListeners();
  }

  void appendValue(String value) {
    // number1, operand, number2
    // operand and not "."
    if (value != Btn.dot && int.tryParse(value) == null) {
      //operand press
      if (operand.isNotEmpty && number2.isNotEmpty) {
        //
        calculate();
      }
      operand = value;
    }
    // assign value to number1 variable
    else if (number1.isEmpty || operand.isEmpty) {
      // check if value is "."
      // ex: number1 = "2.1"
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && number1.isEmpty || number1 == Btn.n0) {
        // ex: number1 = ""|"0"
        value = "0.";
      }
      number1 += value;
    }
    // assign value to number2 variable
    else if (number2.isEmpty || operand.isNotEmpty) {
      // check if value is "."| ex: number2 = "2.1"
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && number2.isEmpty || number2 == Btn.n0) {
        // number2 = ""|"0"
        value = "0.";
      }
      number2 += value;
    }

    notifyListeners();
  }

  Color getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.blueGrey
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate
          ].contains(value)
            ? Colors.orange
            : Colors.black87;
  }
}
