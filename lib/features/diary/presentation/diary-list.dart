// import 'package:salvation/features/diary/presentation/diary-item.dart';
// import 'package:flutter/material.dart';

// class DiaryList extends StatefulWidget {
//   const DiaryList({super.key});

//   @override
//   State<DiaryList> createState() => _DiaryListState();
// }

// class _DiaryListState extends State<DiaryList> {
//   List<Map> diaryList = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.separated(
//           separatorBuilder: (context, index) =>
//               const Divider(thickness: 10.0, color: Colors.white),
//           itemCount: diaryList.length,
//           itemBuilder: (context, index) {
//             return DiaryItem(
//                 date: diaryList[index]["date"],
//                 title: diaryList[index]["title"],
//                 text: diaryList[index]["text"]);
//           }),
//     );
//   }
// }
