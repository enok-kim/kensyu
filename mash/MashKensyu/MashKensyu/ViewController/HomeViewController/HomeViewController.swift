//
//  HomeViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/04.
//

import UIKit
import WebKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onPlan(_ sender: UIButton) {
        let planVC = PlanViewController.instantiate()
        navigationController?.pushViewController(planVC, animated: true)
    }
    
    @IBAction func onAddPlan(_ sender: UIButton) {
        let addPlanVC = AddPlanViewController.instantiate()
        navigationController?.pushViewController(addPlanVC, animated: true)
    }
    
    @IBAction func onPlanHistory(_ sender: Any) {
        let planHistoryVC = PlanHistoryViewController.instantiate()
        navigationController?.pushViewController(planHistoryVC, animated: true)
    }
    @IBAction func onGoogleButton(_ sender: UIButton) {
        let webVC = WebViewController.instantiate(urlString: "http://www.google.com")
        navigationController?.pushViewController(webVC, animated: true)
        }
    
    @IBAction func onNaverButton(_ sender: UIButton) {
        let webVC = WebViewController.instantiate(urlString: "http://www.naver.com")
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func onYahooButton(_ sender: UIButton) {
        let webVC = WebViewController.instantiate(urlString: "http://www.yahoo.co.jp")
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func onYoutubeButton(_ sender: UIButton) {
        let webVC = WebViewController.instantiate(urlString: "http://www.youtube.com")
        navigationController?.pushViewController(webVC, animated: true)
    }
    
}
