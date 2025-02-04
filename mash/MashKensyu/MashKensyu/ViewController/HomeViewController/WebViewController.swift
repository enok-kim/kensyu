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
    var urlString: String?

    override func viewDidLoad() {
        
        super.viewDidLoad()

        if let urlString = urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
    }
    
    static func instantiate(urlString: String?) -> WebViewController {
        
        let storyboard = UIStoryboard(name: "Web", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WebVC") as! WebViewController
        vc.urlString = urlString
        return vc
        
    }
    
}
