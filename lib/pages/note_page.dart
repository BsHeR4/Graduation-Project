import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myschool/models/login_model.dart';
import 'package:myschool/models/note_model.dart';
import 'package:myschool/providers/login_provider.dart';
import 'package:myschool/services/student_note_service.dart';
import 'package:myschool/widgets/custom_box.dart';
import 'package:myschool/widgets/drawer_nav.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  static String id = 'NotePage';

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    LoginModel? loginData =
        Provider.of<LoginProvider>(context, listen: false).loginData;

    return Scaffold(
        drawer: DrawerNav(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          backgroundColor: Color(0xff052659),
          title: Text(
            'Notes',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  size: 40,
                  color: Colors.white,
                )),
          ],
        ),
        body: FutureBuilder<List<StudentNoteModel>>(
            future: StudentNoteService().StudentNote( 
              token: loginData!.token,
              accept: 'application/json',
            ),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error :${snapshot.error}'));
              } else {
                List<StudentNoteModel> noteList = snapshot.data!;
                if (noteList.isNotEmpty) {
                  return RefreshIndicator(
                    child: ListView.builder(
                        itemCount: noteList.length,
                        itemBuilder: (context, index) {
                          return CustomBox(
                            content: noteList[index].content,
                            creator: noteList[index].creator,
                            dateCreated: noteList[index].dateCreated,
                          );
                        }),
                    onRefresh: () {
                      return Future.delayed(Duration(seconds: 1), () {
                        setState(() {});
                      });
                    },
                  );
                } else {
                  return RefreshIndicator(
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'assets/images/noNote.png',
                              ),
                              Text(
                                'There is no notes found',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onRefresh: () {
                      return Future.delayed(Duration(seconds: 1), () {
                        setState(() {});
                      });
                    },
                  );
                }
              }
            })));
  }
}




// FutureBuilder<List<StudentNoteModel>>(
//       future: StudentNoteService().StudentNote(
//         token: loginData!.token,
//         accept: 'application/json',
//       ),
//       builder: ((context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error :${snapshot.error}'));
//         } else {
//           List<StudentNoteModel> noteList = snapshot.data!;
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Color(0xff052659),
//               title: Text(
//                 'Notes',
//                 style: TextStyle(color: Colors.white),
//               ),
//               centerTitle: true,
//               leading: IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.menu_outlined,
//                     size: 40,
//                     color: Colors.white,
//                   )),
//               actions: [
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.notifications,
//                       size: 40,
//                       color: Colors.white,
//                     )),
//               ],
//             ),
//             body: RefreshIndicator(
//               child: ListView.builder(
//                   itemCount: noteList.length,
//                   itemBuilder: (context, index) {
//                     return CustomBox(
//                       content: noteList[index].content,
//                       creator: noteList[index].creator,
//                       dateCreated: noteList[index].dateCreated,
//                     );
//                   }),
//               onRefresh: () {
//                 return StudentNoteService().StudentNote(
//                   token: loginData.token,
//                   accept: 'application/json',
//                 );
//               },
//             ),
//           );
//         }
//       }),
//     );