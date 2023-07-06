// class EmptyScreen extends StatelessWidget {
//   const EmptyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             const Image(
//               image: AssetImage('assets/images/EmptyScreen.png'),
//             ),
//             Container(
//               padding: const EdgeInsets.all(20),
//               child: ElevatedButton(
//                 style: const ButtonStyle(
//                   backgroundColor: MaterialStatePropertyAll(Colors.black),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   'Вернуться назад',
//                   style: TextStyle(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }