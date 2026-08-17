import 'package:flutter/material.dart';
import 'package:workshop6_185/models/note.dart';
import 'package:workshop6_185/repository/note_repository.dart';
import 'package:workshop6_185/screens/widgts/item_note.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;
  const AddNoteScreen({super.key, required this.note});


  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _title.text = widget.note!.title;
      _description.text = widget.note!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        actions: [
          widget.note !=null
            ? IconButton(
              onPressed:() {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    content: 
                      const Text("คุณต้องการจะลบข้อมูลใช่หรือไม่"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _deleteNote();
                            },
                            child: const Text("Yes"),
                            )
                      ],
                  ) );
              } ,
            
             icon: (const Icon(Icons.delete_outline)), 
             )
             : const SizedBox(),


          IconButton(
            onPressed: widget.note == null ? _inserNote : _updateNote , 
            icon: const Icon(Icons.done_outline_rounded))
        ],
      ),
      body: Padding(padding: const EdgeInsetsGeometry.all(15),
      child: Column(
        children: [
          TextField(
            controller: _title,
            decoration: InputDecoration(
              hintText: "Title" ,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
            ),
          ),
          const SizedBox(height: 15,),
          Expanded(
            child: TextField(
              controller: _description,
            decoration: InputDecoration(
              hintText: "Start typing here..." ,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
          ),
          maxLines: 50,
          ),
          )
        ],
      ),
      
      ),
    );
  }
  _inserNote() async{
    final note = Note(
      title: _title.text,
      description: _description.text,
      createdAt: DateTime.now(),
    );
    await NoteRepository.insert(note: note);
  }
  
  _updateNote() async {
    final note = Note(
      id: widget.note!.id,
      title: _title.text,
      description: _description.text,
      createdAt: widget.note!.createdAt,
      );
      await NoteRepository.update(note: note);
  }
  _deleteNote() async {
    NoteRepository.delete(note: widget.note!).then((e) {
      Navigator.pop(context);
    });
  }
  }

