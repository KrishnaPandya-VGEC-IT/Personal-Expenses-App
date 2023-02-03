import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {


  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectDate;

  void _submitData()
  {
    if(_amountController.text.isEmpty)
      {
        return;
      }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount<=0 || _selectDate == null)
    {
        return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker()
  {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now()).then((pickedDate)
    {
      if(pickedDate == null)
        {
          return;
        }
      else
        {
          setState(() {
            _selectDate = pickedDate;
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name of Product'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                  decoration: InputDecoration(labelText: 'Price'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                  onChanged: (value) {} //=> amountInput = value,
              ),
              Container(
                height: 70,
                child: Row(children: [
                  Expanded(child: Text(_selectDate == null? 'No Date Chosen' : 'Picked Date : ${DateFormat.yMd().format(_selectDate)}')),
                  FlatButton(
                      textColor: Colors.purple,
                      onPressed: _presentDatePicker, child: Text('Choose date',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),))
                ],),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    onPressed: _submitData,
                      color: Colors.purple,
                      child: Text(
                      'Add Transaction',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
