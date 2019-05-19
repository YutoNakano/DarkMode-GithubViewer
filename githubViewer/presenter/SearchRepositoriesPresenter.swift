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
    var numberOfRepos: Int { get }
    func repo(forRow row: Int) -> Repository?
    func didTapSearchButton(text: String?)
}

protocol SearchRepositoriesPresenterOutput: AnyObject {
    func updateRepo(_ repositories: [Repository])
    func stopIndicator()
}

final class SearchRepositoriesPresenter {
    
    private(set) var repositories: [Repository] = []
    private weak var view: SearchRepositoriesPresenterOutput!
    
    init(view: SearchRepositoriesPresenterOutput) {
        self.view = view
    }
    
}


extension SearchRepositoriesPresenter: SearchRepositoriesPresenterInput {
    
    func repo(forRow row: Int) -> Repository? {
        // repositories.countがtableviewのcellの数を上回ったらnilを返す
        guard row < repositories.count else { return nil }
        return repositories[row]
    }
    
    var numberOfRepos: Int {
        return repositories.count
    }
    
    func didTapSearchButton(text: String?) {
        guard let query = text else { return }
        guard !query.isEmpty else { return self.view.stopIndicator() }
        Session.send(SearchRepo.SearchRepositories(query: query)) { result in
            switch result {
            case .success(let response):
                    print(response.items)
                    self.repositories = response.items
                    DispatchQueue.main.async {
                        self.view.updateRepo(response.items)
                        self.view.stopIndicator()
                }

            case .failure(let error):
                    print(error)
            }
        }
    }
}
