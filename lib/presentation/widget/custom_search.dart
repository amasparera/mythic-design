// import 'dart:core';

// import 'package:flutter/material.dart';

// class CustomSearch extends SearchDelegate {
//   List<String> listSearch = [
//     "apple",
//     "banana",
//     "pear",
//     "orange",
//     "berry",
//     "jambu",
//     "anggur",
//     "sirsak"
//   ];

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             query = "";
//           },
//           icon: Icon(Icons.clear))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           close(context, null);
//         },
//         icon: Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> mactQuery = [];

//     for (var fruit in listSearch) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         mactQuery.add(fruit);
//       }
//     }

//     return ListView.builder(
//       itemCount: mactQuery.length,
//       itemBuilder: (context, index) => ListTile(
//         title: Text(mactQuery[index]),
//       ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> mactQuery = [];

//     for (var fruit in listSearch) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         mactQuery.add(fruit);
//       }
//     }

//     return ListView.builder(
//       itemCount: mactQuery.length,
//       itemBuilder: (context, index) => ListTile(
//         title: Text(mactQuery[index]),trailing: Icon(Icons.abc),
//       ),
//     );
//   }A
// }
