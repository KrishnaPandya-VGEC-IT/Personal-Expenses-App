import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget
{
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction>
{
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData(String title, var Amount,BuildContext context)
  {
    if(title=="")
      {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please all Enter values!"),
              duration: Duration(seconds: 2),)
        );
        return;
      }
    else if(double.tryParse(Amount)==null)
      {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:Text("Amount should be value.(Kutrya sala dekh k number dial kar!Bevkuf sala.)"),
            duration: Duration(seconds: 4),));
        return;
      }
    else if(_selectedDate == null)
    {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Date to choose karo, beta Goli!"),
            duration: Duration(seconds: 2),)
      );
      return;
    }
    else if(double.parse(Amount)<=0) // Amount.runtimeType != double
      {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Negative Amount not Possible.(Kutrya sala dekh k amount dial kar.)"),
          duration: Duration(seconds: 4),
        ));
        return;
      }
    else if(double.parse(Amount)>1000000000)
      {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Beta Aukat me reh k value add karo'),
        duration: Duration(seconds: 2),));
        return;
      }
    widget.addTx(title,double.parse(Amount),_selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker()
  {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime.now()).then((value)
    {
      if(value == null)
        {
          return;
        }
      else
        {
          setState(() {
            _selectedDate = value;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.only(bottom: 90),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted:  (_)
                {
                  _submitData(_titleController.text,_amountController.text,context);
                }
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                 Text(_selectedDate == null?'No Date Chosen!': 'Picked Date : ${DateFormat.yMMMd().format(_selectedDate)}'),
                 RaisedButton(
                   color: Colors.purple,
                     textColor: Colors.white,
                     onPressed: (){
                        _datePicker();
                     }, child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),))
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Colors.purple,
              textColor: Colors.white,
              onPressed: () => _submitData(_titleController.text,_amountController.text,context),
            ),
          ],
        ),
      ),
    );
  }
}
