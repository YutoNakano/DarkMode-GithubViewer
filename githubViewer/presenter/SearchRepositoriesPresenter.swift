//
//  SearchRepositoriesPresenter.swift
//  githubViewer
//
//  Created by 中野湧仁 on 2019/05/18.
//  Copyright © 2019 Yuto Nakano. All rights reserved.
//

import Foundation
import APIKit


protocol SearchRepositoriesPresenterInput {
    func didTapSearchButton(text: String?)
}

final class SearchRepositoriesPresenter {
    
    private(set) var repositories: [Repository] = []
    
}


extension SearchRepositoriesPresenter: SearchRepositoriesPresenterInput {
    func didTapSearchButton(text: String?) {
        guard let query = text else { return }
        Session.send(SearchRepo.SearchRepositories(query: query)) { result in
            switch result {
            case .success(let response):
                    print(response.items)
                    self.repositories = response.items

            case .failure(let error):
                    print(error)
            }
        }
    }
}
