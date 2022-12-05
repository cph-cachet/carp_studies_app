#!/bin/sh

# The default execution directory of this script is the ci_scripts directory.
cd $CI_WORKSPACE # change working directory to the root of your cloned repo.

# Install Flutter using git.
git clone https://github.com/flutter/flutter.git --depth 1 -b stable $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios

# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods

echo "ls ios"
ls -a ios
ls a ios/.symlinks

curl https://raw.githubusercontent.com/cph-cachet/flutter-plugins/master/packages/esense_flutter/ios/esense_flutter.podspec > ios/.symlinks/plugins/esense_flutter/ios/esense_flutter.podspec

# Install CocoaPods dependencies.
cd ios && pod install # run `pod install` in the `ios` directory.

echo "ls Pods-Runnner"
ls -la Pods/Target\ Support\ Files/Pods-Runner

exit 0