//
//  WorkoutDetailViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/03.
//

import UIKit

class WorkoutDetailViewController: UIViewController {
    
    var workoutId: String!
    private var workout: Workout?
    private let repository = WorkOutRepository()
    
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var workoutDescription: UILabel!
    @IBOutlet weak var workoutLevel: UILabel!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        
        guard let workout = repository.fetchWorkoutBy(id: workoutId) else {
            return
        }

        self.title = workout.name

        workoutName.text = workout.name
        workoutDescription.text = workout.workoutDescription
        workoutLevel.text = workout.level
        
    }
    

    // MARK: 画面遷移関連メソッド
    static func instantiate(workoutId: String) -> WorkoutDetailViewController {
        
        let storyboard = UIStoryboard(name: "WorkoutDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WorkoutDetailVC") as! WorkoutDetailViewController
        vc.workoutId = workoutId
        return vc
        
    }
}
