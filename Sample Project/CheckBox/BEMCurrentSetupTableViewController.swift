//
//  BEMCurrentSetupTableViewController.swift
//  CheckBox
//
//  Created by Bobo on 10/4/15.
//  Copyright © 2015 Boris Emorine. All rights reserved.
//

import UIKit
import BEMCheckBox

class BEMCurrentSetupTableViewController: UITableViewController {

    var checkBox: BEMCheckBox?

    @IBOutlet weak var onPropertyValueLabel: UILabel!
    @IBOutlet weak var lineWidthPropertyValueLabel: UILabel!
    @IBOutlet weak var animationDurationPropertyValueLabel: UILabel!
    @IBOutlet weak var hideBoxPropertyValueLabel: UILabel!
    @IBOutlet weak var onTintColorPropertyLabel: UILabel!
    @IBOutlet weak var onFillColorPropertyLabel: UILabel!
    @IBOutlet weak var onCheckColorPropertyLabel: UILabel!
    @IBOutlet weak var tintColorPropertyLabel: UILabel!
    @IBOutlet weak var boxTypePropertyValueLabel: UILabel!
    @IBOutlet weak var onAnimationTypePropertyValueLabel: UILabel!
    @IBOutlet weak var offAnimationTypePropertyValueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let checkBox else { return }

        onPropertyValueLabel.text = checkBox.on ? "YES" : "NO"
        lineWidthPropertyValueLabel.text = String(format: "%.1f", checkBox.lineWidth)
        animationDurationPropertyValueLabel.text = String(format: "%.2f", checkBox.animationDuration)
        hideBoxPropertyValueLabel.text = checkBox.hideBox ? "YES" : "NO"

        onTintColorPropertyLabel.text = rgbString(for: checkBox.onTintColor)
        onFillColorPropertyLabel.text = rgbString(for: checkBox.onFillColor)
        onCheckColorPropertyLabel.text = rgbString(for: checkBox.onCheckColor)
        tintColorPropertyLabel.text = rgbString(for: checkBox.tintColor)

        boxTypePropertyValueLabel.text = checkBox.boxType == .square ? "BEMBoxTypeSquare" : "BEMBoxTypeCircle"
        onAnimationTypePropertyValueLabel.text = string(for: checkBox.onAnimationType)
        offAnimationTypePropertyValueLabel.text = string(for: checkBox.offAnimationType)
    }

    // MARK: Helper Methods
    private func rgbString(for color: UIColor?) -> String {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return String(format: "R:%.0f - G:%.0f - B:%.0f", red * 255.0, green * 255.0, blue * 255.0)
    }

    private func string(for animationType: BEMCheckBox.AnimationType) -> String {
        switch animationType {
        case .stroke: return "BEMAnimationTypeStroke"
        case .fill: return "BEMAnimationTypeFill"
        case .bounce: return "BEMAnimationTypeBounce"
        case .flat: return "BEMAnimationTypeFlat"
        case .oneStroke: return "BEMAnimationTypeOneStroke"
        case .fade: return "BEMAnimationTypeFade"
        }
    }
}
