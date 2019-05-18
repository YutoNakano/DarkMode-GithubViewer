//
//  UserRequest.swift
//  githubViewer
//
//  Created by 中野湧仁 on 2019/05/18.
//  Copyright © 2019 Yuto Nakano. All rights reserved.
//

import UIKit
import Foundation
import APIKit

public final class SearchRepo {
    private init() {}
    
    struct SearchRepositories: BaseRequest {


        typealias Response = SearchRepositoriesResponse
        
        let method: HTTPMethod = .get
        let path: String = "/search/repositories"
        var parameters: Any? {
            return ["q": query, "page": 1]
        }
        
        let query: String
    }
}
