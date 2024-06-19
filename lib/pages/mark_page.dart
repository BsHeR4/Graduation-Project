import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myschool/widgets/drawer_nav.dart';
import 'package:myschool/widgets/subject_mark_box.dart';

class MarkPage extends StatelessWidget {
  const MarkPage({super.key});
  static String id = 'MarkPage';
  @override
  Widget build(BuildContext context) {
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
          'Marks',
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
      body: ListView.builder(
          itemCount: 16,
          itemBuilder: (context, index) {
            return SubjectMarkBox();
          }),
    );
  }
}




//  Padding(
//         padding: const EdgeInsets.all(20),
//         child: GridView.builder(
//             clipBehavior: Clip.none,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 1.1,
//                 crossAxisSpacing: 50,
//                 mainAxisSpacing: 55),
//             itemCount: 16,
//             itemBuilder: (context, index) {
//               return SubjectMarkBox();
//             }),
//       ),