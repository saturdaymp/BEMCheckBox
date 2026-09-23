//
//  BEMAnimationsTableViewController.swift
//  CheckBox
//
//  Created by Bobo on 9/30/15.
//  Copyright © 2015 Boris Emorine. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol BEMAnimationsTableViewDelegate: AnyObject {
    func didSelectAnimationType(_ animationType: BEMCheckBox.AnimationType)
}

class BEMAnimationsTableViewController: UITableViewController {

    weak var delegate: BEMAnimationsTableViewDelegate?

    var selectedAnimation: BEMCheckBox.AnimationType = .stroke

    // MARK: View Controller Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let indexPath = IndexPath(row: selectedAnimation.rawValue, section: 0)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }

    // MARK: UITableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let animationType = BEMCheckBox.AnimationType(rawValue: indexPath.row) {
            delegate?.didSelectAnimationType(animationType)
        }
        navigationController?.popViewController(animated: true)
    }
}
