import 'package:flutter/material.dart';
import 'package:sample_project/widgets/chart.dart';
import 'package:sample_project/widgets/new_transaction.dart';
import 'package:sample_project/widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(headline1: TextStyle(fontFamily: 'OpenSans',fontWeight: FontWeight.bold,fontSize: 18)),
        appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(headline1: TextStyle(fontFamily: 'OpenSans',fontSize: 20,fontWeight: FontWeight.bold)),)
        // appBarTheme: AppBarTheme(
        //   color: Colors.purple,
        // ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction>get _recentTransactions
  {
    return _userTransactions.where((element)
    {
      return element.date.isAfter(DateTime.now().subtract(Duration(days:7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) {
      return SingleChildScrollView(child: NewTransaction(_addNewTransaction));
    });
  }

  void _deleteTransaction(String id)
  {
    setState(() {
      _userTransactions.removeWhere((element)
      {
          return element.id == id;
      });
    });
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Kishan Personal Expenses'),
          actions: [
            IconButton(icon: Icon(Icons.add), onPressed: () {
              _startAddNewTransaction(context);
            })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10,bottom: 10,left: 30,right: 30),
                child: Text('Last 7 days expenses',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
              ),
              Container(
                width: double.infinity,
                child: Chart(_userTransactions),
                // child: Card(
                //   color: Colors.blue,
                //   child: Text('CHART!'),
                //   elevation: 5,
                // ),
              ),
              TransactionList(_recentTransactions, _deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: () {
          _startAddNewTransaction(context);
        }),
      );
    }
  }
