//
//  RepositoryCellTableViewCell.swift
//  Rxswift-Demo
//
//  Created by Chinyiu Chau on 05.07.19.
//  Copyright © 2019 Chinyiu Chau. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    weak var tableView: UITableView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }

    func setupCell(model: Repository) {
        super.textLabel?.text = model.full_name
        if let data = try? Data(contentsOf: model.owner.avatar_url) {
            if let image = UIImage(data: data) {
                super.imageView?.image = image
            }}
    }
}

extension UIImageView {
    func load(url: URL ,completion: @escaping (_ image: UIImage?) -> Void) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    
                        self?.image = image
                        completion(image)
                        return
               
                }
            }
            completion(nil)
        }
    }
}
