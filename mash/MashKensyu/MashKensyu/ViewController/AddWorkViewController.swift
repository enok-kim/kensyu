//
//  AddWorkViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/01/31.
//

import UIKit

class AddWorkViewController: UIViewController {
    
    var categoryId: String?
    private let workoutRepository = WorkOutRepository()
    
    // MARK: Outlets
    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var workoutDescription: UITextField!
    @IBOutlet weak var workoutLevel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addWorkout(_ sender: UIButton) {
        guard let name = workoutName.text, !name.isEmpty,
              let description = workoutDescription.text, !description.isEmpty,
              let level = workoutLevel.text, !level.isEmpty else {
            return
        }
        
        let newWorkout = Workout()
        newWorkout.name = name
        newWorkout.workoutDescription = description
        newWorkout.difficulty = level
        
        if let categoryId {
            workoutRepository.addWorkout(categoryId: categoryId, workout: newWorkout)
            self.navigationController?.popViewController(animated: true)
        } else {
            print("Error: categoryId is nil")
        }
    }
    
    @IBAction func onReset(_ sender: UIButton) {
        workoutName.text = ""
        workoutDescription.text = ""
        workoutLevel.text = ""
    }
    
    static func instantiate(categoryId: String) -> AddWorkViewController {
        let storyboard = UIStoryboard(name: "AddWork", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddWorkVC") as! AddWorkViewController
        vc.categoryId = categoryId
        return vc
    }
}
