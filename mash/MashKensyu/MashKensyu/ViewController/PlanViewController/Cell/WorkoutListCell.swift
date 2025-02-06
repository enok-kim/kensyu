//
//  ChooseWorkoutCell.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/06.
//

import Foundation
import UIKit

class WorkoutListCell: UITableViewCell {
    
    @IBOutlet weak var workoutListLabel: UILabel!
    
    func configure(workoutName: String) {
        workoutListLabel.text = workoutName
    }
    
}
