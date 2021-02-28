fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios UITests
```
fastlane ios UITests
```
Run UI tests, example: bundle exec fastlane ios UITests 'device:iPhone 8 (12.4)'
### ios UnitTests
```
fastlane ios UnitTests
```
Run unit tests
### ios runTests
```
fastlane ios runTests
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
