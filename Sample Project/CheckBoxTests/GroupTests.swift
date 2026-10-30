//
//  GroupTests.swift
//  CheckBox
//
//  Created by Bobo on 10/18/16.
//  Copyright © 2016 Boris Emorine. All rights reserved.
//

import UIKit
import XCTest
import BEMCheckBox

class GroupTests: XCTestCase {

    var checkBoxes: [BEMCheckBox] = []

    override func setUp() {
        super.setUp()

        checkBoxes = (0..<5).map { _ in BEMCheckBox() }
    }

    override func tearDown() {
        checkBoxes = []

        super.tearDown()
    }

    func testSelectedCheckBox() {
        let group = BEMCheckBoxGroup(checkBoxes: checkBoxes)
        XCTAssertNotNil(group)
        XCTAssertNil(group.selectedCheckBox)

        group.selectedCheckBox = BEMCheckBox()
        XCTAssertNil(group.selectedCheckBox)
        XCTAssertIdentical(selectedCheckBox(for: group), group.selectedCheckBox)
        XCTAssertEqual(numberOfSelectedCheckBoxes(for: group), 0)

        group.selectedCheckBox = checkBoxes[1]
        XCTAssertIdentical(group.selectedCheckBox, checkBoxes[1])
        XCTAssertIdentical(selectedCheckBox(for: group), group.selectedCheckBox)
        XCTAssertEqual(numberOfSelectedCheckBoxes(for: group), 1)

        group.selectedCheckBox = checkBoxes[2]
        XCTAssertIdentical(group.selectedCheckBox, checkBoxes[2])
        XCTAssertIdentical(selectedCheckBox(for: group), group.selectedCheckBox)
        XCTAssertEqual(numberOfSelectedCheckBoxes(for: group), 1)

        group.selectedCheckBox = checkBoxes[0]
        XCTAssertIdentical(group.selectedCheckBox, checkBoxes[0])
        XCTAssertIdentical(selectedCheckBox(for: group), group.selectedCheckBox)
        XCTAssertEqual(numberOfSelectedCheckBoxes(for: group), 1)

        group.selectedCheckBox = nil
        XCTAssertNil(group.selectedCheckBox)
        XCTAssertNil(selectedCheckBox(for: group))
        XCTAssertEqual(numberOfSelectedCheckBoxes(for: group), 0)
    }

    func testAutoSelectFirstCheckBox() {
        let group = BEMCheckBoxGroup(checkBoxes: checkBoxes)
        XCTAssertNotNil(group)
        XCTAssertNil(group.selectedCheckBox)

        group.mustHaveSelection = true
        XCTAssertNotNil(group.selectedCheckBox)

        group.selectedCheckBox = nil
        XCTAssertNotNil(group.selectedCheckBox)
    }

    func testAddCheckBox() {
        let group = BEMCheckBoxGroup(checkBoxes: checkBoxes)
        XCTAssertNotNil(group)
        XCTAssertEqual(group.checkBoxes.count, checkBoxes.count)

        let checkBox = BEMCheckBox()
        group.addCheckBoxToGroup(checkBox)

        XCTAssertEqual(group.checkBoxes.count, checkBoxes.count + 1)
    }

    func testRemoveCheckBox() {
        let group = BEMCheckBoxGroup(checkBoxes: checkBoxes)
        XCTAssertNotNil(group)
        XCTAssertEqual(group.checkBoxes.count, checkBoxes.count)

        group.removeCheckBoxFromGroup(checkBoxes[0])
        XCTAssertEqual(group.checkBoxes.count, checkBoxes.count - 1)
    }

    func testEmptyGroup() {
        let emptyGroup = BEMCheckBoxGroup(checkBoxes: [])
        XCTAssertNotNil(emptyGroup)
        XCTAssertEqual(emptyGroup.checkBoxes.count, 0)

        emptyGroup.removeCheckBoxFromGroup(BEMCheckBox())
        XCTAssertEqual(emptyGroup.checkBoxes.count, 0)

        emptyGroup.mustHaveSelection = true
        XCTAssertEqual(emptyGroup.checkBoxes.count, 0)

        let checkBox = BEMCheckBox()
        emptyGroup.addCheckBoxToGroup(checkBox)
        XCTAssertEqual(emptyGroup.checkBoxes.count, 1)
    }

    // MARK: Helper Methods

    private func numberOfSelectedCheckBoxes(for group: BEMCheckBoxGroup) -> Int {
        return group.checkBoxes.allObjects.filter { $0.on }.count
    }

    private func selectedCheckBox(for group: BEMCheckBoxGroup) -> BEMCheckBox? {
        return group.checkBoxes.allObjects.first { $0.on }
    }
}
