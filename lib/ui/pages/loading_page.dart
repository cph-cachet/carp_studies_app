// part of carp_study_app;

// // class LoadingPage extends StatefulWidget {
// //   _LoadingPageState createState() => new _LoadingPageState();
// // }

// // class _LoadingPageState extends State<LoadingPage> {

// class LoadingPage extends StatelessWidget {
//   /// This methods is used to set up the entire app, including:
//   ///  * initialize the bloc
//   ///  * authenticate the user
//   ///  * get the invitation
//   ///  * get the informed consent
//   ///  * get the study
//   ///  * initialize sensing
//   ///  * start sensing
//   Future<bool> initialize(BuildContext context) async {
//     // initialize the bloc, setting the deployment mode:
//     //  * LOCAL
//     //  * CARP_STAGGING
//     //  * CARP_PRODUCTION
//     await bloc.initialize(DeploymentMode.LOCAL);

//     // this is done in order to test the entire onboarding flow
//     // TODO - remove when done testing
//     await bloc.leaveStudyAndSignOut();

//     //  initialize the CARP backend, if needed
//     if (bloc.deploymentMode != DeploymentMode.LOCAL) {
//       await bloc.backend.initialize();
//       await bloc.backend.authenticate(context);
//       await bloc.backend.getStudyInvitation(context);
//     }

//     // TODO - at this point, the localization should be fetched before showing the informed consent

//     // find the right informed consent, if needed
//     bloc.informedConsent = (!bloc.hasInformedConsentBeenAccepted)
//         ? await bloc.resourceManager.getInformedConsent()
//         : null;

//     await bloc.messageManager.init();
//     await bloc.getMessages();
//     await Sensing().initialize();

//     print(toJsonString(bloc.deployment));

//     // initialize the data models
//     bloc.data.init(Sensing().controller);

//     debug('$runtimeType initializing done.');

//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: initialize(context),
//         builder: (context, snapshot) => (!snapshot.hasData)
//             ? Scaffold(
//                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                 body: Center(
//                     child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [CircularProgressIndicator()],
//                 )))
//             : Scaffold(
//                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                 body: (bloc.shouldInformedConsentBeShown)
//                     ? InformedConsentPage()
//                     : HomePage(),
//               ));
//   }

//   // TODO - Not used right now - should we?
//   Widget get _splashImage => Container(
//         decoration: new BoxDecoration(
//           image: new DecorationImage(
//             image: new AssetImage("assets/images/splash_background.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: new Center(
//             child: new Hero(
//           tag: "tick",
//           child: new Image.asset('assets/images/splash_cachet.png',
//               width: 150.0, height: 150.0, scale: 1.0),
//         )),
//       );
// }
