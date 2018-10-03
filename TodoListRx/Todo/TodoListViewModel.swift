//
//  TodoListViewModel.swift
//  TodoListRx
//
//  Created by Can Khac Nguyen on 10/3/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct TodoListViewModel {
    struct Input {
        let loadTrigger: Observable<Void>
        let addTaskTrigger: Observable<TodoTask>
    }
    
    struct Output {
        let todoList: Observable<[TodoTask]>
        let addTaskResult: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        let todoList = BehaviorRelay<[TodoTask]>(value: [TodoTask(title: "task1", description: "Nothing")])
        let addTaskResult = input.addTaskTrigger
            .withLatestFrom(todoList.asDriver()) { task, todos in
                var listTask = todos
                listTask.append(task)
                todoList.accept(listTask)
        }
        return Output(todoList: todoList.asObservable(),
                      addTaskResult: addTaskResult)
    }
}
