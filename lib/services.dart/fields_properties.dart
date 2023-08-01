import 'package:calc/bloc/calculating_bloc.dart';
import 'package:flutter/material.dart';

import 'constant_strings.dart';

class FieldsProprerties {
  static InputDecoration fieldsInputDecoration(FieldType fieldType) {
    String labelText = "";
    switch (fieldType) {
      case FieldType.amount:
        labelText = Constants.loanAmountString;
      case FieldType.interestRate:
        labelText = Constants.yearlyInterestRateString;
      case FieldType.loanTerm:
        labelText = Constants.loanTermString;
        break;
      default:
    }
    return InputDecoration(
        errorMaxLines: Constants.maxErrorLines, labelText: labelText);
  }
}
