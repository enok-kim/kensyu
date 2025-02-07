
import Foundation
import UIKit

class WorkoutListCell: UITableViewCell {
    
    @IBOutlet weak var workoutListLabel: UILabel!
    
    func configure(workoutName: String) {
        workoutListLabel.text = workoutName
    }
    
}
