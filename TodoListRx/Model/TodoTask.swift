//
//  TodoTask.swift
//  TodoListRx
//
//  Created by Can Khac Nguyen on 10/3/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import Foundation

class TodoTask {
    var title: String
    var description: String
    
    init() {
        self.title = ""
        self.description = ""
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
