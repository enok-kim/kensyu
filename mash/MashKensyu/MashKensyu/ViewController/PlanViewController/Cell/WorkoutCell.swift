
import UIKit

class WorkoutCell: UITableViewCell {
    
    @IBOutlet weak var workoutLabel: UILabel!
    
    func configure(wourkoutName: String) {
        workoutLabel.text = wourkoutName
    }
}
