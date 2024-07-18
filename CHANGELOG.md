## 3.0.0
- Changed bundleID (Apple) and applicationId (Google) to be dk.carp.studiesapp to remove depricated 'cachet'.

## 2.0.0

- Update to latest version of Carp Mobile Sensing (1.5.0)
- Add support for connecting to Movesense devices, collecting HR data, visualizing HR data collected
- Memove support for Apple HealthKit (temporily, due to conflict with Movesense integration)
- Support for running app in local deployment mode in order to debug a protocol before uploading it to CAWS
- Improve connection process with Bluetooth devices
- Update URLs to point to new servers
- Various bug fixes:

  - properly request permissions for `flutter_local_notifications`
  - fix some overflows, bugs, colors in UI
  - fix "Local environment" task duplication
  - fix crash related to theme
  - fix logging out/leave study dialogs appearing twice and not working.

- redesigned camera preview
- improve subtitles for task list

- changed namespace from `com.cachet.carp_studies_app` to `dk.carp.studies_app` and applicationId from `com.cachet.carp_study_app` to `dk.cachet.carp_study_app`.
- Added screenshots and string translations in Danish and English.
- Added script to see commit messages as 'What To Test' in testflight.
- Added internet connectivity checks to see if user has WiFi or Mobile Data enabled and show warning otherwise. Checks are done when logging in or logging out.
- Added Bluetooth checks to see if user has bluetooth on, show dialog otherwise.
- Migrate to new `CarpAuthService`.

## 1.4.0

- added support for collection of health data from Apple Health or Google Health Connect
- fixed a number of issues related to;
  - on-boarding flow
  - user authentication
  - using the Polar device

## 1.2.0

- fixed a bunch of issues in the app stemming from 1.1 and 1.0.

## 0.23.0

- track iOS version numbering.
- this version adds a heart rate visualization with a Polar device and created a continuous integration pipeline for iOS deployment.
- fixed some visual issues in the devices page.

## 0.40.0

- upgrade to `carp_mobile_sensing` v 0.40.0

## 0.32.1

- server-side messaging

## 0.32.0

- upgrade to `carp_mobile_sensing` v. 0.32.x
- fix of
  - <https://trello.com/c/qFZxo4Ws/110-sensing-is-not-started-on-app-restart>
  - <https://trello.com/c/eu99YxlD/108-too-much-text-in-location-pop-up-no-translation-to-danish>
  - <https://trello.com/c/8DWHufIU/105-translation-of-notifications>
- **note** that the app needs to be deleted and re-installed, if language is changed (need to download the study protocol instead of using the cached one)

## 0.21.0

- upgrade to `carp_mobile_sensing` v. 0.22.x
- support for downloading study protocol, informed consent, and localization from CARP

## 0.20.0

- upgrade to `carp_mobile_sensing` v. 0.20.x

## 0.1.0

- basic architecture
- basic UX
- support for simple sensing
- support for simple survey
