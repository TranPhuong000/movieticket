  // Map<String, dynamic>? userData;
  // @override
  // void initState() {
  //   super.initState();
  //   _loadUserData();
  // }




//   Future<void> _loadUserData() async {
//     final data = await getUserData();
//     print(data!['accessToken']);
//     setState(() {
//       userData = data;
//     });
//   }


//  body: userData != null
//           ? Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Tài khoản: ${userData!['taiKhoan']}'),
//                   Text('Họ tên: ${userData!['hoTen']}'),
//                   Text('Email: ${userData!['email']}'),
//                   Text('AccessToken: ${userData!['accessToken']}'),

//                   // Các thông tin khác
//                 ],
//               ),
//             )
//           : const Center(child: CircularProgressIndicator()),


// Future<Map<String, dynamic>?> getUserData() async {
//   final prefs = await SharedPreferences.getInstance();
//   final userDataString = prefs.getString('userData');
//   if (userDataString != null) {
//     return jsonDecode(userDataString);
//   }
//   return null;
// }


