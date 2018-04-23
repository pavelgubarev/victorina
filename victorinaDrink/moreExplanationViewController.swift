//
//  moreExplanationViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 09/02/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation
import UIKit

class MoreExplanationViewController : UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    @IBAction func dismissThisView(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = "<html><head><style>body{font-family:Menlo,HelveticaNeue-Light; font-size: 12pt; color: black; }</style></head><body>"
        
        let footer = "</body></html>"
        
        let file = Bundle.main.path(forResource: model.longExplanationFileForCurrentQuestion(), ofType: "html")!
        
        var contents =  try! String(contentsOfFile: file, encoding: .utf8)
        
        contents = contents.replacingOccurrences( of : "<a[^>]+>",
                                       with: "", options: String.CompareOptions.regularExpression , range: nil)

        
        contents = header + contents + footer
        
        let baseUrl = URL(fileURLWithPath: file)
        webView.loadHTMLString(contents as String, baseURL: baseUrl)

        webView?.delegate = self
        
        
    }
    
    func webViewDidFinishLoad(_ webView : UIWebView) {
        loadingIndicator.removeFromSuperview()
    }
    
}
