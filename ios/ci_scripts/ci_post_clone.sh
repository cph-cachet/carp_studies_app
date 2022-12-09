#!/bin/sh

# The default execution directory of this script is the ci_scripts directory.
cd $CI_WORKSPACE # change working directory to the root of your cloned repo.

HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
# Install Flutter using git.
# git clone https://github.com/flutter/flutter.git --depth 1 -b stable $HOME/flutter
# export PATH="$PATH:$HOME/flutter/bin"
brew install flutter

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios

# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
brew install cocoapods


# Install CocoaPods dependencies.
cd ios && pod install # run `pod install` in the `ios` directory.

echo "ls Pods-Runnner"
ls -la Pods/Target\ Support\ Files/

exit 0