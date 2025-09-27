# BEMCheckBox - Project Reference Guide

## Project Overview

BEMCheckBox is an open-source iOS checkbox library that provides beautiful, highly customizable, animated checkboxes. This is a fork of the original [Boris-Em/BEMCheckBox](https://github.com/Boris-Em/BEMCheckBox) repository.

### Key Technologies
- **Main Library**: Written in Swift
- **Example Project**: Written in Objective-C
- **Minimum iOS Version**: iOS 18
- **Swift Tools Version**: 6.0+

## Project Structure

```
BEMCheckBox/
├── Classes/                     # Swift source files for the main library
│   ├── BEMCheckBox.swift        # Main checkbox implementation
│   ├── BEMCheckBoxGroup.swift   # Radio button group functionality
│   ├── BEMAnimationManager.swift # Animation handling
│   └── BEMPathManager.swift     # Path drawing utilities
├── Sample Project/              # Example iOS application (Objective-C)
│   ├── CheckBox.xcodeproj/      # Xcode project file
│   ├── CheckBox/                # Example app source code
│   ├── CheckBoxTests/           # Unit tests
│   └── CheckBoxUITests/         # UI tests
├── Package.swift                # Swift Package Manager configuration
├── .github/workflows/           # CI/CD GitHub Actions
│   ├── ci.yml                   # Main CI workflow
│   └── release-notes.yml        # Release notes generation
└── README.md                    # Main documentation
```

## Build Instructions

### Building the Framework

#### Using Xcode Command Line Tools

```bash
# Build for iOS Simulator (excluding arm64 to avoid conflicts)
xcodebuild -sdk iphonesimulator \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme BEMCheckBox \
  -configuration Release \
  EXCLUDED_ARCHS="arm64"

# Build for iOS Device
xcodebuild -sdk iphoneos \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme BEMCheckBox \
  -configuration Release

# Build the Sample App
xcodebuild -sdk iphonesimulator \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme CheckBox \
  -configuration Debug
```

#### Using Swift Package Manager

**Note**: Building with Swift Package Manager for iOS requires explicit SDK paths and target specifications since this is an iOS-only library.

##### iOS Simulator (x86_64)

```bash
# Debug build for iOS Simulator
swift build \
  --sdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator26.0.sdk \
  -Xswiftc -target \
  -Xswiftc x86_64-apple-ios18.0-simulator

# Release build for iOS Simulator
swift build -c release \
  --sdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator26.0.sdk \
  -Xswiftc -target \
  -Xswiftc x86_64-apple-ios18.0-simulator
```

##### iOS Device (arm64)

```bash
# Debug build for iOS Device
swift build \
  --sdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS26.0.sdk \
  -Xswiftc -target \
  -Xswiftc arm64-apple-ios18.0

# Release build for iOS Device
swift build -c release \
  --sdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS26.0.sdk \
  -Xswiftc -target \
  -Xswiftc arm64-apple-ios18.0
```

##### Build Artifacts

Build artifacts are located in:
- **Debug builds**: `.build/debug/`
- **Release builds**: `.build/release/`
- **Swift modules**: `BEMCheckBox.swiftmodule`
- **Documentation**: `BEMCheckBox.swiftdoc`

##### Important Notes for Swift Package Manager

1. **Swift Version**: Package.swift is configured to use Swift 5 language mode to avoid Swift 6 strict concurrency issues
2. **SDK Versions**: Update SDK paths if using different Xcode versions (check with `xcodebuild -showsdks`)
3. **No Tests**: Swift Package Manager tests are not available as this is an iOS-only library requiring simulator/device
4. **Architecture**: Specify target architecture explicitly for each platform

### Creating a Fat Binary Framework

To create a universal framework that works on both device and simulator:

```bash
# 1. Build for simulator (excluding arm64)
xcodebuild -sdk iphonesimulator \
  -project "Sample Project/CheckBox.xcodeproj" \
  -derivedDataPath build \
  -scheme BEMCheckBox \
  -configuration Release \
  EXCLUDED_ARCHS="arm64"

# 2. Build for device
xcodebuild -sdk iphoneos \
  -project "Sample Project/CheckBox.xcodeproj" \
  -derivedDataPath build \
  -scheme BEMCheckBox \
  -configuration Release

# 3. Create fat binary
cp -R build/Build/Products/Release-iphoneos/ Release-fat
lipo -create -output Release-fat/BEMCheckBox.framework/BEMCheckBox \
  build/Build/Products/Release-iphoneos/BEMCheckBox.framework/BEMCheckBox \
  build/Build/Products/Release-iphonesimulator/BEMCheckBox.framework/BEMCheckBox

# 4. Verify the fat binary
lipo -info Release-fat/BEMCheckBox.framework/BEMCheckBox
```

## Running Tests

The project includes two test suites:
- **CheckBoxTests**: Unit tests for the BEMCheckBox framework
- **CheckBoxUITests**: UI tests for the sample application (currently failing)

### Prerequisites
- iOS Simulator with iOS 18.0+ (recommended: iPhone 14 or newer)
- Xcode 14+ with command line tools

### Running Unit Tests

```bash
# Run all unit tests
xcodebuild test \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme CheckBoxTests \
  -destination 'platform=iOS Simulator,name=iPhone 14'

# Run unit tests on a specific iOS version
xcodebuild test \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme CheckBoxTests \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=18.5'

# Run a specific test class
xcodebuild test \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme CheckBoxTests \
  -destination 'platform=iOS Simulator,name=iPhone 14' \
  -only-testing:CheckBoxTests/CheckBoxTests

# Run a specific test method
xcodebuild test \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme CheckBoxTests \
  -destination 'platform=iOS Simulator,name=iPhone 14' \
  -only-testing:CheckBoxTests/CheckBoxTests/test_frame
```

### Running UI Tests

**⚠️ Note**: The UI tests are currently failing and will need to be fixed in a future update.

```bash
# Run all UI tests (using CheckBox scheme which includes UI tests)
xcodebuild test \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme CheckBox \
  -destination 'platform=iOS Simulator,name=iPhone 14' \
  -only-testing:CheckBoxUITests

# Alternative: Run UI tests directly (may not work due to current issues)
xcodebuild test \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme CheckBoxUITests \
  -destination 'platform=iOS Simulator,name=iPhone 14'
```

### Running All Tests

```bash
# Run both unit and UI tests together
xcodebuild test \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme CheckBox \
  -destination 'platform=iOS Simulator,name=iPhone 14'
```

### Test Results and Debugging

- Test results are output to the console in real-time
- For more detailed output, add `-verbose` flag to any xcodebuild command
- Test results bundles are saved to `/tmp/` for further analysis
- Failed tests will show assertion details and stack traces

### Available Test Classes

**Unit Tests (CheckBoxTests)**:
- `CheckBoxTests.m`: Basic checkbox functionality tests
- `GroupTests.m`: Radio button group functionality tests
- `AnimationManagerTests.m`: Animation behavior tests

**UI Tests (CheckBoxUITests)**:
- `CheckBoxUITests.m`: End-to-end UI interaction tests

### Troubleshooting

- If tests fail to start, ensure the iOS Simulator is available and iOS 18.0+ is installed
- For "No such device" errors, check available simulators with: `xcrun simctl list devices`
- Test timeouts may occur on slower machines - increase timeout with `-test-timeout` flag

## Installation Methods

### Swift Package Manager
Add `https://github.com/saturdaymp/BEMCheckBox` as a dependency in Xcode or Package.swift

### CocoaPods
```ruby
pod 'BEMCheckBox'
```
Note: The latest CocoaPods version is v1.4.1 from the original repository

### Carthage
Add to Cartfile and run `carthage update`

### Manual
Copy the `Classes` folder directly into your Xcode project

## Development Setup

### Requirements
- Xcode 14+ (recommended)
- iOS 18.0+ deployment target
- Swift 6.0+
- macOS for development

### Schemes and Targets
The Xcode project contains the following targets:
- **BEMCheckBox**: Framework target for the library
- **CheckBox**: Sample application demonstrating usage
- **CheckBoxTests**: Unit tests for the library
- **CheckBoxUITests**: UI tests for the sample app

## Key Features

- **Animation Types**: Stroke, Fill, Bounce, Flat, One-Stroke, Fade
- **Box Types**: Circle, Square
- **Group Functionality**: Radio button behavior with BEMCheckBoxGroup
- **Customization Properties**:
  - Line width
  - Colors (on/off states)
  - Animation duration
  - Box visibility

## CI/CD Pipeline

The project uses GitHub Actions for continuous integration:

- **Trigger**: Pushes to `main` and `release/*` branches, pull requests
- **Build Environment**: macOS-15
- **Version Management**: GitVersion for semantic versioning
- **Artifacts**: Builds universal framework and uploads to GitHub releases on tags

### CI Workflow Steps
1. Install GitVersion for version determination
2. Build for iOS Simulator (x86_64)
3. Build for iOS Device (arm64)
4. Create fat binary framework
5. Upload artifacts to GitHub

## Common Development Tasks

### Viewing Available Schemes
```bash
xcodebuild -list -project "Sample Project/CheckBox.xcodeproj"
```

### Clean Build
```bash
xcodebuild clean -project "Sample Project/CheckBox.xcodeproj" -scheme BEMCheckBox
```

### Generate Documentation
```bash
# If using jazzy for documentation
jazzy --module BEMCheckBox --source-directory Classes/
```

### Check Swift Version
```bash
swift --version
```

## Important Notes

1. The framework is `@IBDesignable` and `@IBInspectable` compatible for Interface Builder
2. The main checkbox implementation is in Swift while maintaining Objective-C compatibility
3. When building for simulator on Apple Silicon Macs, exclude arm64 architecture to avoid conflicts with device builds
4. The project supports both programmatic and Interface Builder initialization

## Useful Links

- [Original Repository](https://github.com/Boris-Em/BEMCheckBox)
- [Current Fork](https://github.com/saturdaymp/BEMCheckBox)
- [Xamarin Binding](https://github.com/saturdaymp/XPlugins.iOS.BEMCheckBox)
- [React Native Wrapper](https://github.com/torifat/react-native-bem-check-box)
- [NativeScript Plugin](https://github.com/nstudio/nativescript-checkbox)

## Support

For issues or questions:
- Open an [issue](https://github.com/saturdaymp/BEMCheckBox/issues)
- Submit a [pull request](https://github.com/saturdaymp/BEMCheckBox/pulls)
- Email: support@saturdaymp.com