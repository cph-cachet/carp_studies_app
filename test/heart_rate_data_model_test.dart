import 'exports.dart';

@GenerateMocks([SmartphoneDeploymentController, DataPointHeader])
void main() {
  group("Test heartrate data model", () {
    test('init sets up heart rate event listener and updates model', () {
      final controller = MockSmartphoneDeploymentController();
      // Create a stream controller for the heart rate events stream
      final heartRateStreamController = StreamController<DataPoint>();
      // Set the heart rate events stream to the stream controller
      when(controller.data).thenAnswer((_) => heartRateStreamController.stream);

      // Create a view model
      final viewModel = HeartRateCardViewModel();
      // Initialize the view model with the mock controller
      viewModel.init(controller);

      // Add a heart rate data point to the stream
      heartRateStreamController.add(DataPoint(
          MockDataPointHeader(),
          PolarHRDatum("", DateTime.now().millisecondsSinceEpoch, 80, [], [],
              true, false)));

      // Verify that the model was updated with the new data
      expect(viewModel.model.currentHeartRate, 80);
      expect(viewModel.model.hourlyHeartRate[DateTime.now().hour]?.min, 80);
      expect(viewModel.model.hourlyHeartRate[DateTime.now().hour]?.max, 80);
      expect(viewModel.model.maxHeartRate, 80);
      expect(viewModel.model.minHeartRate, 80);
      expect(viewModel.contactStatus, true);

      heartRateStreamController.close();
    });

    test('resetDataAtMidnight resets data at midnight', () {
      // Create a view model
      final viewModel = HeartRateCardViewModel();
      // Set the last updated time to yesterday
      viewModel.model.lastUpdated = DateTime.now().subtract(Duration(days: 1));
      // Set some data in the model
      viewModel.model.hourlyHeartRate[0] = HeartRateMinMaxPrHour(70, 80);
      viewModel.model.maxHeartRate = 80;
      viewModel.model.minHeartRate = 70;

      // Call the resetDataAtMidnight method
      viewModel.model.resetDataAtMidnight();

      // Verify that the data was reset
      expect(viewModel.model.hourlyHeartRate[0],
          HeartRateMinMaxPrHour(null, null));
      expect(viewModel.model.maxHeartRate, null);
      expect(viewModel.model.minHeartRate, null);
    });
  });
}
