//
//  RepositoryCellTableViewCell.swift
//  Rxswift-Demo
//
//  Created by Chinyiu Chau on 05.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryCell: UITableViewCell {
    let viewModel: RepositoryCellViewModel = RepositoryCellViewModel()
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Part 2: Asynchronously download image data (lazy loading)
        viewModel.image.asObservable().bind(to: super.imageView!.rx.image).disposed(by: self.disposeBag)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setupCell(model: Repository) {
        super.textLabel?.text = model.full_name
        super.imageView?.image = UIImage(named: "placeholder")
// Part 1: Synchronously loading image
//        if let data = try? Data(contentsOf: model.owner.avatar_url) {
//            if let image = UIImage(data: data) {
//                super.imageView?.image = image
//            }}
        
// Part 2: Asynchronously loading image  (lazy loading)
         viewModel.downloadImage(url: model.owner.avatar_url)

    }
}


