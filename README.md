# MVImageViewer

[![Build Status](https://travis-ci.org/mvandervelden/MVImageViewer.svg?branch=master)](https://travis-ci.org/mvandervelden/MVImageViewer)
--------------

Universal (iPhone/iPad) app that lets you pick an image from the gallery, add it to your list,
and let it analyse by the Google Cloud Vision API.

### Features

* Analyse images for associated labels

### Known Issues

* No persistence as of now: analyses are not stored
* Quirky navigation
* Filling out & storing API key securely


### Installation notes

Replace `CloudVisionAPIKey: "YOU_API_KEY_HERE"` in Info.plist 
with a valid API key for your app id. 


### What it demos

* Travis integration for iOS
* Fastlane for build configuration management
* Cucumberish & KIF for running BDD UI tests


### Libraries

For testing the following open source libraries are used through Cocoapods:

* Cucumberish
* KIF
* Quick
* Nimble
