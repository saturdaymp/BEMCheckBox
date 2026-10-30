//
//  AnimationManangerTests.swift
//  CheckBox
//
//  Created by Bobo on 9/28/15.
//  Copyright © 2015 Boris Emorine. All rights reserved.
//

import XCTest
import BEMCheckBox

class AnimationManangerTests: XCTestCase {

    var manager: BEMAnimationManager!

    override func setUp() {
        super.setUp()

        manager = BEMAnimationManager(animationDuration: 10.0)
    }

    override func tearDown() {
        manager = nil

        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(manager)
        XCTAssertEqual(manager.animationDuration, 10.0)
    }

    func testStrokeAnimation() {
        var animation = manager.strokeAnimationReverse(false)
        XCTAssertNotNil(animation)
        XCTAssertEqual(animation.duration, 10.0)
        XCTAssertEqual(animation.fromValue as? NSNumber, 0.0)
        XCTAssertEqual(animation.toValue as? NSNumber, 1.0)
        XCTAssertFalse(animation.isRemovedOnCompletion)
        XCTAssertEqual(animation.fillMode, .forwards)
        XCTAssertEqual(animation.keyPath, "strokeEnd")

        animation = manager.strokeAnimationReverse(true)
        XCTAssertEqual(animation.fromValue as? NSNumber, 1.0)
        XCTAssertEqual(animation.toValue as? NSNumber, 0.0)
    }
}
