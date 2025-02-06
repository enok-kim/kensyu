//
//  SetCell.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/06.
//

import Foundation
import UIKit

class SetCell: UITableViewCell {
    @IBOutlet weak var setLabel: UILabel!

    func configure(setText: String) {
        setLabel.text = setText
    }
}
