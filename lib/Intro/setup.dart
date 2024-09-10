// import 'package:flutter/material.dart';
// import 'package:gymapp/login/login_screen.dart';
// import '../navbar.dart';
// import 'package:gymapp/data/api.dart';
//
// class Setup extends StatefulWidget {
//   final int userId;
//
//   Setup({required this.userId});
//   // Cập nhật constructor
//   @override
//   _SetupState createState() => _SetupState();
// }
//
// class _SetupState extends State<Setup> {
//   PageController _controller = PageController();
//   int _currentPage = 0;
//   bool _isIcon1Selected = false;
//   bool _isIcon2Selected = false;
//   String _selectedGender = ""; // Lưu giới tính được chọn
//   String _selectedMucTieu = ""; // Thêm biến này để lưu mục tiêu
//
//   int _selectedButtonIndex = -1;
//   int _selectedAgeIndex = 12;
//   int _selectedWeightIndex = 50;
//   int _selectedHeightIndex = 150;
//   final ApiService _apiService = ApiService(); // Thêm ApiService
//
//   ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Lắng nghe sự thay đổi vị trí cuộn của ScrollController
//     _scrollController.addListener(() {
//       // Tính index của số tuổi được chọn dựa vào vị trí cuộn
//       int index = (_scrollController.offset ~/ 100)
//           .toInt(); // Đổi tùy theo khoảng cách mà con chọn
//       setState(() {
//         _selectedAgeIndex = index;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _controller,
//         onPageChanged: (int page) {
//           setState(() {
//             _currentPage = page;
//           });
//         },
//         children: <Widget>[
//           GestureDetector(
//             onTap: () {
//               _controller.nextPage(
//                 duration: Duration(milliseconds: 400),
//                 curve: Curves.easeInOut,
//               );
//             },
//             child:
//             buildPage1(
//               imagePath: 'assets/images/Setup1.png',
//               title: 'No Pain No Gain.',
//               title2: 'Don\'t Give Up!',
//               title3: 'Kiên trì là',
//               title4: 'Chìa khóa để tiến bộ.',
//               buttonLabel: 'Tiếp Theo',
//               buttonAction: () {
//                 _controller.nextPage(
//                   duration: Duration(milliseconds: 400),
//                   curve: Curves.easeInOut,
//                 );
//               },
//             ),
//           ),
//           buildPage2(
//             imagePath: 'assets/images/Setup2.png',
//             title: 'Giới Tính Của Bạn Là Gì?',
//             title3: 'Hãy cho chúng tôi biết thêm về bạn',
//             buttonLabel: 'Tiếp Theo',
//             buttonAction: () {
//               _controller.nextPage(
//                 duration: Duration(milliseconds: 400),
//                 curve: Curves.easeInOut,
//               );
//             },
//             iconPath1: 'assets/icons/gender1.png',
//             iconPath2: 'assets/icons/gender2.png',
//           ),
//     buildPage3(
//     title: 'Mục Tiêu Của Bạn Là Gì?',
//     buttonLabel: 'Tiếp Theo',
//     buttonAction: () async {
//     try {
//     await _apiService.updateMucTieu(widget.userId, _selectedMucTieu);
//     _controller.nextPage(
//     duration: Duration(milliseconds: 400),
//     curve: Curves.easeInOut,
//     );
//     } catch (e) {
//       // Handle error
//     }
//     },
//     ),
//
//
//           buildPage4(
//             title: 'Bạn Bao Nhiêu Tuổi?',
//             buttonText: 'Tiếp Theo',
//             buttonAction: () {
//               _controller.nextPage(
//                 duration: Duration(milliseconds: 400),
//                 curve: Curves.easeInOut,
//               );
//             },
//             content: buildAgeSelection(),
//           ),
//           buildPage5(
//             title: 'Chọn Cân Nặng',
//             buttonText: 'Tiếp Theo',
//             buttonAction: () {
//               _controller.nextPage(
//                 duration: Duration(milliseconds: 400),
//                 curve: Curves.easeInOut,
//               );
//             },
//             content: buildWeightSelection(),
//           ),
//           buildPage6(
//             title: 'Chọn Chiều Cao',
//             buttonText: 'Tiếp Theo',
//             buttonAction: () {
//               _controller.nextPage(
//                 duration: Duration(milliseconds: 400),
//                 curve: Curves.easeInOut,
//               );
//             },
//             content: buildHeightSelection(),
//           ),
//
//           buildPage7(
//             title: 'Chọn Cấp Độ Bài Tập',
//             buttonLabel: 'Tiếp Theo',
//             buttonAction: () {
//               _controller.nextPage(
//                 duration: Duration(milliseconds: 400),
//                 curve: Curves.easeInOut,
//               );
//             },
//           ),
//
//           buildPage8(
//             title: 'Cập Nhật Thông Tin',
//             buttonLabel: 'Bắt Đầu',
//             buttonAction: (){
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginScreen()),
//               );
//             },
//           ),
//
//         ],
//       ),
//     );
//   }
//   Future<void> _saveGender() async {
//     if (_selectedGender.isNotEmpty) {
//       try {
//         var response = await _apiService.updateUserGender(widget.userId, _selectedGender);
//         if (response != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Gender saved successfully')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to save gender')),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error saving gender')),
//         );
//       }
//     }
//   }
//
//   Widget buildPage1({
//     required String imagePath,
//     required String title,
//     required String title2,
//     required String title3,
//     required String title4,
//     required String buttonLabel,
//     required VoidCallback buttonAction,
//   }) {
//     return Container(
//       color: Colors.black,
//       child: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: Image.asset(
//               imagePath,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Expanded(
//             flex: 5, // 50% của màn hình
//             child: Container(
//               padding: EdgeInsets.all(0.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     title,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.yellow,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     title2,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.yellow,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 50, width: 50),
//                   Container(
//                     width: MediaQuery
//                         .of(context)
//                         .size
//                         .width, // Chiều rộng bằng màn hình
//                     color: Color(0xFF44462E),
//                     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           title3,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.yellow,
//                             fontSize: 20,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           title4,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.yellow,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: buttonAction,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black.withOpacity(0.8),
//                       foregroundColor: Colors.white, // Màu chữ
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         side: BorderSide(
//                             color: Colors.white, width: 1.2), // Viền trắng
//                       ),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: 50, vertical: 15),
//                     ),
//                     child: Text(
//                       buttonLabel,
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildPage2({
//     required String imagePath,
//     required String title,
//     required String title3,
//     required String buttonLabel,
//     required VoidCallback buttonAction,
//     required String iconPath1,
//     required String iconPath2,
//   }) {
//     return Container(
//       color: Colors.black,
//       child: Column(
//         children: <Widget>[
//           SizedBox(height: 50),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 20),
//           Container(
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width, // Chiều rộng bằng màn hình
//             color: Color(0xFF44462E),
//             padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//             child: Column(
//               children: <Widget>[
//                 Text(
//                   title3,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.yellow,
//                     fontStyle: FontStyle.italic,
//                     fontSize: 20,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           Expanded(
//             child: Image.asset(
//               imagePath,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _isIcon1Selected = true;
//                     _isIcon2Selected = false;
//                     _selectedGender = "Male";
//
//                   });
//                 },
//                 child: Image.asset(
//                   iconPath1,
//                   width: _isIcon1Selected ? 100 : 70,
//                   height: _isIcon1Selected ? 100 : 70,
//                 ),
//               ),
//               SizedBox(width: 50),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _isIcon1Selected = false;
//                     _isIcon2Selected = true;
//                     _selectedGender = "Female";
//
//                   });
//                 },
//                 child: Image.asset(
//                   iconPath2,
//                   width: _isIcon2Selected ? 100 : 70,
//                   height: _isIcon2Selected ? 100 : 70,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: buttonAction,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black.withOpacity(0.8),
//               foregroundColor: Colors.white, // Màu chữ
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 side: BorderSide(color: Colors.white, width: 1.2), // Viền trắng
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//             ),
//             child: Text(
//               buttonLabel,
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//
//   Widget buildPage3({
//     required String title,
//     required String buttonLabel,
//     required VoidCallback buttonAction,
//   }) {
//     return Container(
//       color: Colors.black,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(height: 130),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.yellow,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 90),
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width, // Chiều rộng bằng màn hình
//               color: Color(0xFF44462E),
//               padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
//                 children: <Widget>[
//                   buildSelectableButton('Giảm Cân', 0),
//                   buildSelectableButton('Xây Dựng Cơ Bắp', 1),
//                   buildSelectableButton('Giữ Dáng', 2),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 120),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: ElevatedButton(
//               onPressed: buttonAction,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black.withOpacity(0.8),
//                 foregroundColor: Colors.white, // Màu chữ
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   side: BorderSide(color: Colors.white, width: 1.2), // Viền trắng
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//               ),
//               child: Text(
//                 buttonLabel,
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget buildSelectableButton(String title, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedButtonIndex = index;
//           _selectedMucTieu = title; // Cập nhật mục tiêu khi người dùng chọn
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8),
//         decoration: BoxDecoration(
//           color: _selectedButtonIndex == index ? Colors.blue : Colors.white,
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//         child: Text(
//           title,
//           style: TextStyle(
//             fontSize: 18,
//             color: _selectedButtonIndex == index ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildPage4({
//     required String title,
//     required String buttonText,
//     required VoidCallback buttonAction,
//     required Widget content,
//   }) {
//     return Container(
//       color: Colors.black,
//       child: Column(
//         children: <Widget>[
//           SizedBox(height: 200),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 150),
//           Expanded(
//             child: content,
//           ),
//           SizedBox(height: 200),
//           ElevatedButton(
//             onPressed: buttonAction,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black.withOpacity(0.8),
//               foregroundColor: Colors.white, // Màu chữ
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 side: BorderSide(color: Colors.white, width: 1.2), // Viền trắng
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//             ),
//             child: Text(
//               buttonText,
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget buildAgeSelection() {
//     // List<String> ages = ['12', '13', '14', '15', '16', '17','18', '19', '20', '21', '22', '23','24', '25', '26', '27', '28', '29','30', '31', '32', '33', '34', '35'];
//     List<String> ages = List.generate(91, (index) => (index + 10).toString());
//
//     return Container(
//       height: 70,
//       color: Color(0xFFB3A0FF),
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: ages
//               .asMap()
//               .entries
//               .map((entry) {
//             int index = entry.key;
//             String age = entry.value;
//
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedAgeIndex = index;
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: _selectedAgeIndex == index ? Colors.yellow : Colors
//                       .transparent,
//                   border: Border.all(color: Colors.black, width: 2),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   age,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
//
//   Widget buildPage5({
//     required String title,
//     required String buttonText,
//     required VoidCallback buttonAction,
//     required Widget content,
//   }) {
//     return Container(
//       color: Colors.black,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(height: 200),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 150),
//           Expanded(
//             child: content,
//           ),
//           SizedBox(height: 200),
//           ElevatedButton(
//             onPressed: buttonAction,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black.withOpacity(0.8),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 side: BorderSide(color: Colors.white, width: 1.2),
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//             ),
//             child: Text(
//               buttonText,
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget buildWeightSelection() {
//     List<String> weights = List.generate(
//         200, (index) => (index + 50).toString() + ' KG');
//
//     return Container(
//       height: 70,
//       color: Color(0xFFB3A0FF),
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: weights
//               .asMap()
//               .entries
//               .map((entry) {
//             int index = entry.key;
//             String weight = entry.value;
//
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedWeightIndex = index;
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: _selectedWeightIndex == index
//                       ? Colors.yellow
//                       : Colors.transparent,
//                   border: Border.all(color: Colors.black, width: 2),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   weight,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
//
//   Widget buildPage6({
//     required String title,
//     required String buttonText,
//     required VoidCallback buttonAction,
//     required Widget content,
//   }) {
//     return Container(
//       color: Colors.black,
//       height: 600,
//       child: Column(
//         children: <Widget>[
//           SizedBox(height: 50),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 20),
//           Expanded(
//             child: Center(child: content),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: buttonAction,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black.withOpacity(0.8),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 side: BorderSide(color: Colors.white, width: 1.2),
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//             ),
//             child: Text(
//               buttonText,
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
//
//   Widget buildHeightSelection() {
//     List<String> heights = List.generate(
//         200, (index) => (index + 150).toString() + ' CM');
//
//     return Container(
//       width: 250,
//       height: 500,
//       // Tăng chiều cao của container lên 500
//       color: Color(0xFFB3A0FF),
//       padding: EdgeInsets.symmetric(vertical: 16),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: heights
//               .asMap()
//               .entries
//               .map((entry) {
//             int index = entry.key;
//             String height = entry.value;
//
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedHeightIndex = index;
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 8),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: _selectedHeightIndex == index ? Colors.yellow : Colors
//                       .transparent,
//                   border: Border.all(color: Colors.black, width: 2),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   height,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
//
//   Widget buildPage7({
//     required String title,
//     required String buttonLabel,
//     required VoidCallback buttonAction,
//   }) {
//     return Container(
//         color: Colors.black,
//         height: 600,
//         child: Column(
//       children: <Widget>[
//         SizedBox(height: 130),
//         Text(
//           title,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 80),
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//           child: Column(
//             children: <Widget>[
//               buildSelectableButton2('Mới Bắt Đầu', 0),
//               buildSelectableButton2('Trung Bình', 1),
//               buildSelectableButton2('Nâng Cao', 2),
//             ],
//           ),
//         ),
//         SizedBox(height: 120),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: ElevatedButton(
//             onPressed: buttonAction,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black.withOpacity(0.8),
//               foregroundColor: Colors.white, // Màu chữ
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 side: BorderSide(color: Colors.white, width: 1.2), // Viền trắng
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//             ),
//             child: Text(
//               buttonLabel,
//               style: TextStyle(fontSize: 18),
//             ),
//           ),
//         ),
//       ],
//     ),
//     );
//   }
//
//   Widget buildSelectableButton2(String text, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedButtonIndex = index;
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10),
//         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//         decoration: BoxDecoration(
//           color: _selectedButtonIndex == index ? Colors.yellow : Colors.white,
//           border: Border.all(color: Color(0xFF896CFE), width: 1.2),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Color(0xFF896CFE),
//             fontSize: 18,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
//
//   Widget buildPage8({required String title, required String buttonLabel, required VoidCallback buttonAction}) {
//     return Container(
//       color: Colors.black,
//       padding: const EdgeInsets.all(16.0),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 60),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 60),
//             Container(
//               width: double.infinity,
//               height: 150,
//               color: Color(0xFF896CFE),
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.purple,
//                         shape: BoxShape.circle,
//                       ),
//                       child: CircleAvatar(
//                         radius: 48,
//                         backgroundImage: NetworkImage('https://i.pinimg.com/736x/69/6d/36/696d366c69379c5d87d17290d8182b6f.jpg'),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: GestureDetector(
//                         onTap: () {
//                           // Thêm hành động khi nhấn vào biểu tượng chỉnh sửa
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.yellow,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.edit,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             SizedBox(height: 20),
//             Text(
//               'Full name',
//               style: TextStyle(color: Color(0xFF896CFE)),
//             ),
//             SizedBox(height: 5),
//             TextField(
//               decoration: InputDecoration(
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Nickname',
//               style: TextStyle(color: Color(0xFF896CFE)),
//             ),
//             SizedBox(height: 5),
//             TextField(
//               decoration: InputDecoration(
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Email',
//               style: TextStyle(color: Color(0xFF896CFE)),
//             ),
//             SizedBox(height: 5),
//             TextField(
//               decoration: InputDecoration(
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Mobile Number',
//               style: TextStyle(color: Color(0xFF896CFE)),
//             ),
//             SizedBox(height: 5),
//             TextField(
//               decoration: InputDecoration(
//                 fillColor: Colors.white,
//                 filled: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.yellow,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: EdgeInsets.symmetric(vertical: 16),
//               ),
//               onPressed: buttonAction,
//               child: Text(
//                 buttonLabel,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }