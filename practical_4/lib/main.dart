import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const EMICalculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EMICalculator extends StatefulWidget {
  const EMICalculator({super.key});

  @override
  State<EMICalculator> createState() => _EMICalculatorState();
}

class _EMICalculatorState extends State<EMICalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _loanTenureController = TextEditingController();

  double _emi = 0.0;
  double _totalAmount = 0.0;
  double _totalInterest = 0.0;
  bool _isCalculated = false;

  @override
  void dispose() {
    _loanAmountController.dispose();
    _interestRateController.dispose();
    _loanTenureController.dispose();
    super.dispose();
  }

  void _calculateEMI() {
    if (_formKey.currentState!.validate()) {
      final double principal = double.parse(_loanAmountController.text);
      final double annualRate = double.parse(_interestRateController.text);
      final int tenureMonths = int.parse(_loanTenureController.text);

      // Convert annual interest rate to monthly rate
      final double monthlyRate = (annualRate / 100) / 12;

      // EMI Formula: P * r * (1 + r)^n / ((1 + r)^n - 1)
      // Where P = Principal, r = monthly interest rate, n = number of months
      
      if (monthlyRate == 0) {
        // If interest rate is 0, EMI is just principal divided by tenure
        _emi = principal / tenureMonths;
      } else {
        final double emiNumerator = principal * monthlyRate * pow(1 + monthlyRate, tenureMonths);
        final double emiDenominator = pow(1 + monthlyRate, tenureMonths) - 1;
        _emi = emiNumerator / emiDenominator;
      }

      _totalAmount = _emi * tenureMonths;
      _totalInterest = _totalAmount - principal;

      setState(() {
        _isCalculated = true;
      });
    }
  }

  void _resetCalculator() {
    _loanAmountController.clear();
    _interestRateController.clear();
    _loanTenureController.clear();
    setState(() {
      _emi = 0.0;
      _totalAmount = 0.0;
      _totalInterest = 0.0;
      _isCalculated = false;
    });
  }

  String _formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EMI Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loan Details',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _loanAmountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Loan Amount (₹)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.currency_rupee),
                          hintText: 'Enter loan amount',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter loan amount';
                          }
                          if (double.tryParse(value) == null || double.parse(value) <= 0) {
                            return 'Please enter a valid amount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _interestRateController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Interest Rate (% per annum)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.percent),
                          hintText: 'Enter interest rate',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter interest rate';
                          }
                          if (double.tryParse(value) == null || double.parse(value) < 0) {
                            return 'Please enter a valid interest rate';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _loanTenureController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Loan Tenure (months)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_month),
                          hintText: 'Enter tenure in months',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter loan tenure';
                          }
                          if (int.tryParse(value) == null || int.parse(value) <= 0) {
                            return 'Please enter a valid tenure';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _calculateEMI,
                      icon: const Icon(Icons.calculate),
                      label: const Text('Calculate EMI'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _resetCalculator,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              if (_isCalculated) ...[
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EMI Calculation Results',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildResultRow('Monthly EMI:', _formatCurrency(_emi), Icons.payment),
                        const Divider(),
                        _buildResultRow('Total Amount Payable:', _formatCurrency(_totalAmount), Icons.account_balance_wallet),
                        const Divider(),
                        _buildResultRow('Total Interest:', _formatCurrency(_totalInterest), Icons.trending_up),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Loan Summary',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSummaryColumn('Principal', _formatCurrency(double.parse(_loanAmountController.text)), Colors.blue),
                            _buildSummaryColumn('Interest', _formatCurrency(_totalInterest), Colors.orange),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value: double.parse(_loanAmountController.text) / _totalAmount,
                          backgroundColor: Colors.orange.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                          minHeight: 8,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Principal vs Interest Ratio',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green.shade700, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryColumn(String title, String amount, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
