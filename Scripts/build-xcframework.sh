#!/bin/bash

################################################################################
# Build XCFramework Script for BEMCheckBox
#
# This script builds a universal XCFramework that works on both
# iOS Simulator and iOS Device platforms.
#
# Usage:
#   ./Scripts/build-xcframework.sh [--help]
#
# Output:
#   Temp/Release-fat/BEMCheckBox.xcframework
#
################################################################################

set -e  # Exit on error
set -o pipefail  # Catch errors in pipes

# Configuration
PROJECT_PATH="Sample Project/CheckBox.xcodeproj"
SCHEME="BEMCheckBox"
CONFIGURATION="Release"
ARCHIVE_DIR="Temp/Archives"
OUTPUT_DIR="Temp/Release-fat"

# Archive paths
IOS_SIMULATOR_ARCHIVE="$ARCHIVE_DIR/BEMCheckBox-iOS_Simulator.xcarchive"
IOS_DEVICE_ARCHIVE="$ARCHIVE_DIR/BEMCheckBox-iOS.xcarchive"

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

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

show_help() {
    cat << EOF
Build XCFramework Script for BEMCheckBox

This script builds a universal XCFramework that works on both
iOS Simulator and iOS Device platforms.

USAGE:
    ./Scripts/build-xcframework.sh [--help]

OUTPUT:
    Temp/Release-fat/BEMCheckBox.xcframework

EOF
}

# Reusable build function
build_archive() {
    local platform_name="$1"
    local destination="$2"
    local archive_path="$3"

    print_header "Building for $platform_name"

    xcodebuild archive \
        -project "$PROJECT_PATH" \
        -scheme "$SCHEME" \
        -destination "$destination" \
        -configuration "$CONFIGURATION" \
        -archivePath "$archive_path" \
        SKIP_INSTALL=NO \
        BUILD_LIBRARY_FOR_DISTRIBUTION=YES

    print_success "$platform_name build completed"
    echo ""
    echo "Listing: $archive_path"
    ls -laR "$archive_path"
    echo ""
}

# Validate environment
validate_environment() {
    if ! command -v xcodebuild &> /dev/null; then
        print_error "xcodebuild not found. Please install Xcode."
        exit 1
    fi

    if [[ ! -d "$PROJECT_PATH" ]]; then
        print_error "Project not found: $PROJECT_PATH"
        exit 1
    fi
}

################################################################################
# Parse Arguments
################################################################################

if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi

################################################################################
# Main Build Process
################################################################################

START_TIME=$(date +%s)

print_header "BEMCheckBox XCFramework Build"

print_info "Configuration: $CONFIGURATION"
print_info "Project: $PROJECT_PATH"
print_info "Scheme: $SCHEME"
echo ""

# Validate environment
validate_environment

# Clean up previous builds
print_info "Cleaning previous builds..."
rm -rf "$ARCHIVE_DIR"
rm -rf "$OUTPUT_DIR"

# Build for iOS Simulator
build_archive \
    "iOS Simulator" \
    "generic/platform=iOS Simulator" \
    "$IOS_SIMULATOR_ARCHIVE"

# Build for iOS Device
build_archive \
    "iOS Device" \
    "generic/platform=iOS" \
    "$IOS_DEVICE_ARCHIVE"

# Create XCFramework
print_header "Creating XCFramework"

xcodebuild -create-xcframework \
    -archive "$IOS_SIMULATOR_ARCHIVE" -framework "BEMCheckBox.framework" \
    -archive "$IOS_DEVICE_ARCHIVE" -framework "BEMCheckBox.framework" \
    -output "$OUTPUT_DIR/BEMCheckBox.xcframework"

print_success "XCFramework created successfully"
echo ""

# Show final output details
print_info "Output location: $OUTPUT_DIR/BEMCheckBox.xcframework"
ls -laR "$OUTPUT_DIR/BEMCheckBox.xcframework"
echo ""

# Show supported architectures
print_header "Supported Architectures"

print_info "iOS Simulator architectures:"
file "$OUTPUT_DIR/BEMCheckBox.xcframework/ios-arm64_x86_64-simulator/BEMCheckBox.framework/BEMCheckBox"
echo ""

print_info "iOS Device architectures:"
file "$OUTPUT_DIR/BEMCheckBox.xcframework/ios-arm64/BEMCheckBox.framework/BEMCheckBox"
echo ""

# Build summary
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

print_header "Build Summary"
print_success "XCFramework: $OUTPUT_DIR/BEMCheckBox.xcframework"
print_info "Size: $(du -sh "$OUTPUT_DIR/BEMCheckBox.xcframework" | cut -f1)"
print_info "Configuration: $CONFIGURATION"
print_info "Build time: ${DURATION}s"
echo ""
