import 'package:flutter/material.dart';
import 'package:workshop6_185/repository/note_repository.dart';
import 'package:workshop6_185/screens/add-note/add_note_screen.dart';
import 'package:workshop6_185/screens/widgts/item_note.dart';

class HomeScreen  extends StatefulWidget {
  const HomeScreen ({super.key});

  @override
  State<HomeScreen > createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen > {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Diary'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => setState(() {}),
              icon: const Icon(Icons.refresh),)
          ],
        ),

        body: FutureBuilder(
          future: NoteRepository.getNote(), 
          builder: (context, snapshort) {
            if(snapshort.connectionState == ConnectionState.done){
            if(snapshort.data == null || snapshort.data! .isEmpty) {
              return const Center(
                child: Text("Empty"),
              );
            }
          return ListView(
            padding: const EdgeInsets.all(15),
            children: [
              for (var note in snapshort.data!)
              ItemNote(note: note)
            ],
          );
        }
        return const SizedBox();
        },
      ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AddNoteScreen (note: null,)));
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor:Colors.white,
          child: const Icon(Icons.add),
          ),
          
      ),
    );
  }
}