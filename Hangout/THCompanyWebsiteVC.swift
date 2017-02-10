//
//  THCompanyWebsiteVC.swift
//  TheHangouts
//
//  Created by Shravan Keri on 10/02/17.
//  Copyright © 2017 Shravan Keri. All rights reserved.
//

import UIKit

class THCompanyWebsiteVC: UIViewController {
    
    @IBOutlet weak var webview: UIWebView!
    var weburl: String?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if weburl == nil {
            let alert = UIAlertController.init(title: "Hangouts", message: "website not found", preferredStyle: .alert)
            let okAction: UIAlertAction = UIAlertAction.init(title: "OK", style: .cancel, handler: { (ation) in
                self.navigationController?.popViewController(animated: true)
            });
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            weburl = weburl?.replacingOccurrences(of: "http", with: "https")//to bypass Transport
            webview.loadRequest(NSURLRequest(url: NSURL(string: weburl!)! as URL) as URLRequest)
        }
    }
}
