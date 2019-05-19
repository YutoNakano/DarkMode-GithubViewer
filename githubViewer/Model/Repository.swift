//
//  Repository.swift
//  githubViewer
//
//  Created by 中野湧仁 on 2019/05/18.
//  Copyright © 2019 Yuto Nakano. All rights reserved.
//

import Foundation

struct SearchRepositoriesResponse: Decodable {
    let items: [Repository]
}

struct Repository: Decodable {
    let id: Int
    let fullName: String
    let owner: Owner
    let htmlURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case owner
        case htmlURL = "html_url"
    }
}

struct Owner: Decodable {
    let avatarURL: URL

    private enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
