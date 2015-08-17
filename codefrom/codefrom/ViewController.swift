//
//  ViewController.swift
//  codefrom
//
//  Created by hongcha on 15/8/16.
//  Copyright (c) 2015年 HongCha. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate {
    
    var webView: WKWebView;
    lazy var refreshControl = UIRefreshControl();
    var url: String = "none"
    var alert = UIAlertView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webView.navigationDelegate = self
        
        view.addSubview(webView);
        webView.setTranslatesAutoresizingMaskIntoConstraints(false)
        let height = NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0)
        view.addConstraints([height, width])
        
        loadData()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshPage", forControlEvents: .ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        webView.scrollView.addSubview(refreshControl) // 关键代码
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    required init(coder aDecoder: NSCoder) {
        self.webView = WKWebView(frame: CGRectZero)
        //self.url = "none"
        super.init(coder: aDecoder)
    }
    
    func refreshPage(){
        println("Refreshing...")
        self.url = "refresh"
        loadData()
        refreshControl.endRefreshing()
    }

    func loadData(){
        //println(webView.URL)
        //let url = webView.URL?.absoluteString
        var request: NSURLRequest
        if self.url == "none"{
            self.url = "have"
            let url = NSURL(string:"http://www.wooyun.org")
            request = NSURLRequest(URL:url!)
        } else {
            request = NSURLRequest(URL:webView.URL!)
        }
        //let request = NSURLRequest(URL:webView.URL!)
        webView.loadRequest(request)

    }
    
    //开始加载
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //println("loading....")
        if self.url != "refresh" {
            alert.title =  ""
            alert.delegate = self
            alert.message = "连接中......."
            alert.show()
        }

    }
    //刚接收到
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation){
        if self.url != "refresh"{
            alert.dismissWithClickedButtonIndex(0, animated: false)
            alert.message = "加载中......"
            alert.show()
        }
    }
    //加载完成
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation) {
        if self.url != "refresh"{
            alert.dismissWithClickedButtonIndex(0, animated: false)
        }
        self.url = "finish"
    }
}
