import 'exports.dart';

@GenerateNiceMocks([
  MockSpec<SmartphoneDeploymentController>(),
  MockSpec<HeartRateCardViewModel>(),
  MockSpec<PolarHRDatum>(),
  MockSpec<DataPoint>(),
  MockSpec<DataPointHeader>(),
  MockSpec<HourlyHeartRate>(),
])
void main() {
  setUp(() {});
  group("HeartRateCardViewModel tests", () {
    test('initializes HeartRateCardViewModel', () {
      // final controller = MockSmartphoneDeploymentController();
      // final model = MockHeartRateCardViewModel();
      // when(model.createModel()).thenReturn(model);

      // final viewModel = HeartRateCardViewModel();
      // viewModel.init(controller);

      // verify(model.createModel());
    });

    test('description', () {
      final mockSmartphoneDeploymentController =
          MockSmartphoneDeploymentController();
      final mockPolarHRDatum = MockPolarHRDatum();
      final mockDataPoint = MockDataPoint();
      final mockHourlyHeartRate = MockHourlyHeartRate();
      final viewModel = HeartRateCardViewModel();

      viewModel.init(mockSmartphoneDeploymentController);

      final heartRateStreamController = StreamController<DataPoint>();
      // Set the heart rate events stream to the stream controller
      when(mockSmartphoneDeploymentController.data).thenAnswer((_) => heartRateStreamController.stream);

      // Add a heart rate data point to the stream
      heartRateStreamController.add(mockDataPoint);


      // // Test the 'currentHeartRate' getter
      // when(mockSmartphoneDeploymentController
      //         .dataByType(PolarSamplingPackage.POLAR_HR))
      //     .thenAnswer((_) => Stream.fromIterable(
      //         [mockDataPoint]));
      // when(mockSmartphoneDeploymentController.data)
      //     .thenAnswer((_) => Stream.value(mockDataPoint));
      when(mockDataPoint.data).thenReturn(mockPolarHRDatum);
      when(mockPolarHRDatum.hr).thenReturn(80);
      when(mockPolarHRDatum.contactStatusSupported).thenReturn(false);

      // verify(viewModel.init(mockSmartphoneDeploymentController));
      // verify(viewModel.model.addHeartRate);

      expect(
          viewModel.currentHeartRate, 80); //TODO: fix this test, has to be 80

          heartRateStreamController.close();
    });
  });
  group('HourlyHeartRate', () {
    test('resetDataAtMidnight', () {
      // create an HourlyHeartRate object with some data
      HourlyHeartRate hr = HourlyHeartRate();
      hr.hourlyHeartRate[12] = HeartRateMinMaxPrHour(70, 80);
      hr.hourlyHeartRate[13] = HeartRateMinMaxPrHour(75, 85);
      hr.maxHeartRate = 85;
      hr.minHeartRate = 70;
      hr.lastUpdated = DateTime(
          2022, 1, 1, 23, 59, 59); // last updated at 11:59:59 PM on Jan 1, 2022

      // call resetDataAtMidnight
      hr.resetDataAtMidnight();

      // verify that the data was reset
      expect(hr.hourlyHeartRate[12], HeartRateMinMaxPrHour(null, null));
      expect(hr.hourlyHeartRate[13], HeartRateMinMaxPrHour(null, null));
      expect(hr.maxHeartRate, null);
      expect(hr.minHeartRate, null);
      expect(hr.lastUpdated.day, DateTime.now().day);
    });

    test('addHeartRate', () {
      HourlyHeartRate hr = HourlyHeartRate();

      hr.addHeartRate(12, 75);
      hr.addHeartRate(12, 70);
      hr.addHeartRate(12, 80);
      hr.addHeartRate(13, 75);
      hr.addHeartRate(13, 80);
      hr.addHeartRate(13, 85);

      expect(hr.hourlyHeartRate[12], HeartRateMinMaxPrHour(70, 80));
      expect(hr.hourlyHeartRate[13], HeartRateMinMaxPrHour(75, 85));
    });

    test('addHeartRate with invalid input', () {
      HourlyHeartRate hr = HourlyHeartRate();

      expect(() => hr.addHeartRate(-1, 75), throwsA(isA<AssertionError>()));
      expect(() => hr.addHeartRate(24, 75), throwsA(isA<AssertionError>()));
    });

    test('resetDataAtMidnight at other times of day', () {
      HourlyHeartRate hr = HourlyHeartRate();
      hr.hourlyHeartRate[12] = HeartRateMinMaxPrHour(70, 80);
      hr.hourlyHeartRate[13] = HeartRateMinMaxPrHour(75, 85);
      hr.maxHeartRate = 85;
      hr.minHeartRate = 70;
      hr.lastUpdated = DateTime.now();

      hr.resetDataAtMidnight();

      expect(hr.hourlyHeartRate[12], HeartRateMinMaxPrHour(70, 80));
      expect(hr.hourlyHeartRate[13], HeartRateMinMaxPrHour(75, 85));
      expect(hr.maxHeartRate, 85);
      expect(hr.minHeartRate, 70);
      expect(hr.lastUpdated.day, DateTime.now().day);
    });
  });
}

class MockSerializableViewModel extends Mock implements SerializableViewModel {}

SerializableViewModel restore() {
  var viewModel = MockSerializableViewModel();
  when(viewModel.restore).thenReturn(() async => HourlyHeartRate());

  return viewModel;
}
