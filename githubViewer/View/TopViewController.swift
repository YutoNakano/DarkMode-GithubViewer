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
import WebKit

final class TopViewController: ViewController {
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.register(TopTableViewCell.self, forCellReuseIdentifier: "Cell")
        v.rowHeight = 90
        v.backgroundColor = UIColor.white
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
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        v.center = self.view.center
        v.hidesWhenStopped = true
        v.style = UIActivityIndicatorView.Style.gray
        view.addSubview(v)
        return v
    }()
    
    lazy var authButton: UIBarButtonItem = {
        let v = UIBarButtonItem(image: UIImage(named: "auth")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(authButtonTapped))
        return v
    }()
    
    lazy var clipButton: UIBarButtonItem = {
        let v = UIBarButtonItem(image: UIImage(named: "clip")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(clipButtonTapped))
        return v
    }()
    
    private var presenter: SearchRepositoriesPresenterInput!
    
    func inject(presenter: SearchRepositoriesPresenterInput) {
        self.presenter = presenter
    }
    
    override func setupView() {
        tableView.tableHeaderView = serchBar
        navigationItem.leftBarButtonItem = authButton
        navigationItem.rightBarButtonItem = clipButton
        title = "リポジトリ検索"
    }
    
    override func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}

extension TopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRepos
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TopTableViewCell else { fatalError() }
        // presenter.repoはrepositories[row]を返す
        if let repo = presenter.repo(forRow: indexPath.row) {
        // cellにviewmodelを渡す
            cell.configure(repo: repo)
        }
        return cell
    }
    
    
}

extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }

}

extension TopViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        presenter?.didTapSearchButton(text: searchBar.text)
        // Indicator回す
        activityIndicator.startAnimating()
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

extension TopViewController: SearchRepositoriesPresenterOutput {
    func transitionToWebView(url: URL) {
        let webViewController = WebViewController(url: url)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func updateRepo(_ repositories: [Repository]) {
        tableView.reloadData()
    }
    
    func stopIndicator() {
        activityIndicator.stopAnimating()
    }
}

extension TopViewController {
    @objc func authButtonTapped() {
        let gitOuthURL = DataConfig.githubClientID
        let webView = WebViewController(url: gitOuthURL)
        present(webView, animated: true, completion: nil)
    }
    @objc func clipButtonTapped() {
        print(#function)
    }
}
