//
//  WorkoutDetailViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/03.
//

import UIKit

class WorkoutDetailViewController: UIViewController {
    
    var categoryId: String!
    var workoutId: String!
    var workout: Workout?
    let repository = WorkOutRepository()
    
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var workoutDescription: UILabel!
    @IBOutlet weak var workoutLevel: UILabel!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        guard let workout = repository.fetchWorkout(categoryId: categoryId, workoutId: workoutId)?.first else {
            return
        }

        self.title = workout.name

        workoutName.text = workout.name
        workoutDescription.text = workout.workoutDescription
        workoutLevel.text = workout.level
    }
    

    // MARK: 画面遷移関連メソッド
    static func instantiate(categoryId: String, workoutId: String) -> WorkoutDetailViewController {
        let storyboard = UIStoryboard(name: "WorkoutDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WorkoutDetailVC") as! WorkoutDetailViewController
        vc.categoryId = categoryId
        vc.workoutId = workoutId
        return vc
    }
}
