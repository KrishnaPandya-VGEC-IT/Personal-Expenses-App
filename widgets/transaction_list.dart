import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;
  TransactionList(this.transactions,this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 425,
      child: transactions.length == 0
          ? Column(
              children: [
                Text(
                  'Topa Transactions to add kar!Beta goli',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // Expanded(child: Image.asset('assets/images/waiting.png',width: 300,height: 300,)),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$ ${transactions[index].amount}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))),
                      ),
                    ),
                    title: Text(transactions[index].title,style: Theme.of(context).textTheme.headline1,),
                    subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(icon: Icon(Icons.delete),color: Theme.of(context).errorColor,
                    onPressed: () => _deleteTransaction(transactions[index].id),),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}

//first alternative in itembuilder

/*
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$ ${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(transactions[index].title,style: Theme.of(context).textTheme.title,),
                    subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),

                  ),
                );
*/



//second alternative in itembuilder
/*
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      // color: Colors.orangeAccent,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$${transactions[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      // color: Colors.orangeAccent,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                      // style: TextStyle(
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
*/
