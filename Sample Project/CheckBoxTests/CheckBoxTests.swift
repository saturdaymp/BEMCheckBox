//
//  CheckBoxTests.swift
//  CheckBoxTests
//
//  Created by Bobo on 8/29/15.
//  Copyright (c) 2015 Boris Emorine. All rights reserved.
//

import UIKit
import XCTest
import BEMCheckBox

class CheckBoxTests: XCTestCase {

    var checkBox: BEMCheckBox!

    override func setUp() {
        super.setUp()

        checkBox = BEMCheckBox()
    }

    override func tearDown() {
        checkBox = nil

        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(checkBox)

        // Default values
        let blueColor = UIColor(red: 0, green: 122.0 / 255.0, blue: 1, alpha: 1)
        XCTAssertFalse(checkBox.on, "The default value for 'on' should be 'false'")
        XCTAssertFalse(checkBox.hideBox, "The box shouldn't be hidden by default")
        XCTAssertEqual(checkBox.onTintColor, blueColor, "Default on tint color")
        XCTAssertEqual(checkBox.onFillColor, UIColor.clear, "Default on fill color")
        XCTAssertEqual(checkBox.onCheckColor, blueColor, "Default on check color")
        XCTAssertEqual(checkBox.tintColor, UIColor.lightGray, "Default tint color")
        XCTAssertEqual(checkBox.lineWidth, 2.0, "Default line width should be 2.0")
        XCTAssertEqual(checkBox.animationDuration, 0.5, "Default animation duration should be 0.5")
        XCTAssertEqual(checkBox.onAnimationType, .stroke, "Default on animation should be of type stroke")
        XCTAssertEqual(checkBox.offAnimationType, .stroke, "Default off animation should be of type stroke")
        XCTAssertEqual(checkBox.backgroundColor, UIColor.clear, "Background color should be transparent")
    }

    func testSetOnAnimated() {
        checkBox.setOn(true, animated: false)
        XCTAssertTrue(checkBox.on)
        checkBox.layoutIfNeeded()
        XCTAssertEqual(checkBox.layer.sublayers?.count, 3)

        checkBox.setOn(false, animated: false)
        XCTAssertFalse(checkBox.on)
        checkBox.layoutIfNeeded()
        XCTAssertEqual(checkBox.layer.sublayers?.count, 1)

        checkBox.setOn(true, animated: true)
        XCTAssertTrue(checkBox.on)
        XCTAssertEqual(checkBox.layer.sublayers?.count, 3)

        checkBox.setOn(false, animated: true)
        XCTAssertFalse(checkBox.on)
    }

    func testOn() {
        checkBox.on = true
        XCTAssertTrue(checkBox.on)
        checkBox.layoutIfNeeded()
        XCTAssertEqual(checkBox.layer.sublayers?.count, 3)

        checkBox.on = false
        XCTAssertFalse(checkBox.on)
        checkBox.layoutIfNeeded()
        XCTAssertEqual(checkBox.layer.sublayers?.count, 1)
    }

    func testReload() {
        checkBox.on = false
        XCTAssertFalse(checkBox.on)

        checkBox.setNeedsDisplay()
        XCTAssertFalse(checkBox.on)

        checkBox.on = true
        XCTAssertTrue(checkBox.on)

        checkBox.setNeedsDisplay()
        XCTAssertTrue(checkBox.on)
    }
}
