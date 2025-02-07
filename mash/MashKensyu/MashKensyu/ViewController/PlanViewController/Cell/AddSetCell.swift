

protocol AddSetCellDelegate: AnyObject {
    func onTapAddSetCell(section: Int, row: Int)
}

import Foundation
import UIKit

class AddSetCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: AddSetCellDelegate?
    private var section: Int = 0
    private var row: Int = 0
    
    func configure(title: String, section: Int, row: Int, delegate: AddSetCellDelegate?) {
        
        self.titleLabel.text = title
        self.section = section
        self.row = row
        self.delegate = delegate
        
    }
    
    @IBAction func didTapCell(_sender : UIButton) {
        delegate?.onTapAddSetCell(section: section, row: row)
    }
    
}
