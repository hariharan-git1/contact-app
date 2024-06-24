String output = "";
String _output = "0";
double num1 = 0.0;
double num2 = 0.0;
String operand = "";

operations(String value) {
  if (value == "CLEAR") {
    _output = "0";
    num1 = 0.0;
    num2 = 0.0;
    operand = "";
  } else if (value == "+" || value == "-" || value == "/" || value == "X") {
    print(output);
    num1 = double.parse(output);
    operand = value;
    _output = "0";
  } else if (value == ".") {
    if (_output.contains(".")) {
      print("Already contains a decimal");
      return;
    } else {
      _output = _output + value;
    }
  } else if (value == "=") {
    num2 = double.parse(output);
    if (operand == "+") {
      _output = (num1 + num2).toString();
    }
    if (operand == "-") {
      _output = (num1 - num2).toString();
    }
    if (operand == "X") {
      _output = (num1 * num2).toString();
    }
    if (operand == "/") {
      _output = (num1 / num2).toString();
    }
    num1 = 0.0;
    num2 = 0.0;
    operand = "";
  } else {
    _output = _output + value;
  }

  // setState(() {
  output = double.parse(_output).toStringAsFixed(2);
  // });
}
