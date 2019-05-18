//
//  BaseRequest.swift
//  githubViewer
//
//  Created by 中野湧仁 on 2019/05/18.
//  Copyright © 2019 Yuto Nakano. All rights reserved.
//

import APIKit

protocol BaseRequest: Request {
    
}

extension BaseRequest {
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}

extension BaseRequest where Response: Decodable {
//    var method: HTTPMethod {
//        return .get
//    }
//    
//    var path: String {
//        return ""
//    }
    
    var dataParser: DataParser {
        return DecodableDataparser()
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: object as! Data)
    }
}

