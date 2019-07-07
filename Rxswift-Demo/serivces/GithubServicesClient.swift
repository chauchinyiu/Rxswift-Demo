//
//  GithubServices.swift
//  Rxswift-Demo
//
//  Created by Chinyiu Chau on 07.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import UIKit
import RxSwift

class GithubServicesClient {
    let baseUrl:String = "https://api.github.com/"
    
    func search(query: String) -> Observable<[Repository]>  {
        return Observable.create { observer -> Disposable in
            var urlComponents = URLComponents(string: self.baseUrl + "search/repositories")!
            
            var queryItems: [URLQueryItem] {
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
                        observer.onNext(response.items)
                    } catch let err {
                         observer.onError(err)
                    }
                }
            }
            task.resume();
        
            
            return Disposables.create()
        }
    }

}
