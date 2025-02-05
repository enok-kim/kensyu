//
//  PlanHistoryViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/04.
//

import UIKit

class PlanHistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Screen Transition Method
    static func instantiate() -> PlanHistoryViewController {
        let storyboard = UIStoryboard(name: "PlanHistory", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PlanHistoryVC") as! PlanHistoryViewController
        return vc
    }

}
