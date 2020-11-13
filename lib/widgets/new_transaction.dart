import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _transactionDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
          setState(() {
            _transactionDate = pickedDate;
          });
    });
  }

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.tryParse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount == null || enteredAmount <= 0) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount, _transactionDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (value) => _title = value,
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                // onChanged: (value) => _amount = value,
                controller: amountController,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Text(_transactionDate == null
                        ? 'Not Date Chosen!'
                        : DateFormat('dd/MM/yyyy').format(_transactionDate)),
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Choose date...',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  'Add Transaction',
                ),
                onPressed: _submitData,
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ));
  }
}
