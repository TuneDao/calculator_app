import 'package:equatable/equatable.dart';

class CalculatorState extends Equatable {
  final String number1;
  final String operand;
  final String number2;
  final String result;

  const CalculatorState({
    this.number1 = '',
    this.operand = '',
    this.number2 = '',
    this.result = '0',
  });

  CalculatorState copyWith({
    String? number1,
    String? operand,
    String? number2,
    String? result,
  }) {
    return CalculatorState(
      number1: number1 ?? this.number1,
      operand: operand ?? this.operand,
      number2: number2 ?? this.number2,
      result: result ?? this.result,
    );
  }

  @override
  List<Object> get props => [number1, operand, number2, result];
}
