//
//  TodoListUseCase.swift
//  TodoListRx
//
//  Created by Can Khac Nguyen on 10/3/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import Foundation

protocol TodoListUseCaseType {
    func readTodoListFromLocal() -> [TodoTask]
}

struct TodoListUseCase: TodoListUseCaseType {
    private struct ConstantData {
        static let todoListKey = "todoList"
    }
    
    func readTodoListFromLocal() -> [TodoTask] {
//        var resultArray = [TodoTask]()
//        guard let results = UserDefaults.standard.array(forKey: ConstantData.todoListKey) as? [(title: String, description: String)] else {
//            return resultArray
//        }
//        for result in results {
//            resultArray.append(TodoTask(title: result.title, description: result.description))
//        }
//        return resultArray
        return [TodoTask(title: "task1", description: "Nothing to do here alksdjf lakjdsf lkjsdf lkjsdf lkjadsf lkjasdf lkjasdf lkjsdf ljadsf lkjdsf lkjasdf")]
    }
}
