# BEMCheckBox
[![CI](https://github.com/saturdaymp/BEMCheckBox/actions/workflows/ci.yml/badge.svg)](https://github.com/saturdaymp/BEMCheckBox/actions/workflows/ci.yml)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/saturdaymp?label=Sponsors&logo=githubsponsors&labelColor=3C444C)](https://github.com/sponsors/saturdaymp)

<p align="center"><img src="./.assets/BEMCheckBox logo.jpg"/></p>	

**BEMCheckBox** is an open source library making it easy to create beautiful, highly customizable, animated checkboxes for iOS.

This is a fork of the original [Boris-EM/BEMCheckBox](https://github.com/Boris-Em/BEMCheckBox) repository. Thanks to [Boris-Em](https://github.com/Boris-Em) for creating this excellent library! Please feel free to contribute by creating an [issue](https://github.com/saturdaymp/BEMCheckBox/issues) or a [pull request](https://github.com/saturdaymp/BEMCheckBox/pulls).

## Table of Contents

* [**Project Details**](#project-details)
  * [Requirements](#requirements)
  * [Support](#support)
  * [Sample App](#sample-app)
  * [React Native](#react-native)
  * [NativeScript](#nativescript)
  * [Xamarin](#xamarin)
* [**Getting Started**](#getting-started)
  * [Installation](#installation)
  * [Setup](#setup)
* [**Building**](#building)
  * [XCFramework (Recommended)](#xcframework-recommended)
  * [Running Tests](#running-tests)
* [**Documentation**](#documentation)
  * [Enabling / Disabling the Checkbox](#enabling--disabling-the-checkbox)
  * [Reloading](#reloading)
  * [Group / Radio Button Functionality](#group--radio-button-functionality)
  * [Delegate](#delegate)
  * [Customization](#customization)

## Project Details
A quick example of the checkbox in action.

<p align="center"><img src="./.assets/BEMCheckBox.gif"/></p>	

### Requirements
- **iOS 18.0+** - Minimum deployment target
- **Swift 6.0+** - Swift Tools Version (Package.swift uses Swift 5 language mode for compatibility)
- **Xcode 16+** - Development environment (tested with Xcode 26.0.1)
- **Automatic Reference Counting (ARC)**
- **Architectures**: ARM64 (device), ARM64 + x86_64 (simulator)

### Support
Open an [issue](https://github.com/saturdaymp/BEMCheckBox/issues) if you have a question, spot a bug, or have a feature request.  [Pull requests](https://github.com/saturdaymp/BEMCheckBox/pulls) are welcome and much appreciated.  Finally you can send an email to [support@saturdaymp.com](support@saturdaymp.com).

### Sample App
The iOS Sample App included with this project demonstrates how to setup and use **BEMCheckBox** in Objective-C.  There is currently no example project for Swift but hopefully one will be added in the future.  The sample app is located in the `Sample Project/` directory.

### React Native  
**BEMCheckBox** can be used with React Native: [React-Native-BEMCheckBox](https://github.com/torifat/react-native-bem-check-box)

### NativeScript  
**BEMCheckBox** can be used with NativeScript: [NativeScript-BEMCheckBox](https://github.com/nstudio/nativescript-checkbox)

### Xamarin
**BEMCheckBox** can also be used with Xamarin: [XPlugins.iOS.BEMCheckBox](https://github.com/saturdaymp/XPlugins.iOS.BEMCheckBox)

## Getting Started
There are several ways to install and use **BEMCheckBox** into your project.

### Installation

#### Swift Package Manager (Recommended)
Add `https://github.com/saturdaymp/BEMCheckBox` as a dependency in Xcode:
1. Select `File -> Add Package Dependencies...` in Xcode
2. Enter the repository URL: `https://github.com/saturdaymp/BEMCheckBox`
3. Select the version or branch you want to use

Or add it to your `Package.swift` file:
```swift
dependencies: [
    .package(url: "https://github.com/saturdaymp/BEMCheckBox", from: "2.2.0")
]
```

#### XCFramework
Download the latest pre-built XCFramework from the [Releases](https://github.com/saturdaymp/BEMCheckBox/releases) page. The XCFramework supports both iOS devices (arm64) and iOS simulators (arm64 + x86_64).

To integrate:
1. Download `BEMCheckBox.xcframework.zip` from the latest release
2. Unzip and drag `BEMCheckBox.xcframework` into your Xcode project
3. In your target's settings, add the framework to "Frameworks, Libraries, and Embedded Content"

#### CocoaPods
**Note:** The latest version on CocoaPods is [v1.4.1](https://cocoapods.org/pods/BEMCheckBox) from the original [Boris-Em](https://github.com/Boris-Em) repository. As CocoaPods is being [deprecated](https://blog.cocoapods.org/CocoaPods-Specs-Repo/), there are no plans to publish new versions of this fork to CocoaPods. Please use Swift Package Manager or XCFramework instead.

To install the original version using CocoaPods, add to your `Podfile`:
```ruby
pod 'BEMCheckBox'
```

#### Carthage
[Carthage](https://github.com/Carthage/Carthage) is supported. Add **BEMCheckBox** to your Cartfile, run `carthage update`, and drag the built `BEMCheckBox.framework` into your Xcode project.

#### Manual Installation
You can install **BEMCheckBox** manually by dragging and dropping the `Classes/` folder into your Xcode project. Make sure to check the "*Copy items into destination group's folder*" box when adding the files.

### Setup
Setting up **BEMCheckBox** to your project couldn't be simpler. It is modeled after `UISwitch`. In fact, you could just replace instances of `UISwitch` with **BEMCheckBox** in your project!

The library is written in Swift but maintains full Objective-C compatibility. Here are the steps to get started:

#### Swift Usage

1. Import the module in your Swift file:

```swift
import BEMCheckBox
```

2. **BEMCheckBox** can be initialized programmatically or with Interface Builder (Storyboard file).

**Programmatic Initialization**
Add the following code to your implementation (usually in the `viewDidLoad` method of your View Controller):

```swift
let myCheckBox = BEMCheckBox(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
self.view.addSubview(myCheckBox)
```

**Interface Builder Initialization**
1. Drag a `UIView` to your `UIViewController`
2. Change the class of the new `UIView` to `BEMCheckBox`
3. Select the `BEMCheckBox` and open the Attributes Inspector. Most customizable properties can be set from the Attributes Inspector. The Sample App demonstrates this capability.

#### Objective-C Usage

1. Import the framework header in your Objective-C file:

```objective-c
#import <BEMCheckBox/BEMCheckBox-Swift.h>
// Or if manually installed:
#import "BEMCheckBox-Swift.h"
```

2. **BEMCheckBox** can be initialized programmatically or with Interface Builder.

**Programmatic Initialization**
Add the following code to your implementation:

```objective-c
BEMCheckBox *myCheckBox = [[BEMCheckBox alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
[self.view addSubview:myCheckBox];
```

**Interface Builder Initialization**
Same as Swift - drag a `UIView`, change its class to `BEMCheckBox`, and customize in the Attributes Inspector.

## Building

### XCFramework (Recommended)
The project includes a build script that creates a universal XCFramework supporting both iOS devices and simulators (including Apple Silicon):

```bash
# Build XCFramework using the automated script
./Scripts/build-xcframework.sh

# Output will be at: Temp/Release-fat/BEMCheckBox.xcframework
```

This script:
- Builds archives for iOS Simulator (arm64 + x86_64)
- Builds archives for iOS Device (arm64)
- Creates an XCFramework from both archives
- Supports BUILD_LIBRARY_FOR_DISTRIBUTION for better compatibility
- Includes debug symbols (dSYMs)

**Note:** XCFramework is the modern Apple-recommended approach and is preferred over fat binaries.

### Building with Xcode Command Line

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
```

### Running Tests

The project includes comprehensive unit tests for the BEMCheckBox framework:

```bash
# Run all unit tests
xcodebuild test \
  -project "Sample Project/CheckBox.xcodeproj" \
  -scheme CheckBoxTests \
  -destination 'platform=iOS Simulator,name=iPhone 14'
```

**Test Suites:**
- **CheckBoxTests**: Basic checkbox functionality (initialization, setters, default values)
- **GroupTests**: Radio button group functionality (group selection, mustHaveSelection behavior)
- **AnimationManagerTests**: Animation behavior tests

## Documentation
All of the methods and properties available for **BEMCheckBox** are documented below.

### Enabling / Disabling the Checkbox
##### The `on` Property
Just like `UISwitch`, **BEMCheckBox** provides the boolean property `on` that allows you to retrieve and set (without animation) a value determining whether the BEMCheckBox object is `on` or `off`. Defaults to `false`.

Example usage:
```swift
// Swift
myCheckBox.on = true
```
```objective-c
// Objective-C
self.myCheckBox.on = YES;
```

##### `setOn:animated:`
Just like `UISwitch`, **BEMCheckBox** provides an instance method `setOn(_:animated:)` that sets the state of the checkbox to On or Off, optionally animating the transition.

Example usage:
```swift
// Swift
myCheckBox.setOn(true, animated: true)
```
```objective-c
// Objective-C
[self.myCheckBox setOn:YES animated:YES];
```

### Reloading
The instance method `reload()` lets you redraw the entire checkbox, keeping the current `on` value.

Example usage:
```swift
// Swift
myCheckBox.reload()
```
```objective-c
// Objective-C
[self.myCheckBox reload];
```

### Group / Radio Button Functionality
**BEMCheckBox**es can easily be grouped together to form radio button functionality. This will automatically manage the state of each checkbox in the group, so that only one is selected at a time, and can optionally require that the group has a selection at all times.

```swift
// Swift
group = BEMCheckBoxGroup(checkBoxes: [checkBox1, checkBox2, checkBox3])
group.selectedCheckBox = checkBox2 // Optionally set which checkbox is pre-selected
group.mustHaveSelection = true // Define if the group must always have a selection
```
```objective-c
// Objective-C
self.group = [BEMCheckBoxGroup groupWithCheckBoxes:@[self.checkBox1, self.checkBox2, self.checkBox3]];
self.group.selectedCheckBox = self.checkBox2;
self.group.mustHaveSelection = YES;
```

To see which checkbox is selected in that group:
```swift
// Swift
let selection = group.selectedCheckBox
```
```objective-c
// Objective-C
BEMCheckBox *selection = self.group.selectedCheckBox;
```

To manually update the selection for a group:
```swift
// Swift
group.selectedCheckBox = checkBox1
```
```objective-c
// Objective-C
self.group.selectedCheckBox = self.checkBox1;
```

### Delegate
**BEMCheckBox** uses a delegate to receive check box events. The delegate object must conform to the `BEMCheckBoxDelegate` protocol, which is composed of two optional methods:

- `didTap(_:)`
Sent to the delegate every time the check box gets tapped, after its properties are updated (`on`), but before the animations are completed.

- `animationDidStop(for:)`
Sent to the delegate every time the check box finishes being animated.

Example:
```swift
// Swift
class MyViewController: UIViewController, BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        print("Checkbox tapped: \(checkBox.on)")
    }

    func animationDidStop(for checkBox: BEMCheckBox) {
        print("Animation completed")
    }
}
```
```objective-c
// Objective-C
@interface MyViewController () <BEMCheckBoxDelegate>
@end

@implementation MyViewController

- (void)didTap:(BEMCheckBox *)checkBox {
    NSLog(@"Checkbox tapped: %d", checkBox.on);
}

- (void)animationDidStopForCheckBox:(BEMCheckBox *)checkBox {
    NSLog(@"Animation completed");
}

@end
```

### Customization
**BEMCheckBox** is exclusively customizable through properties.
The following diagram provides a good overview:
<p align="center"><img src="./.assets/BEMCheckBox properties.jpg"/></p>

##### Appearance Properties
`lineWidth` - `CGFloat`
The width of the lines of the check mark and box. Defaults to `2.0`.

`hideBox` - `Bool`
Controls if the box should be hidden or not. Setting this property to `true` will essentially turn the checkbox into a check mark. Defaults to `false`.

`boxType` - `BEMBoxType`
The type of box to use. See `BEMBoxType` for possible values. Defaults to `.circle`.
<p align="center"><img src="./.assets/BEMCheckBox box type.jpg"/></p>

`tintColor` - `UIColor`
The color of the box when the checkbox is Off.

`onCheckColor` - `UIColor`
The color of the check mark when it is On.

`onFillColor` - `UIColor`
The color of the inside of the box when it is On.

`onTintColor` - `UIColor`
The color of the line around the box when it is On.

##### Animations
`animationDuration` - `CGFloat`
The duration in seconds of the animations. Defaults to `0.5`.

`onAnimationType` - `BEMAnimationType`
The type of animation to use when the checkbox gets checked. Defaults to `.stroke`. See `BEMAnimationType` below for possible values.

`offAnimationType` - `BEMAnimationType`
The type of animation to use when the checkbox gets unchecked. Defaults to `.stroke`. See `BEMAnimationType` below for possible values.

`BEMAnimationType`
The possible values for `onAnimationType` and `offAnimationType`.

- `.stroke` (Swift) / `BEMAnimationTypeStroke` (Objective-C)
<p align="left"><img src="./.assets/BEMCheckBox-Stroke.gif"/></p>

- `.fill` (Swift) / `BEMAnimationTypeFill` (Objective-C)
<p align="left"><img src="./.assets/BEMCheckBox-Fill.gif"/></p>

- `.bounce` (Swift) / `BEMAnimationTypeBounce` (Objective-C)
<p align="left"><img src="./.assets/BEMCheckBox-Bounce.gif"/></p>

- `.flat` (Swift) / `BEMAnimationTypeFlat` (Objective-C)
<p align="left"><img src="./.assets/BEMCheckBox-Flat.gif"/></p>

- `.oneStroke` (Swift) / `BEMAnimationTypeOneStroke` (Objective-C)
<p align="left"><img src="./.assets/BEMCheckBox-One-Stroke.gif"/></p>

- `.fade` (Swift) / `BEMAnimationTypeFade` (Objective-C)
<p align="left"><img src="./.assets/BEMCheckBox-Fade.gif"/></p>
