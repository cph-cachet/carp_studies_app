part of carp_study_app;

class LocalMessages {
  static final message1 = Message(
    type: MessageType.announcement,
    title: 'New update coming soon',
    subTitle: '',
    message:
        'Minor bug fixes has been implemented. To enjoy the latest and fastest version please update it.',
  );
  static final message2 = Message(
    type: MessageType.article,
    title: 'The importance of healthy eating',
    subTitle: '',
    message: 'A healthy diet is essential for good health and nutrition.'
        'It protects you against many chronic noncommunicable diseases, such as heart disease, diabetes and cancer. Eating a variety of foods and consuming less salt, sugars and saturated and industrially-produced trans-fats, are essential for healthy diet.'
        'A healthy diet comprises a combination of different foods. These include:'
        'Staples like cereals (wheat, barley, rye, maize or rice) or starchy tubers or roots (potato, yam, taro or cassava).'
        'Legumes (lentils and beans).'
        'Fruit and vegetables.'
        'Foods from animal sources (meat, fish, eggs and milk).'
        'Here is some useful information, based on WHO recommendations, to follow a healthy diet, and the benefits of doing so.',
    url: 'https://www.who.int/initiatives/behealthy/healthy-diet',
  );
}
