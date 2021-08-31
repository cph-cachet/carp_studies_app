part of carp_study_app;

abstract class MessageManager {
  Future<void> init();
  Future<List<Message>> get messages;
}

class LocalMessageManager implements MessageManager {
  Future<void> init() async {
    info('$runtimeType initialized');
  }

  //TODO - messages should be fetched on a regular basis - daily / hourly?
  Future<List<Message>> get messages async => [
        // Message(
        //   type: MessageType.announcement,
        //   title: 'Study overview',
        //   subTitle: '',
        //   message: 'Click here to get a preview of the WristAngel Study',
        //   url: 'https://docdro.id/rk21nkz',
        // ),
        Message(
          type: MessageType.article,
          title: 'Study Overview',
          subTitle: 'Duration of participation: 9 weeks',
          message:
              "Biosensor wristband: \n\nWe will ask children / adolescents and parents to wear an biosensor on their arm for up to 9 weeks at home, at school, at work, for sports, etc. The bracelet measures heart rate, sweat, movement, skin temperature and time. It is taken off at bedtime and charged overnight and put on again the next morning.\n\nThe wristband can store 60 hours of data. Therefore, we will meet up to 2 times a week to make room for data on the bracelet. These meetings can take place in the clinic or at your home. When you stop participation in the project, the biosensor must be returned.\n\n\nQuestionnaires:\n\nWe will also ask the child/youth and parent to answer various questionnaires. We will send an email to ebox with a link to the questionnaires. They are about emotions, family life, quality of life, and functioning in everyday life. We will ask children / youth to answer some web-based questionnaires twice: 1. at the beginning and 2. end of the course. Parents are asked to answer questionnaires three times: 1. at the beginning, 2. midway and 3. at the end of the study.\n\n\nWhen should we meet at the clinic: \n\nDuring the study period, we will ask children/youth and parents to participate in various assessments with the researchers in the clinic at the beginning and end of the study.",
          imagePath: 'assets/images/park.png',
        ),
        Message(
            type: MessageType.announcement,
            title: 'Reminder',
            subTitle: 'Here are some tips',
            message:
                "In this app you will be assigned a series of tasks to be solved. The different tasks are assigned with different frequencies. Some are assigned each day, some multiple times a day and some only once a week. Therefore, it is a good idea to check the app for new tasks each day.\n\n\nFor some of the tasks it is possible to record your answer. It is optional to record your answer. However, an answer should be submitted by either a recording or text.")
        // Message(
        //   type: MessageType.article,
        //   title: 'The importance of healthy eating',
        //   subTitle: '',
        //   message: 'A healthy diet is essential for good health and nutrition. '
        //       'It protects you against many chronic noncommunicable diseases, such as heart disease, diabetes and cancer. '
        //       'Eating a variety of foods and consuming less salt, sugars and saturated and industrially-produced trans-fats, are essential for healthy diet.\n\n'
        //       'A healthy diet comprises a combination of different foods. These include:\n\n'
        //       ' - Staples like cereals (wheat, barley, rye, maize or rice) or starchy tubers or roots (potato, yam, taro or cassava).\n'
        //       ' - Legumes (lentils and beans).\n'
        //       ' - Fruit and vegetables.\n'
        //       ' - Foods from animal sources (meat, fish, eggs and milk).\n\n'
        //       'Here is some useful information, based on WHO recommendations, to follow a healthy diet, and the benefits of doing so.',
        //   url: 'https://www.who.int/initiatives/behealthy/healthy-diet',
        // ),
      ];
}
