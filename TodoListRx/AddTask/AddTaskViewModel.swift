//
//  AddTaskViewModel.swift
//  TodoListRx
//
//  Created by can.khac.nguyen on 10/3/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct AddTaskViewModel {
    struct Input {
        let titleTrigger: Observable<String>
        let descriptionTrigger: Observable<String>
        let addTaskTrigger: Observable<Void>
        let cancelAddTaskTrigger: Observable<Void>
    }
    
    struct Output {
        let isAddable: Observable<Bool>
        let addTaskResult: Observable<TodoTask>
        let cancelAddTaskResult: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        let isAddable = Observable.combineLatest(input.titleTrigger, input.descriptionTrigger) { title, des in
            return !title.isEmpty && !des.isEmpty
        }
        let taskInfo = Observable.combineLatest(input.titleTrigger, input.descriptionTrigger)
        let addTaskResult = input.addTaskTrigger
            .withLatestFrom(taskInfo)
            .map { TodoTask(title: $0.0, description: $0.1) }
        return Output(isAddable: isAddable,
                      addTaskResult: addTaskResult,
                      cancelAddTaskResult: input.cancelAddTaskTrigger)
    }
}
