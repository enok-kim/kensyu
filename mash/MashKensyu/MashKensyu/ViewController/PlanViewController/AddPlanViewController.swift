//
//  ViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/04.
//

import UIKit

class AddPlanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    static func instantiate() -> AddPlanViewController {
        let storyboard = UIStoryboard(name: "AddPlan", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddPlanVC") as! AddPlanViewController
        return vc
    }
}
