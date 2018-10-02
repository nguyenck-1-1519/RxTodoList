//
//  TodoTableViewCell.swift
//  TodoListRx
//
//  Created by Can Khac Nguyen on 10/3/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import UIKit
import Reusable

class TodoTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContentWith(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
