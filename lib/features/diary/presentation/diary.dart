import 'package:christian_app/features/appbar.dart';
import 'package:christian_app/features/diary/data/diary.dart';
import 'package:christian_app/features/diary/presentation/diary-list.dart';
import 'package:christian_app/features/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:christian_app/features/diary/data/diary_database.dart';
import 'package:provider/provider.dart';
import 'package:christian_app/features/diary/presentation/diary-item.dart';
import 'package:intl/intl.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  int _currentIndex = 2;
  final textController = TextEditingController();
  final titleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readDiarys()
        .then((value) => print('Diary opened'))
        .catchError((err) => print('Error: $err'));
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      List routes = ['/home', '/map', '/diary', '/verse'];

      Navigator.of(context, rootNavigator: true).popAndPushNamed(routes[index]);
    });
  }

  void createDiary() {
    DateTime dateTime = DateTime.now();

    final dateFormatter = DateFormat('yyyy-MM-dd');
    final timeFormatter = DateFormat('HH:mm:ss');

    final formattedDate = dateFormatter.format(dateTime);
    final formattedTime = timeFormatter.format(dateTime);

    final dateToday = '$formattedDate $formattedTime';
    print(dateToday);

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(
                child: Title(
                    color: const Color.fromARGB(255, 40, 38, 52),
                    child: Text('Add To Diary')),
              ),
              content: SizedBox(
                height: 150.0,
                child: Column(
                  children: [
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.title_sharp),
                              hintText: 'What is the title for today? :)',
                              labelText: 'Title *',
                            )),
                        TextFormField(
                            controller: textController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.edit_outlined),
                              hintText: 'What happened?',
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
                    context.read<DiaryDatabase>().addDiary(
                        titleController.text, textController.text, dateToday);

                    textController.clear();
                    titleController.clear();

                    Navigator.pop(context);
                  },
                  child: Text('Create'),
                )
              ],
            ));
  }

  Future<void> readDiarys() async {
    await context.read<DiaryDatabase>().fetchDiary();
  }

  @override
  Widget build(BuildContext context) {
    final diaryDatabase = context.watch<DiaryDatabase>();
    List currentDiary = diaryDatabase.currentDiary;
    currentDiary = currentDiary.reversed.toList();

    return Scaffold(
      appBar: appbar(context),
      bottomNavigationBar: navbar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      body: Column(
        children: [
          Text(
            'Diary',
            style: GoogleFonts.lobster(
                textStyle: TextStyle(
                    fontSize: 40.0,
                    color: const Color.fromARGB(255, 40, 38, 52))),
          ),
          FloatingActionButton(
            onPressed: createDiary,
            child: Icon(Icons.add_sharp),
          ),
          SizedBox(
            height: 22.0,
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 10.0, color: Colors.white),
                itemCount: currentDiary.length,
                itemBuilder: (context, index) {
                  final diary = currentDiary[index];
                  return DiaryItem(
                    date: diary.date,
                    title: diary.title,
                    text: diary.text,
                    index: index,
                  );
                }),
          ),
        ],
      ),
    );
  }
}


 

// read diarys
