//
//  RepositoryCellViewModel.swift
//  Rxswift-Demo
//
//  Created by Chinyiu Chau on 08.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import Foundation
//Part 2 lazy loading
class RepositoryCellViewModel {
    let image : BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)

    func downloadImage(url: URL) {
        URLSession.shared.dataTask( with: url, completionHandler: { (data, _, _) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.image.accept(UIImage(data: data))
                }
            }
        }
        ).resume()
    }
}
