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
        let titleTrigger: Driver<String>
        let descriptionTrigger: Driver<String>
        let addTaskTrigger: Driver<Void>
        let cancelAddTaskTrigger: Driver<Void>
    }
    
    struct Output {
        let isAddable: Driver<Bool>
        let addTaskResult: Driver<TodoTask>
        let cancelAddTaskResult: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let isAddable = Driver.combineLatest(input.titleTrigger, input.descriptionTrigger) { title, des in
            return !title.isEmpty && !des.isEmpty
        }
        let taskInfo = Driver.combineLatest(input.titleTrigger, input.descriptionTrigger)
        let addTaskResult = input.addTaskTrigger
            .withLatestFrom(taskInfo)
            .map { TodoTask(title: $0.0, description: $0.1) }
        return Output(isAddable: isAddable,
                      addTaskResult: addTaskResult,
                      cancelAddTaskResult: input.cancelAddTaskTrigger)
    }
}
