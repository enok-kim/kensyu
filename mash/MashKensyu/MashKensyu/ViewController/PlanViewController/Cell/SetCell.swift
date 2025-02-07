
import Foundation
import UIKit

protocol SetCellDelegate: AnyObject {
    func didCompleteSet(at indexPath: IndexPath, weight: Double?, reps: Int?)
}

class SetCell: UITableViewCell {
    
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var isCompleteSetBtn: UIButton!
    
    weak var delegate: SetCellDelegate?
    var indexPath: IndexPath?
    
    func configure(setText: String, indexPath: IndexPath) {
        setLabel.text = setText
        self.indexPath = indexPath
    }
    
    @IBAction func onCompleteClick(_ sender: UIButton) {
        
        guard let indexPath = indexPath,
              let weight = Double(weightTextField.text ?? ""),
              let reps = Int(repsTextField.text ?? "") else { return }
        
        delegate?.didCompleteSet(at: indexPath, weight: weight, reps: reps)
        self.isCompleteSetBtn.backgroundColor = .green
        
    }
    
        func updateSetDetails(weight: Double?, reps: Int?) {
            weightTextField.text = weight != nil ? String(weight!) : ""
            repsTextField.text = reps != nil ? String(reps!) : ""
        }
    
} // end of class
