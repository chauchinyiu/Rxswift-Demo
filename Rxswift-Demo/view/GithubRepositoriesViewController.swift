//
//  ViewController.swift
//  Rxswift-Demo
//
//  Created by Chinyiu Chau on 05.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class GithubRepositoriesViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let disposeBag = DisposeBag()
    let viewModel: GithubRepositoriesViewModel = GithubRepositoriesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBinding()
    }
 
    private func setupBinding() {
        searchBar.rx.text
            .orEmpty
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { query in
                if query.isEmpty {
                    self.viewModel.removeAllRepositories()
                }else{
                    self.viewModel.search(query: query)
                }
                
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("done")
            }, onDisposed:  {
                print("on disposed")
            })
        
        viewModel.repositories.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "RepositoryTableViewCell", cellType: RepositoryTableViewCell.self)) { index, model, cell in
            cell.setupCell(model: model )
        }.disposed(by: self.disposeBag)
        
        tableView.rx.modelSelected(Repository.self)
            .subscribe(onNext: { repository in
                UIApplication.shared.open(repository.html_url, options:  [:], completionHandler: nil)
            })
            .disposed(by: disposeBag)
    }
}

