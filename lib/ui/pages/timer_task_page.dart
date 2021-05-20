part of carp_study_app;

// class TimerTaskPage extends StatefulWidget {
//   @override
//   _TimerTaskPageState createState() => _TimerTaskPageState();
// }

// class _TimerTaskPageState extends State<TimerTaskPage> {
//   final CountdownController _controller = new CountdownController();

//   int currentStep = 0;
//   List<int> steps = [0, 1, 2, 3, 4, 5, 6, 7];

//   final interval = const Duration(seconds: 1);
//   final int timerMaxSeconds = 60 * 5;
//   int currentSeconds = 0;

//   String get timerText =>
//       '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')} : ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

//   startTimeout([int milliseconds]) {
//     var duration = interval;
//     Timer.periodic(duration, (timer) {
//       setState(() {
//         currentSeconds = timer.tick;
//         if (timer.tick >= timerMaxSeconds) {
//           timer.cancel();
//           setState(() {
//             currentStep += 1;
//           });
//           print(currentStep);
//           _stepSelector(currentStep);
//         }
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget _stepSelector(int step) {
//     switch (step) {
//       case 0:
//         return _stepOne();
//       case 1:
//         return _question();
//       case 2:
//         // startTimeout();
//         return _timer();
//       case 3:
//         return _question();
//       case 4:
//         startTimeout();
//         return _timer();
//       case 5:
//         return _question();
//       case 6:
//         startTimeout();
//         return _timer();
//       case 5:
//         return _question();
//       case 6:
//         return _end();
//       default:
//         return SizedBox.shrink();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => _showCancelConfirmationDialog(),
//       child: Scaffold(
//         body: Container(
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           child: _stepSelector(currentStep),
//         ),
//       ),
//     );
//   }

//   Widget _header() {
//     RPLocalizations locale = RPLocalizations.of(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         IconButton(
//           icon: Icon(Icons.help_outline, color: Theme.of(context).primaryColor, size: 30),
//           tooltip: locale.translate('Help'),
//           onPressed: () {
//             print("Help");
//             // TODO: show help
//           },
//         ),
//         //Carousel
//         Expanded(
//           flex: 2,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: steps.asMap().entries.map(
//               (step) {
//                 var index = step.value;
//                 return Container(
//                   width: 7.0,
//                   height: 7.0,
//                   margin: EdgeInsets.symmetric(horizontal: 6.0),
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: index <= currentStep
//                           ? Theme.of(context).primaryColor
//                           : Theme.of(context).primaryColor.withOpacity(0.5)),
//                 );
//               },
//             ).toList(),
//           ),
//         ),

//         IconButton(
//           icon: Icon(Icons.close, color: Theme.of(context).primaryColor, size: 30),
//           tooltip: locale.translate('Close'),
//           onPressed: () {
//             print("close");
//             _showCancelConfirmationDialog();
//           },
//         ),
//       ],
//     );
//   }

//   // Counter in seconds
//   Widget _timer() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         SizedBox(height: 35),
//         _header(),
//         SizedBox(height: 35),
//         Image(image: AssetImage('assets/images/timer.png'), width: 220, height: 220),
//         SizedBox(height: 20),
//         _countdown(timerMaxSeconds)
//         // Text(timerText, style: timerStyle.copyWith(color: Theme.of(context).primaryColor)),
//       ],
//     );
//   }

//   Widget _countdown(int seconds) {
//     return Countdown(
//       controller: _controller,
//       seconds: seconds,
//       build: (_, double time) {
//         int auxMinutes = (time / 60).truncate();
//         String auxSeconds = (time % 60).toInt().toString();
//         return Text(
//           '$auxMinutes:$auxSeconds',
//           style: TextStyle(
//             fontSize: 100,
//           ),
//         );
//       },
//       interval: Duration(milliseconds: 100),
//       onFinished: () {
//         print('Timer is done!');
//         setState(() {
//           currentStep += 1;
//         });
//         _stepSelector(currentStep);
//       },
//     );
//   }

//   void updateResult(RPTaskResult result) {
//     // Do whatever you want with the result
//     // In this case we are just printing the result's keys
//     print(result.results.keys);
//   }

//   Widget _question() {
//     bool flag = false;
//     if (flag == false) {
//       return SurveyTaskRoute();
//     }
//     setState(() {
//       currentStep += 1;
//     });
//     _stepSelector(currentStep);
//     flag = true;
//     return SizedBox.shrink();
//   }

//   Widget _end() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         SizedBox(height: 35),
//         _header(),
//         SizedBox(height: 35),
//         Image(image: AssetImage('assets/images/timer_task.png'), width: 220, height: 220),
//         SizedBox(height: 20),
//         Text('THIS THE END', style: timerStyle.copyWith(color: Theme.of(context).primaryColor)),
//         Expanded(
//           child: Align(
//             alignment: FractionalOffset.bottomRight,
//             child: Padding(
//               padding: EdgeInsets.only(bottom: 10.0),
//               child: ButtonTheme(
//                 minWidth: 70,
//                 child: FlatButton(
//                     color: Theme.of(context).primaryColor,
//                     padding: EdgeInsets.all(10.0),
//                     child: Text(
//                       "NEXT",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         currentStep += 1;
//                       });
//                       print(currentStep);
//                       _stepSelector(currentStep);
//                     }),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Widget _stepOne() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         SizedBox(height: 35),
//         _header(),
//         SizedBox(height: 35),
//         Image(image: AssetImage('assets/images/timer_task.png'), width: 220, height: 220),
//         SizedBox(height: 40),
//         Text('Title', style: audioTitleStyle),
//         SizedBox(height: 10),
//         Text(
//             "In this exercise you will have to answer a question. Once answered, a timer will start. You will then be asked the same question every X minutes. You can't answer the next question before the timer allows it\n\n",
//             style: audioDescriptionStyle),
//         Expanded(
//           child: Align(
//             alignment: FractionalOffset.bottomRight,
//             child: Padding(
//               padding: EdgeInsets.only(bottom: 10.0),
//               child: ButtonTheme(
//                 minWidth: 70,
//                 child: FlatButton(
//                     color: Theme.of(context).primaryColor,
//                     padding: EdgeInsets.all(10.0),
//                     child: Text(
//                       "NEXT",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         currentStep += 1;
//                       });
//                       print(currentStep);
//                       _stepSelector(currentStep);
//                     }),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   // Taken from RP
//   Future _showCancelConfirmationDialog() {
//     RPLocalizations locale = RPLocalizations.of(context);
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(locale.translate("Discard results and quit?")),
//           actions: <Widget>[
//             FlatButton(
//               child: Text(locale.translate("NO")),
//               onPressed: () => Navigator.of(context).pop(), // Dismissing the pop-up
//             ),
//             FlatButton(
//               child: Text(locale.translate("YES")),
//               onPressed: () {
//                 // Calling the onCancel method with which the developer can for e.g. save the result on the device.
//                 // Only call it if it's not null
//                 //widget.onCancel?.call(_taskResult);
//                 // Popup dismiss
//                 Navigator.of(context).pop();
//                 // Exit the Ordered Task
//                 Navigator.of(context).pop();
//               },
//             )
//           ],
//         );
//       },
//     );
//   }
// }
