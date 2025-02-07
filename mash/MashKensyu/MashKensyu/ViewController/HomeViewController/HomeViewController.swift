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

    }
    
    @IBAction func onTapPlanButton(_ sender: UIButton) {
        let planVC = ChooseWorkoutViewController.instantiate()
        navigationController?.pushViewController(planVC, animated: true)
    }
    
    @IBAction func onTapAddPlanButton(_ sender: UIButton) {
        let addPlanVC = AddPlanViewController.instantiate()
        navigationController?.pushViewController(addPlanVC, animated: true)
    }
    
    @IBAction func onTapPlanHistoryButton(_ sender: UIButton) {
        let planHistoryVC = PlanHistoryViewController.instantiate()
        navigationController?.pushViewController(planHistoryVC, animated: true)
    }
    @IBAction func onTapGoogleButton(_ sender: UIButton) {
        let webVC = WebViewController.instantiate(urlString: "http://www.google.com")
        navigationController?.pushViewController(webVC, animated: true)
        }
    
    @IBAction func onTapNaverButton(_ sender: UIButton) {
        let webVC = WebViewController.instantiate(urlString: "http://www.naver.com")
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func onTapYahooButton(_ sender: UIButton) {
        let webVC = WebViewController.instantiate(urlString: "http://www.yahoo.co.jp")
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func onTapYoutubeButton(_ sender: UIButton) {
        let webVC = WebViewController.instantiate(urlString: "http://www.youtube.com")
        navigationController?.pushViewController(webVC, animated: true)
    }
    
}
