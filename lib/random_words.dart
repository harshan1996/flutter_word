import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:english_words/english_words.dart';


class RandomWords extends StatefulWidget{
  const RandomWords({super.key});

  @override
  RandomWordsState createState()=> RandomWordsState();
}

class RandomWordsState extends State <RandomWords>{

  final _randomWordPairs=<WordPair>[];
  final _savedWordPairs= <WordPair>{};

  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, item){
        if (item.isOdd){
          return const Divider();
        }
        final index= item ~/2;

        if (index>=_randomWordPairs.length){
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair){

    final alreadySaved=_savedWordPairs.contains(pair);

    return ListTile(title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18,fontStyle: FontStyle.italic,color: Colors.black)),
    // Icon widget
    trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,color: alreadySaved? Colors.red: null),
    onTap: (){
      setState(() {
        if (alreadySaved){
          _savedWordPairs.remove(pair);
        }
        else{
          _savedWordPairs.add(pair);
        }
      });
    });
  }

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable <ListTile> tiles=
          _savedWordPairs.map((WordPair pair){
            return ListTile(
              title: Text(pair.asPascalCase,style: const TextStyle(
                fontWeight: FontWeight.bold,fontSize: 18
              ),)
            );
          });

          final List <Widget> divided= ListTile.divideTiles(context: context,
          tiles:tiles).toList();

          return Scaffold(
            // backgroundColor: const Color.fromARGB(255, 173, 220, 220),
            appBar: AppBar(
              title: const Text('Saved Items',style: TextStyle(fontWeight: FontWeight.bold),),
              backgroundColor: Colors.blue,
            ),
            body: ListView(children: divided),
          );

        })
      );

  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 235, 12, 8),
        title: const Center(child: Text('Main Page',style: TextStyle(fontWeight: FontWeight.bold))),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved ,
          )
        ],
      ),
      body: _buildList()
    );
  }

}





// home: Scaffold(
//   appBar: AppBar(title: const Text('My Home page'),
//   backgroundColor: Colors.blue,
//   ),
//   body: Center( child: Text(randomWord.asPascalCase))

// )

// children: <Widget>[
//     Container(
//       height: 50,
//       color: Colors.amber[600],
//       child: const Center(child: Text('Entry A')),
//     ),
//     Container(
//       height: 50,
//       color: Colors.amber[500],
//       child: const Center(child: Text('Entry B')),
//     ),
//     Container(
//       height: 50,
//       color: Colors.amber[100],
//       child: const Center(child: Text('Entry C')),
//     ),
//   ];

