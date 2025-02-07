
import Foundation
import UIKit

class SetCell: UITableViewCell {
    @IBOutlet weak var setLabel: UILabel!

    func configure(setText: String) {
        setLabel.text = setText
    }
}
