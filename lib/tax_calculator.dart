import 'package:flutter/material.dart';

class TaxaImposto extends StatefulWidget {
  const TaxaImposto({super.key, required this.title});

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _TaxaImpostoState createState() => _TaxaImpostoState();
}

class _TaxaImpostoState extends State<TaxaImposto> {
  String _info = 'Informe o salário';
  double _salary = 0.0;
  double _tax = 0.0;
  double _netSalary = 0.0;

  TextEditingController salaryController = TextEditingController();

  void _resetFields() {
    salaryController.text = '';
    setState(() {
      _info = "Informe o salário.";
      _tax = 0.0;
      _netSalary = 0.0;
    });
  }

  void _calculateTax() {
    setState(() {
      if (salaryController.text.isEmpty) {
        _info = 'Por favor, preencha o salário.';
        return;
      }
      _salary = double.parse(salaryController.text);

      if (_salary < 1257.12) {
        _tax = 0;
      } else if (_salary < 2510) {
        _tax = _salary * 0.17;
      } else {
        _tax = _salary * 0.28;
      }

      _netSalary = _salary - _tax;

      _info = 'Imposto: R\$ ${_tax.toStringAsFixed(2)}\nSalário Líquido: R\$ ${_netSalary.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Salário do funcionário',
              ),
              controller: salaryController,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                _info,
                style: TextStyle(
                  color: _tax > 0 ? Colors.green : Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 22),
                  ),
                  onPressed: _calculateTax,
                  child: const Text('Calcular'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 22),
                  ),
                  onPressed: _resetFields,
                  child: const Text('Limpar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
