//
//  WebViewController.swift
//  MashKensyu
//
//  Created by eversense on 2025/02/04.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    private var urlString: String?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadURL()
        
    }
    
    private func loadURL() {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    static func instantiate(urlString: String?) -> WebViewController {
        
        let storyboard = UIStoryboard(name: "Web", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WebVC") as! WebViewController
        vc.urlString = urlString
        return vc
        
    }
    
}
