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
│   ├── BEMCheckBox/             # Framework header files
│   ├── CheckBox/                # Example app source code
│   ├── CheckBoxTests/           # Unit tests
│   │   ├── CheckBoxTests.m      # Basic checkbox functionality tests
│   │   ├── GroupTests.m         # Radio button group tests
│   │   └── AnimationManangerTests.m # Animation tests
│   └── CheckBoxUITests/         # UI tests
│       └── CheckBoxUITests.m    # UI interaction tests
├── Scripts/                     # Build automation scripts
│   └── build-xcframework.sh     # Script to build XCFramework
├── Package.swift                # Swift Package Manager configuration
├── GitVersion.yml               # GitVersion configuration
├── GitReleaseManager.yml        # Release manager configuration
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

### Creating an XCFramework (Recommended)

The project includes a build script that creates a universal XCFramework supporting both iOS devices and simulators (including Apple Silicon simulators):

```bash
# Build XCFramework using the automated script
./Scripts/build-xcframework.sh

# Output will be at: Temp/Release-fat/BEMCheckBox.xcframework
```

This script:
1. Builds archives for iOS Simulator (arm64 + x86_64)
2. Builds archives for iOS Device (arm64)
3. Creates an XCFramework from both archives
4. Supports BUILD_LIBRARY_FOR_DISTRIBUTION for better compatibility
5. Includes debug symbols (dSYMs)

**Note**: XCFramework is the modern Apple-recommended approach and is preferred over fat binaries.

### Creating a Fat Binary Framework (Legacy)

**Note**: This approach is deprecated. Use XCFramework instead (see above).

To create a legacy universal framework that works on both device and simulator:

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
- iOS Simulator with iOS 18.0+ (recommended: iPhone 16 or newer)
- Xcode 16+ with command line tools (tested with Xcode 26.0.1)
- iOS 26.0 SDK

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
- `CheckBoxTests.m`: Basic checkbox functionality tests (initialization, setters, default values)
- `GroupTests.m`: Radio button group functionality tests (group selection, mustHaveSelection behavior)
- `AnimationManangerTests.m`: Animation behavior tests (typo in filename is intentional - actual file name)

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
- Xcode 16+ (Xcode 26.0.1 tested and working)
- iOS 18.0+ deployment target
- Swift 6.0+ (Package.swift uses Swift 5 language mode for compatibility)
- macOS 15+ for development (CI uses macOS-15)

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

The project uses GitHub Actions for continuous integration and release management.

### Main CI Workflow (ci.yml)

**Trigger**:
- Pushes to `main` and `release/*` branches
- Pull requests to `main` and `release/*` branches
- Tags matching `v*` pattern

**Build Environment**: macOS-15 with Xcode 26.0.1

**Version Management**: GitVersion 6.3.0 for semantic versioning

**Workflow Steps**:
1. Checkout code with full history (required for GitVersion)
2. Install and run GitVersion to determine version
3. Show available SDKs and simulators
4. Run unit tests on iPhone 16 with iOS 18.5 simulator
5. Build XCFramework using `./Scripts/build-xcframework.sh`
6. Upload XCFramework as workflow artifact
7. On tag push: Install GitReleaseManager 0.20.0 and upload XCFramework to GitHub Release

**Test Configuration**:
- Destination: `platform=iOS Simulator,OS=18.5,name=iPhone 16`
- Timeout: 10 minutes
- Test results saved to TestResults bundle

**Artifacts**:
- Workflow artifact: `BEMCheckBox-v{version}.xcframework` (directory)
- Release asset: `BEMCheckBox-v{version}.xcframework.zip` (on tagged releases)
- Output location: `Temp/Release-fat/BEMCheckBox.xcframework`

### Release Notes Workflow (release-notes.yml)

**Trigger**:
- Pushes to `release/*` branches
- Pull requests to `main` and `release/*` branches

**Purpose**: Automatically generates and maintains CHANGELOG.md

**Workflow Steps**:
1. Checkout code with full history
2. Install GitVersion and GitReleaseManager
3. Create GitHub Release draft for the milestone
4. Export changelog to CHANGELOG.md
5. Auto-commit updated CHANGELOG.md if changed

**Configuration**: Uses GitReleaseManager.yml for:
- Issue label filtering (breaking, bug, devops, dependency, documentation, enhancement, refactoring, security)
- Changelog formatting
- Created date in title format

### GitVersion Configuration (GitVersion.yml)

- **Workflow**: GitHubFlow/v1
- **Main branch**: Increments minor version
- **Release branches**: Prevent increment when current commit is tagged

### Important Notes

1. CI requires `contents: write` permission to upload artifacts and create releases
2. Release notes workflow uses PAT token for committing to protected branches
3. XCFramework build includes both simulator (arm64 + x86_64) and device (arm64) architectures
4. Test failures will fail the entire CI build
5. Only tag pushes trigger the release asset upload

## Build Scripts

### XCFramework Build Script (build-xcframework.sh)

Located at [Scripts/build-xcframework.sh](Scripts/build-xcframework.sh), this script automates the complete XCFramework build process.

**Features**:
- Color-coded console output for better readability
- Error handling with `set -e` and `set -o pipefail`
- Environment validation (checks for xcodebuild and project path)
- Automatic cleanup of previous builds
- Detailed logging of build artifacts and architectures
- Build time reporting

**Usage**:
```bash
# Standard build
./Scripts/build-xcframework.sh

# Show help
./Scripts/build-xcframework.sh --help
```

**Configuration** (editable at top of script):
- `PROJECT_PATH`: "Sample Project/CheckBox.xcodeproj"
- `SCHEME`: "BEMCheckBox"
- `CONFIGURATION`: "Release"
- `ARCHIVE_DIR`: "Temp/Archives"
- `OUTPUT_DIR`: "Temp/Release-fat"

**Build Process**:
1. Validates environment (xcodebuild presence, project existence)
2. Cleans previous builds from Temp/ directory
3. Archives for iOS Simulator with destination `generic/platform=iOS Simulator`
4. Archives for iOS Device with destination `generic/platform=iOS`
5. Creates XCFramework with `xcodebuild -create-xcframework`
6. Reports final XCFramework size, supported architectures, and build time

**Flags Used**:
- `SKIP_INSTALL=NO`: Required for archiving frameworks
- `BUILD_LIBRARY_FOR_DISTRIBUTION=YES`: Enables module stability for better compatibility

**Output**:
- Archives: `Temp/Archives/BEMCheckBox-iOS_Simulator.xcarchive` and `Temp/Archives/BEMCheckBox-iOS.xcarchive`
- XCFramework: `Temp/Release-fat/BEMCheckBox.xcframework`
- Includes dSYMs for debugging

## Common Development Tasks

### Viewing Available Schemes
```bash
xcodebuild -list -project "Sample Project/CheckBox.xcodeproj"
```

### Clean Build
```bash
# Clean Xcode build
xcodebuild clean -project "Sample Project/CheckBox.xcodeproj" -scheme BEMCheckBox

# Clean build script artifacts
rm -rf Temp/ build/
```

### Check Available SDKs
```bash
xcodebuild -showsdks
```

### List Available Simulators
```bash
xcrun simctl list devices
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

### Verify XCFramework
```bash
# Check architectures in simulator slice
file Temp/Release-fat/BEMCheckBox.xcframework/ios-arm64_x86_64-simulator/BEMCheckBox.framework/BEMCheckBox

# Check architectures in device slice
file Temp/Release-fat/BEMCheckBox.xcframework/ios-arm64/BEMCheckBox.framework/BEMCheckBox

# Check XCFramework structure
ls -laR Temp/Release-fat/BEMCheckBox.xcframework
```

## Important Notes

1. **Interface Builder Support**: The framework is `@IBDesignable` and `@IBInspectable` compatible for Interface Builder
2. **Language Interoperability**: The main checkbox implementation is in Swift while maintaining Objective-C compatibility through the generated Swift header
3. **XCFramework vs Fat Binary**:
   - XCFramework is the modern, recommended approach (supports both arm64 and x86_64 simulators)
   - Fat binaries are legacy and don't support multiple simulator architectures
4. **Initialization**: The project supports both programmatic and Interface Builder initialization
5. **Swift Language Mode**: Package.swift uses Swift 5 language mode (`.swiftLanguageMode(.v5)`) to avoid Swift 6 strict concurrency warnings
6. **Build Output**: All build scripts output to the `Temp/` directory, which is not tracked in git
7. **SDK Versions**: Update SDK paths in Swift Package Manager commands based on your Xcode version (use `xcodebuild -showsdks` to check)

## Useful Links

- [Original Repository](https://github.com/Boris-Em/BEMCheckBox)
- [Current Fork](https://github.com/saturdaymp/BEMCheckBox)
- [Xamarin Binding](https://github.com/saturdaymp/XPlugins.iOS.BEMCheckBox)
- [React Native Wrapper](https://github.com/torifat/react-native-bem-check-box)
- [NativeScript Plugin](https://github.com/nstudio/nativescript-checkbox)

## Git Workflow and Branching

The project follows **GitHubFlow/v1** workflow with the following branch structure:

### Branch Strategy

- **`main`**: Primary development branch
  - All feature development and bug fixes merge here
  - GitVersion increments minor version on commits to main
  - Protected branch requiring pull request reviews

- **`release/*`**: Release preparation branches (e.g., `release/2.2.0`)
  - Created from main when ready to release
  - GitVersion prevents increment when current commit is tagged
  - Triggers release notes generation workflow
  - CI runs on all pushes to release branches

- **`v*` tags**: Version tags (e.g., `v2.2.0`)
  - Applied to release branch commits
  - Triggers full CI build with XCFramework upload to GitHub Releases
  - Must match GitVersion output for consistency

### Release Process

1. Create release branch from main: `git checkout -b release/X.Y.Z`
2. Push release branch: triggers CHANGELOG.md generation
3. Review and merge any final changes
4. Tag the release: `git tag vX.Y.Z`
5. Push tag: `git push origin vX.Y.Z`
6. CI builds and uploads XCFramework to GitHub Release
7. GitReleaseManager creates release notes from milestone

### Version Numbers

- Managed by **GitVersion 6.3.0**
- Configuration in [GitVersion.yml](GitVersion.yml)
- Semantic versioning (MAJOR.MINOR.PATCH)
- Version embedded in build artifacts

## Support

For issues or questions:
- Open an [issue](https://github.com/saturdaymp/BEMCheckBox/issues)
- Submit a [pull request](https://github.com/saturdaymp/BEMCheckBox/pulls)
- Email: support@saturdaymp.com