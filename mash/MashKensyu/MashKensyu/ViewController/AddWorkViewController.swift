//
//  AddWorkViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/01/31.
//

import UIKit

class AddWorkViewController: UIViewController {
    
    var passedId: String?
    
    // MARK: OutLet!
    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var workoutDescrioption: UITextField!
    @IBOutlet weak var workoutLevel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: 画面遷移メソッド
    static func instantiate() -> AddWorkViewController {
        let storyboard = UIStoryboard(name: "AddWork", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddWorkVC") as! AddWorkViewController
    }
    
}
