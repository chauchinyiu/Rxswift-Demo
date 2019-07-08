//
//  GithubRepositoriesViewModel.swift
//  Rxswift-Demo
//
//  Created by Chinyiu Chau on 05.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//


import RxSwift
import RxRelay
import Foundation

class GithubRepositoriesViewModel: NSObject {
    let client = GithubServicesClient()
    let repositories : BehaviorRelay<[Repository]> = BehaviorRelay(value: [])
    let updateImageInCell : BehaviorRelay<(Int, UIImage)?> = BehaviorRelay(value:nil)
    let disposeBag = DisposeBag()

    func search(query:String ) {
        client.search(query: query)
            .subscribe(
                onNext: { [weak self] repositories in
                    self?.repositories.accept(repositories)
                },
                onError: { error in
                    print(error)
                }
        )
            .disposed(by: disposeBag)
    }
    
    func removeAllRepositories() {
        self.repositories.accept([]);
    }
 
}

