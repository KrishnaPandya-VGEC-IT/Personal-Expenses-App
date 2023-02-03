import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/chart.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses App",
      // theme: ThemeData(
      //   primarySwatch: Colors.purple,
      // ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget
{
  // String titleInput;
  // String amountInput;
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: 't1', title: 'Gaming mouse', price: 19.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'Groceries', price: 50.00, date: DateTime.now()),
  ];

  List<Transaction>get _recentTransactions
  {
    return _userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days:7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime chosenDate)
  {
    final Transaction newTx = new Transaction(id: DateTime.now().toString(), title: title, price: amount, date: chosenDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id)
  {
      setState(() {
        _userTransaction.removeWhere((transaction)
        {
          return transaction.id == id;
        });
      });
  }

  void _startAddNewTransaction(BuildContext context)
  {
    showModalBottomSheet(context: context, builder: (_) {
      return NewTransaction(_addTransaction);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple,
      accentColor: Colors.amber,
      fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(headline1: TextStyle(fontFamily: 'OpenSans',fontSize: 20, fontWeight: FontWeight.bold)),),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline1: TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold, fontSize: 18),
          button: TextStyle(color: Colors.white),
          ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Personal Expenses App"),
          actions: [
            IconButton(icon: Icon(Icons.add), onPressed: () => _startAddNewTransaction(context),),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(_recentTransactions),
              TransactionList(_userTransaction, _deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat ,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ),
    );
  }
}
