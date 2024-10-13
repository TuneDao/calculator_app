import 'package:bloc/bloc.dart';
import 'package:calculator_app/bloc/calculator.state.dart';
import 'package:equatable/equatable.dart';
import 'calculator_event.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorState()) {
    on<NumberPressed>(_onNumberPressed);
    on<OperatorPressed>(_onOperatorPressed);
    on<ClearPressed>(_onClearPressed);
    on<DeletePressed>(_onDeletePressed);
    on<CalculateResultPressed>(_onCalculateResultPressed);
    on<ConvertToPercentagePressed>(_onConvertToPercentagePressed);
  }

  void _onNumberPressed(NumberPressed event, Emitter<CalculatorState> emit) {
    if (state.operand.isEmpty) {
      emit(state.copyWith(number1: state.number1 + event.number));
    } else {
      emit(state.copyWith(number2: state.number2 + event.number));
    }
  }

  void _onOperatorPressed(
      OperatorPressed event, Emitter<CalculatorState> emit) {
    if (state.number1.isNotEmpty && state.operand.isEmpty) {
      emit(state.copyWith(operand: event.operator));
    }
  }

  void _onClearPressed(ClearPressed event, Emitter<CalculatorState> emit) {
    emit(const CalculatorState());
  }

  void _onDeletePressed(DeletePressed event, Emitter<CalculatorState> emit) {
    if (state.number2.isNotEmpty) {
      emit(state.copyWith(
          number2: state.number2.substring(0, state.number2.length - 1)));
    } else if (state.operand.isNotEmpty) {
      emit(state.copyWith(operand: ''));
    } else if (state.number1.isNotEmpty) {
      emit(state.copyWith(
          number1: state.number1.substring(0, state.number1.length - 1)));
    }
  }

  void _onCalculateResultPressed(
      CalculateResultPressed event, Emitter<CalculatorState> emit) {
    if (state.number1.isEmpty || state.operand.isEmpty || state.number2.isEmpty)
      return;

    double num1 = double.parse(state.number1);
    double num2 = double.parse(state.number2);
    double result = 0.0;

    switch (state.operand) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '×':
        result = num1 * num2;
        break;
      case '÷':
        result = num1 / num2;
        break;
    }

    emit(state.copyWith(
      result: result.toString(),
      number1: result.toString(),
      operand: '',
      number2: '',
    ));
  }

  void _onConvertToPercentagePressed(
      ConvertToPercentagePressed event, Emitter<CalculatorState> emit) {
    if (state.number1.isNotEmpty && state.operand.isEmpty) {
      double num1 = double.parse(state.number1);
      emit(state.copyWith(
        result: (num1 / 100).toString(),
        number1: (num1 / 100).toString(),
        operand: '',
        number2: '',
      ));
    }
  }
}
