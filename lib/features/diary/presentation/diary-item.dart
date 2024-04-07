import 'package:flutter/material.dart';
import 'package:salvation/features/diary/presentation/diary.dart';
import 'package:salvation/features/diary/data/diary.dart';
import 'package:salvation/features/diary/data/diary_database.dart';
import 'package:provider/provider.dart';

class DiaryItem extends StatefulWidget {
  final String date;
  final String title;
  final String text;
  final int index;

  DiaryItem(
      {required this.date,
      required this.title,
      required this.text,
      required this.index});

  @override
  State<DiaryItem> createState() => _DiaryItemState();
}

class _DiaryItemState extends State<DiaryItem> {
  final textController = TextEditingController();

  final titleController = TextEditingController();

  void updateDiary(diary diary) {
    textController.text = diary.text;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(
                child: Title(
                    color: const Color.fromARGB(255, 40, 38, 52),
                    child: Text('Update Diary')),
              ),
              content: SizedBox(
                height: 150.0,
                child: Column(
                  children: [
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                            controller: textController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.edit_outlined),
                              hintText: 'Update your text',
                              labelText: 'Text *',
                            )),
                      ],
                    ))
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context
                        .read<DiaryDatabase>()
                        .updateDiary(diary.id, textController.text);

                    textController.clear();
                    titleController.clear();

                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                )
              ],
            ));
  }

  void deleteDiary(int id) {
    context.read<DiaryDatabase>().deleteDiary(id);
  }

  @override
  Widget build(BuildContext context) {
    final diaryDatabase = context.watch<DiaryDatabase>();
    List currentDiary = diaryDatabase.currentDiary;
    currentDiary = currentDiary.reversed.toList();

    final diary = currentDiary[widget.index];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          print(widget.text);
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.2),
          borderRadius: BorderRadius.circular(15), //<-- SEE HERE
        ),
        tileColor: Colors.grey[700],
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.bookmark,
              color: Colors.grey,
            ),
          ],
        ),
        isThreeLine: true,
        subtitle: Text(
          """${widget.text}
      ${widget.date}""",
          style: TextStyle(color: Color.fromARGB(255, 222, 222, 222)),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit_note),
              color: Colors.cyan,
              onPressed: () {
                updateDiary(diary);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.redAccent,
              onPressed: () {
                deleteDiary(diary.id);
              },
            ),
          ],
        ),
      ),
    );
    ;
  }
}
