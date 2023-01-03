import 'exports.dart';

@GenerateNiceMocks([
  MockSpec<SmartphoneDeploymentController>(),
  MockSpec<HeartRateCardViewModel>(),
  MockSpec<PolarHRDatum>(),
  MockSpec<DataPoint>()
])
void main() {
  setUp(() {});

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

    final viewModel = HeartRateCardViewModel();

    when(mockSmartphoneDeploymentController.data)
        .thenAnswer((_) => Stream.fromIterable([mockDataPoint]));

    viewModel.init(mockSmartphoneDeploymentController);

    // Test the 'currentHeartRate' getter
    when(mockSmartphoneDeploymentController
            .dataByType(PolarSamplingPackage.POLAR_HR))
        .thenAnswer((_) => Stream.fromIterable([mockDataPoint]));
    when(mockDataPoint.data).thenReturn(mockPolarHRDatum);
    when(mockPolarHRDatum.hr).thenReturn(80);
    when(mockPolarHRDatum.contactStatusSupported).thenReturn(false);

    expect(viewModel.currentHeartRate, null);
  });
}
