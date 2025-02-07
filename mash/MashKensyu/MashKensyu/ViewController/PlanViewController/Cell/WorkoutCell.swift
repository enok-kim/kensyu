
import UIKit

class WorkoutCell: UITableViewCell {
    
    @IBOutlet weak var workoutLabel: UILabel!
    
    func configure(workoutName: String) {
        workoutLabel.text = workoutName
    }
}
