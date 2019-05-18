//
//  DecodableDataParser.swift
//  githubViewer
//
//  Created by 中野湧仁 on 2019/05/18.
//  Copyright © 2019 Yuto Nakano. All rights reserved.
//

import Foundation
import APIKit

final class DecodableDataparser: DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data
    }
}
