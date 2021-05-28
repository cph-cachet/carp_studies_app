part of carp_study_app;

abstract class MessageManager {
  Future<void> init();
  Future<List<Message>> get messages;
}

class LocalMessageManager implements MessageManager {
  Future<void> init() {
    info('$runtimeType initialized');
  }

  //TODO - messages should be fetched on a regular basis - daily / hourly?
  Future<List<Message>> get messages async => [
        Message(
          type: MessageType.announcement,
          title: 'Study overview',
          subTitle: '',
          message: 'Click here to get a preview of the WristAngel Study',
          url: 'https://docdro.id/rk21nkz',
        ),
        Message(
          type: MessageType.announcement,
          title: 'New update coming soon',
          subTitle: '',
          message:
              'Minor bug fixes has been implemented. To enjoy the latest and fastest version please update it.',
        ),
        Message(
          type: MessageType.article,
          title: 'The importance of healthy eating',
          subTitle: '',
          message: 'A healthy diet is essential for good health and nutrition. '
              'It protects you against many chronic noncommunicable diseases, such as heart disease, diabetes and cancer. '
              'Eating a variety of foods and consuming less salt, sugars and saturated and industrially-produced trans-fats, are essential for healthy diet.\n\n'
              'A healthy diet comprises a combination of different foods. These include:\n\n'
              ' - Staples like cereals (wheat, barley, rye, maize or rice) or starchy tubers or roots (potato, yam, taro or cassava).\n'
              ' - Legumes (lentils and beans).\n'
              ' - Fruit and vegetables.\n'
              ' - Foods from animal sources (meat, fish, eggs and milk).\n\n'
              'Here is some useful information, based on WHO recommendations, to follow a healthy diet, and the benefits of doing so.',
          url: 'https://www.who.int/initiatives/behealthy/healthy-diet',
        ),
      ];
}
