//
//  PlanViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/04.
//

import UIKit

class PlanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Screen Transition Method
    static func instantiate() -> PlanViewController {
        let storyboard = UIStoryboard(name: "Plan", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PlanVC") as! PlanViewController
        return vc
    }

}
