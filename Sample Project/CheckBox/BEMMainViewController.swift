//
//  BEMMainViewController.swift
//  CheckBox
//
//  Created by Bobo on 9/21/15.
//  Copyright (c) 2015 Boris Emorine. All rights reserved.
//

import UIKit
import BEMCheckBox

class BEMMainViewController: UIViewController, BEMCheckBoxDelegate, BEMAnimationsTableViewDelegate {

    @IBOutlet var checkBox: BEMCheckBox!
    @IBOutlet var drawTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var animationButton: UIButton!

    private let blueColor = UIColor(red: 0, green: 122.0 / 255.0, blue: 1, alpha: 1)

    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        checkBox.onAnimationType = .bounce
        checkBox.offAnimationType = .bounce

        animationButton.layer.cornerRadius = 5.0
        animationButton.layer.borderColor = UIColor.white.cgColor
        animationButton.layer.borderWidth = 1.0
    }

    // MARK: Actions
    @IBAction func didDragLineWidthSlider(_ slider: UISlider) {
        checkBox.lineWidth = CGFloat(slider.value)
    }

    @IBAction func didDragAnimationSpeedSlider(_ slider: UISlider) {
        checkBox.animationDuration = CFTimeInterval(slider.value)
    }

    @IBAction func didTapOnBoxTypeSegmentedControl(_ segmentedControl: UISegmentedControl) {
        checkBox.boxType = segmentedControl.selectedSegmentIndex == 0 ? .circle : .square
    }

    @IBAction func didTapOnDrawTypeSegmentedControl(_ segmentedControl: UISegmentedControl) {
        checkBox.tintColor = .lightGray
        checkBox.onTintColor = blueColor

        if segmentedControl.selectedSegmentIndex == 0 {
            checkBox.onFillColor = .clear
            checkBox.onCheckColor = blueColor
        } else {
            checkBox.onFillColor = blueColor
            checkBox.onCheckColor = .white
        }
    }

    // MARK: BEMAnimationsTableViewDelegate
    func didSelectAnimationType(_ animationType: BEMCheckBox.AnimationType) {
        checkBox.onAnimationType = animationType
        checkBox.offAnimationType = animationType

        switch animationType {
        case .stroke, .oneStroke:
            drawTypeSegmentedControl.selectedSegmentIndex = 0
            drawTypeSegmentedControl.sendActions(for: .valueChanged)
            drawTypeSegmentedControl.isEnabled = false
        case .fill:
            drawTypeSegmentedControl.selectedSegmentIndex = 1
            drawTypeSegmentedControl.sendActions(for: .valueChanged)
            drawTypeSegmentedControl.isEnabled = false
        default:
            drawTypeSegmentedControl.isEnabled = true
        }
    }

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let destVC as BEMAnimationsTableViewController where segue.identifier == "toAnimationSelection":
            destVC.delegate = self
            destVC.selectedAnimation = checkBox.onAnimationType
        case let destVC as BEMCurrentSetupTableViewController where segue.identifier == "toCurrentSetup":
            destVC.checkBox = checkBox
        default:
            break
        }
    }
}
