import 'exports.dart';

@GenerateMocks([SmartphoneDeploymentController, PolarHRDatum, DataPoint])
void main() {
  setUp(() {});

  test('description', () {
    final mockSmartphoneDeploymentController =
        MockSmartphoneDeploymentController();
    final mockPolarHRDatum = MockPolarHRDatum();
    final mockDataPoint = MockDataPoint();

    final viewModel = HeartRateCardViewModel();

    when(mockSmartphoneDeploymentController.data).thenAnswer((_) => Stream.fromIterable([mockDataPoint]));

    viewModel.init(mockSmartphoneDeploymentController);

    // Test the 'currentHeartRate' getter
    when(mockSmartphoneDeploymentController
            .dataByType(PolarSamplingPackage.POLAR_HR))
        .thenAnswer((_) => Stream.fromIterable([mockDataPoint]));
    when(mockDataPoint.data).thenReturn(mockPolarHRDatum);
    when(mockPolarHRDatum.hr).thenReturn(80);
    when(mockPolarHRDatum.contactStatusSupported).thenReturn(false);

    expect(viewModel.currentHeartRate, 80);
  });
}
