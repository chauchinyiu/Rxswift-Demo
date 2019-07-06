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
    let repositories : BehaviorRelay<[Repository]> = BehaviorRelay(value: [])
    let updateImageInCell : BehaviorRelay<(Int, UIImage)?> = BehaviorRelay(value:nil)
    func search(query: String)  {
        //repositoryCells.accept([]);
        var urlComponents = URLComponents(string: "https://api.github.com/search/repositories")!
       
        var queryItems: [URLQueryItem]? {
            return [
                .init(name: "q", value: query),
                .init(name: "order", value: "desc")
            ]
        }
        urlComponents.queryItems = queryItems;
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(SearchRepositoryResponse.self, from: data)
                    self.repositories.accept(response.items)
                } catch let err {
                    print("Err", err)
                }
            }
            
            
        }
        task.resume();

    }
    
    
    func removeAllRepositories() {
        self.repositories.accept([]);
    }
 
}

