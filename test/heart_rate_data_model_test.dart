import 'exports.dart';

@GenerateMocks([
  SmartphoneDeploymentController,
  PolarHRDatum,
  DataPoint,
  HeartRateCardViewModel
])
void main() {
  setUp(() {});

  test("Checks object type of HeartRateCardViewModel class.", () {
    // Create a new instance of the HeartRateCardViewModel class
    HeartRateCardViewModel viewModel = HeartRateCardViewModel();

    // Use the isA function to check the type of the viewModel object
    expect(viewModel, isA<HeartRateCardViewModel>());

  });
}