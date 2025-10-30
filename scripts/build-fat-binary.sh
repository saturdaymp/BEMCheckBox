#!/bin/bash

################################################################################
# Build Fat Binary Script for BEMCheckBox
#
# This script builds a universal (fat) binary framework that works on both
# iOS Simulator (x86_64) and iOS Device (arm64).
#
# Usage:
#   ./scripts/build-fat-binary.sh [options]
#
# Options:
#   --clean              Clean build artifacts before building
#   --config [Debug|Release]  Build configuration (default: Release)
#   --help               Show this help message
#
# Output:
#   Release-fat/BEMCheckBox.framework - Universal framework
#
################################################################################

set -e  # Exit on error
set -o pipefail  # Catch errors in pipes

# Configuration
PROJECT_PATH="Sample Project/CheckBox.xcodeproj"
SCHEME="BEMCheckBox"
BUILD_DIR="build"
OUTPUT_DIR="Release-fat"
CONFIGURATION="Release"
CLEAN_BUILD=false
ARCHIVE_DIR="Temp/Archives/"
IOS_SIMULATOR_ARCHIVE_DIR="$ARCHIVE_DIR/BEMCheckBox-iOS_Simulator"
IOS_SIMULATOR_ARCHIVE_PATH="$IOS_SIMULATOR_ARCHIVE_DIR.xcarchive"
IOS_ARCHIVE_DIR="$ARCHIVE_DIR/BEMCheckBox-iOS"
IOS_ARCHIVE_PATH="$IOS_ARCHIVE_DIR.xcarchive"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo ""
    echo -e "${BLUE}===================================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}===================================================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

show_help() {
    cat << EOF
Build Fat Binary Script for BEMCheckBox

This script builds a universal (fat) binary framework that works on both
iOS Simulator (x86_64) and iOS Device (arm64).

USAGE:
    ./scripts/build-fat-binary.sh [OPTIONS]

OPTIONS:
    --clean              Clean build artifacts before building
    --config CONF        Build configuration: Debug or Release (default: Release)
    --help               Show this help message

EXAMPLES:
    # Build release configuration
    ./scripts/build-fat-binary.sh

    # Build debug configuration
    ./scripts/build-fat-binary.sh --config Debug

    # Clean build
    ./scripts/build-fat-binary.sh --clean

OUTPUT:
    Release-fat/BEMCheckBox.framework - Universal framework for iOS

EOF
}

################################################################################
# Parse Arguments
################################################################################

while [[ $# -gt 0 ]]; do
    case $1 in
        --clean)
            CLEAN_BUILD=true
            shift
            ;;
        --config)
            CONFIGURATION="$2"
            if [[ "$CONFIGURATION" != "Debug" && "$CONFIGURATION" != "Release" ]]; then
                print_error "Invalid configuration: $CONFIGURATION. Must be Debug or Release."
                exit 1
            fi
            shift 2
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

################################################################################
# Main Build Process
################################################################################

print_header "BEMCheckBox Fat Binary Build"

print_info "Configuration: $CONFIGURATION"
print_info "Project: $PROJECT_PATH"
print_info "Scheme: $SCHEME"
echo ""

# Clean if requested
if [ "$CLEAN_BUILD" = true ]; then
    print_header "Cleaning Build Artifacts"
    rm -rf "$BUILD_DIR"
    rm -rf "$OUTPUT_DIR"
    print_success "Cleaned build directories"
fi

# Clearn up previous archives
rm -rf "$ARCHIVE_DIR"

# Build for iOS Simulator
print_header "Building for iOS Simulator"
xcodebuild archive \
    -project "$PROJECT_PATH" \
    -scheme "$SCHEME" \
    -destination "generic/platform=iOS Simulator" \
    -configuration "$CONFIGURATION" \
    -derivedDataPath "$BUILD_DIR" \
    -archivePath "$IOS_SIMULATOR_ARCHIVE_DIR" \

print_success "iOS Simulator build completed"
echo ""
echo "Listing: $IOS_SIMULATOR_ARCHIVE_PATH"
ls -laR "$IOS_SIMULATOR_ARCHIVE_PATH"

# Build for iOS device
print_header "Building for iOS device"
xcodebuild archive \
    -project "$PROJECT_PATH" \
    -scheme "$SCHEME" \
    -destination "generic/platform=iOS" \
    -configuration "$CONFIGURATION" \
    -derivedDataPath "$BUILD_DIR" \
    -archivePath "$IOS_ARCHIVE_DIR" \

print_success "iOS device build completed"
echo ""
echo "Listing: $IOS_ARCHIVE_PATH"
ls -laR "$IOS_ARCHIVE_PATH"

exit 0

# Combine Builds
print_header "Combining Builds"

cp -R "$BUILD_DIR/Build/Products/$CONFIGURATION-iphoneos/" "$OUTPUT_DIR"

print_success "Copied device build to output directory"
echo ""
echo "Listing: $OUTPUT_DIR"
ls -la "$OUTPUT_DIR"
echo ""
echo "Listing: $OUTPUT_DIR/BEMCheckBox.framework/BEMCheckBox"
ls -la "$OUTPUT_DIR/BEMCheckBox.framework/BEMCheckBox"
echo ""

# Build Fat Binary
print_header "Creating Fat Binary"

lipo -create -output "$OUTPUT_DIR/BEMCheckBox.framework/BEMCheckBox" \
    "$BUILD_DIR/Build/Products/$CONFIGURATION-iphoneos/BEMCheckBox.framework/BEMCheckBox" \
    "$BUILD_DIR/Build/Products/$CONFIGURATION-iphonesimulator/BEMCheckBox.framework/BEMCheckBox"

print_success "Fat binary created"
echo ""

# Verify Fat Binary
print_header "Verifying Fat Binary"

echo "Architecture info:"
lipo -info "$OUTPUT_DIR/BEMCheckBox.framework/BEMCheckBox"
echo ""

echo "File info:"
file "$OUTPUT_DIR/BEMCheckBox.framework/BEMCheckBox"
echo ""

echo "Listing: $OUTPUT_DIR"
ls -la "$OUTPUT_DIR"
echo ""

echo "Listing: $OUTPUT_DIR/BEMCheckBox.framework"
ls -la "$OUTPUT_DIR/BEMCheckBox.framework"
echo ""

# Success
print_header "Build Complete"
print_success "Universal framework created successfully!"
print_info "Output location: $OUTPUT_DIR/BEMCheckBox.framework"
echo ""
print_info "This framework works on both iOS Simulator (x86_64) and iOS Device (arm64)"
echo ""
