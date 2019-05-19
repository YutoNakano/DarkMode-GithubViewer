//
//  TopViewController.swift
//  githubViewer
//
//  Created by 中野湧仁 on 2019/05/11.
//  Copyright © 2019 Yuto Nakano. All rights reserved.
//

import UIKit
import SnapKit
import APIKit

final class TopViewController: ViewController {
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.register(TopTableViewCell.self, forCellReuseIdentifier: "Cell")
        v.rowHeight = 90
        v.backgroundColor = UIColor.green
        v.delegate = self
        v.dataSource = self
        view.addSubview(v)
        return v
    }()
    
    lazy var serchBar: UISearchBar = {
        let v = UISearchBar()
        v.delegate = self
        v.searchBarStyle = UISearchBar.Style.default
        v.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:42)
        v.layer.position = CGPoint(x: self.view.bounds.width/2, y: 89)
        v.placeholder = "キーワードを入力"
        view.addSubview(v)
        return v
    }()
    
    private var presenter: SearchRepositoriesPresenterInput?
    
    func inject(presenter: SearchRepositoriesPresenterInput) {
        self.presenter = presenter
    }
    
    override func setupView() {
        tableView.tableHeaderView = serchBar
        title = "検索"
        
        Session.send(SearchRepo.SearchRepositories(query: "Python")) { result in
            switch result {
            case .success(let res):
                print(res)
            case .failure(let error):
                print(error)
        }
        }
    }
    
    override func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension TopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TopTableViewCell else { fatalError() }
        return cell
    }
    
    
}

extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension TopViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        presenter?.didTapSearchButton(text: searchBar.text)
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = true
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        serchBar.showsCancelButton = false
        self.view.endEditing(true)
        serchBar.text = ""
        self.tableView.reloadData()
    }
}
