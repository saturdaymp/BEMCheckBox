## v2.1.0 (Jan, 16, 2024)


As part of this release we had [10 issues](https://github.com/saturdaymp/BEMCheckBox/milestone/2?closed=1) closed.

The user-facing changes in this release are:

- Added accessibility features to the checkbox.  Please ping me if you they don't work and/or can be improved.
- Updated the minimum iOS version from 12 to 18.

Developer facing changes:

- Updated from Swift 5 to 6 but use Swift 5 compatibility mode for now.

__Breaking__

- [__!14__](https://github.com/saturdaymp/BEMCheckBox/pull/14) Update minimum iOS version to 18

__DevOps__

- [__!12__](https://github.com/saturdaymp/BEMCheckBox/pull/12) Update macOS and GitHub Action Versions in CI
- [__!13__](https://github.com/saturdaymp/BEMCheckBox/pull/13) Update GitVersion
- [__!17__](https://github.com/saturdaymp/BEMCheckBox/pull/17) Fix release notes action error on main branch
- [__!19__](https://github.com/saturdaymp/BEMCheckBox/pull/19) Fix unit test timeout issue in GitHub Actions
- [__!20__](https://github.com/saturdaymp/BEMCheckBox/pull/20) Prevent release notes generation on main branch push
- [__!22__](https://github.com/saturdaymp/BEMCheckBox/pull/22) Add 'refactoring' label to Git Release Manager config

__Documentation__

- [__!26__](https://github.com/saturdaymp/BEMCheckBox/pull/26) Update CocaPods instructions

__enhancement__

- [__!15__](https://github.com/saturdaymp/BEMCheckBox/pull/15) Add accessibility support for BEMCheckBox

__Refactoring__

- [__!16__](https://github.com/saturdaymp/BEMCheckBox/pull/16) Remove Travis and Cocopods config

## v2.0.0 (Aug, 3, 2023)


As part of this release we had [5 issues](https://github.com/saturdaymp/BEMCheckBox/milestone/1?closed=1) closed.

This release has the following breaking changes:

- Minimum iOS version was increased from 8.4 to 12.
- Events renamed 
  -  `didTapCheckBox` renamed to `didTap`
  - `animationDidStopCheckBox` to `animationDidStopFor`

__Breaking__

- [__#1__](https://github.com/saturdaymp/BEMCheckBox/pull/1) Update minimum iOS version from 8.4 to 12 and other Xcode project settings

__DevOps__

- [__#3__](https://github.com/saturdaymp/BEMCheckBox/pull/3) Create GitHub Action to build package for XPlugins.iOS.BEMCheckBox
- [__#6__](https://github.com/saturdaymp/BEMCheckBox/pull/6) Update build to upload fat binary to GitHub Release
- [__#7__](https://github.com/saturdaymp/BEMCheckBox/pull/7) Upload release to GitHub

__Documentation__

- [__#5__](https://github.com/saturdaymp/BEMCheckBox/pull/5) Update release note for v2.0.0 release

## 1.4.1 (May, 16, 2017)


This is the last official release from [Boris-Em](https://github.com/Boris-Em).  Please check out the original [repo](https://github.com/Boris-Em/BEMCheckBox) for more details.
## 1.1.0 (Oct, 17, 2015)


[Full Changelog](https://github.com/Boris-Em/BEMCheckBox/compare/1.0.0...1.1.0)
 
Added new delegate and BEMCheckBoxDelegate protocol used to receive check box events.
## 1.0.0 (Oct, 10, 2015)


First stable release of **BEMCheckBox**
