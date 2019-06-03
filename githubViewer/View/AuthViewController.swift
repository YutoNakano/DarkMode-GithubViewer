//
//  AuthViewController.swift
//  githubViewer
//
//  Created by 中野湧仁 on 2019/05/22.
//  Copyright © 2019 Yuto Nakano. All rights reserved.
//

import UIKit
import SnapKit
import WebKit
import Alamofire
import OAuthSwift

protocol AuthViewControllerDelegate: class {
    func loginButtonTapped()
}

class AuthViewController: ViewController {
    
    var oauthswift: OAuthSwift?
    var access_token = ""
    var main_user = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topViewController = TopViewController()
        topViewController.delegate = self
    }
}

extension AuthViewController: AuthViewControllerDelegate {
    func loginButtonTapped(){
        let oauthswift = OAuth2Swift(
            consumerKey:    "aaa",
            consumerSecret: "bbb",
            authorizeUrl:   "https://github.com/login/oauth/authorize",
            accessTokenUrl: "https://github.com/login/oauth/access_token",
            responseType:   "code"
        )
        self.oauthswift = oauthswift
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        let state = generateState(withLength: 20)
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: "smartGithubViewer://")!, scope: "user,repo", state: state,
            success: { credential, response, parameters in
                print(credential.oauthToken)
                self.access_token = credential.oauthToken
                
                Alamofire.request("https://api.github.com/user?access_token=" + self.access_token).responseJSON { response in
                    if let dict = response.result.value as? [String: Any] {
                        self.main_user = dict["login"] as! String
                        print(dict)
                    }
                }
                
        },
            failure: { error in
                print(error.description)
        }
        )
    }
}
