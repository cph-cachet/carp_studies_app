# Deployment Pipelines

## Google Play - Android

## Manually (first deployment)

### How to create an app bundle

Run `flutter build appbundle --release --no-deferred-components --no-tree-shake-icons`.

### How to deploy an app for the first time

When creating a new app you have to upload the first bundle (.aab or .apk) file manually.

1. Go to [Google Play Console](https://play.google.com/console/u/0/developers/7586883457853191627/app-list).
2. Select the app you created a bundle for.
3. Select one of the releases (Production, Open Testing, Closed Testing, Internal Testing).
4. - If you have not created a track for that release yet, press **New track** and once you have done that, create a release for that track.
   - If you have created a track for that release, press **New Release**.
     - Pick an app bundle to use from the library. (There you should see the aab or apk file you uploaded in the previous step).
     - Give a name for the release and save.
5. - If you have **Managed publishing off** then you will have to manually **Send changes for review**.
     Check whether Managed publishing is turned off or on on the **Publishing overview** page.
     Once you have created a new type of Release you will see the changes under **Publishing overview**.
   - If you have **Managed publishing on** then the changes will be sent for review automatically.

## Fastlane && Github Actions

Under the `.github` folder there is a yml file called `deploy_to_google_play_store_fastlane_release.yml`

#### deploy_to_google_play_store_fastlane_release.yml

Name of the Github action and name of the run.

    name: Upload to Google Store
    run-name: ${{github.actor}} is pushing to branch and deploying to Google Store

When action is run.

    on:
        push:
            branches:
            - master

This action checks-out your repository under $GITHUB_WORKSPACE, so your workflow can access it.

    - uses: actions/checkout@v4

Setting up java version 17.

    - uses: actions/setup-java@v4
        with:
        distribution: 'adopt' # See 'Supported distributions' for available options
        java-version: '17'

Caching flutter to improve run time.

    - name: Cache Flutter
        id: cache-flutter
        uses: actions/cache@v3
        with:
        path: |
            flutter
            ~/.pub-cache
        key: flutter-${{ hashFiles('**/pubspec.lock') }}


If the caching step fails then runs the following command:

    - if: ${{ steps.cache-flutter.outputs.cache-hit != 'true' }}
        name: Install Flutter
        run: git clone https://github.com/flutter/flutter.git --depth 1 -b stable $FOLDER

Adds Flutter to PATH

    - name: Add Flutter to PATH
        run: echo "$GITHUB_WORKSPACE/flutter/bin" >> $GITHUB_PATH

If the caching step fails then runs the following command:

    - if: ${{ steps.cache-flutter.outputs.cache-hit != 'true' }}
        name: Install dependencies
        run: flutter pub get

This action downloads a prebuilt ruby and adds it to the PATH.


    # Setup Ruby, Bundler, and Gemfile dependencies
    - name: Setup Fastlane
        uses: ruby/setup-ruby@8a45918450651f5e4784b6031db26f4b9f76b251 # v1.150.0
        with:
        ruby-version: "head"
        bundler-cache: true
        working-directory: android

These commands create the `upload-keystore.jks`, `PLAY_STORE_CONFIG.json` and the `key.properties` files which are essensial for signing the app as the developer account `Copenhagen Research Platform @ DTU Health Tech`. These files contain variables saved as secrets in the Github repo.

    - name: Configure Keystore
        run: |
        echo "$PLAY_STORE_UPLOAD_KEY" | base64 --decode > app/upload-keystore.jks
        echo "$PLAY_STORE_CONFIG_JSON" > PLAY_STORE_CONFIG.json
        echo "keyPassword=$KEYSTORE_KEY_PASSWORD" >> key.properties
        echo "storePassword=$KEYSTORE_STORE_PASSWORD" >> key.properties
        echo "keyAlias=$KEYSTORE_KEY_ALIAS" >> key.properties
        echo "storeFile=upload-keystore.jks" >> key.properties
        env:
        PLAY_STORE_UPLOAD_KEY: ${{ secrets.PLAY_STORE_UPLOAD_KEY }}
        KEYSTORE_KEY_ALIAS: ${{ secrets.KEYSTORE_KEY_ALIAS }}
        KEYSTORE_KEY_PASSWORD: ${{ secrets.KEYSTORE_KEY_PASSWORD }}
        KEYSTORE_STORE_PASSWORD: ${{ secrets.KEYSTORE_STORE_PASSWORD }}
        PLAY_STORE_CONFIG_JSON: ${{secrets.PLAY_STORE_CONFIG_JSON}}
        working-directory: android

This command looks for a `Fastfile` which should be located under `android/fastlane/`

    - run: fastlane release
        env:
        PLAY_STORE_JSON_KEY: PLAY_STORE_CONFIG.json
        working-directory: android



### Fastfile



    # 
    desc "Submit a new release build to Google Play's Beta track"
    lane :release do
        sh "flutter clean"
        sh "flutter pub get"
        sh "flutter pub upgrade"
        sh "flutter build appbundle --release --no-deferred-components --no-tree-shake-icons"

        upload_to_play_store(
        track: 'beta',
        aab: '../build/app/outputs/bundle/release/app-release.aab',
        )
    end
