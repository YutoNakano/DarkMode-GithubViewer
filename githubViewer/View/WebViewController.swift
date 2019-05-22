//
//  WebViewController.swift
//  githubViewer
//
//  Created by 中野湧仁 on 2019/05/19.
//  Copyright © 2019 Yuto Nakano. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

class WebViewController: ViewController {
    
    let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var webView: WKWebView = {
        let webConfig = WKWebViewConfiguration()
        let v = WKWebView(frame: .zero, configuration: webConfig)
        let urlRequest = URLRequest(url: url)
        v.load(urlRequest)
        view.addSubview(v)
        return v
    }()
    
    
    override func makeConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


