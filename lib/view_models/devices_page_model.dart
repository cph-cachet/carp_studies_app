part of carp_study_app;

class DevicesPageViewModel extends ViewModel {
  DevicesPageViewModel();

  /// The list of scanned bluetooth devices.

  List<BluetoothDevice> get devices => BluetoothDatum().scanResult;
  Stream<Datum> get scanDevices => Stream.fromFuture(BluetoothProbe().getDatum());

  // Get an icon for the device based on its type.  If there is no icon for the device, use a default icon

}
