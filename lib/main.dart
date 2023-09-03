

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './VotingProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Voting App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ChangeNotifierProvider.value(value: VotingProvider(), child: HomeScreen(),), 
    );
  }
}

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final TextEditingController valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    // ignore: avoid_print
    print('Build');
    
        final dataProvider = Provider.of<VotingProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: valueController,
                
              ),
              ElevatedButton(onPressed: (){
                if(valueController.text.isNotEmpty){
                  dataProvider.addItem(valueController.text);
                  valueController.clear();
                }
              
              }, child: const Text('Add Item'),),
              Consumer<VotingProvider>(builder: (_, data, __) => Expanded(
                child: ListView.builder(
                  itemCount: dataProvider.getData.length, 
                  itemBuilder: (_, index) =>  Card(
                    color: Colors.pink[100],
                    
                    child: ListTile(
                      onTap: (){
                        data.incVotes(index);
                      },
        
                      title: Text('${data.getData[index]['title']}', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold),), 
                      trailing: CircleAvatar(
                        child: Text('${data.getData[index]['votes']}'),
                        ),
                        ),
                  ))),),
            ],
          ),
        ),
      ),
    );
  }
}