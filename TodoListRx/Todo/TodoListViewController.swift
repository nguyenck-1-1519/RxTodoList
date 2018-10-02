//
//  ViewController.swift
//  TodoListRx
//
//  Created by Can Khac Nguyen on 10/2/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then

class TodoListViewController: UIViewController {

    @IBOutlet private weak var todoListTableView: UITableView!
    var viewModel = TodoListViewModel()
    var addTaskSubject = PublishRelay<TodoTask>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
    }
    
    func configView() {
        todoListTableView.do {
            $0.estimatedRowHeight = UITableViewAutomaticDimension
            $0.rowHeight = 60
            $0.register(cellType: TodoTableViewCell.self)
        }
        
        let addTaskButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskButtonClicked(sender:)))
        self.navigationItem.rightBarButtonItem = addTaskButton
    }
    
    func bindViewModel() {
        let input = TodoListViewModel.Input(loadTrigger: Driver.just(()),
                                            addTaskTrigger: addTaskSubject.asDriver(onErrorJustReturn: TodoTask()))
        let output = viewModel.transform(input: input)
        output.todoList
            .drive(todoListTableView.rx.items) { tableView, index, task in
                let indexPath = IndexPath(row: index, section: 0)
                let cell: TodoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setContentWith(title: task.title, description: task.description)
                return cell
            }
            .disposed(by: disposeBag)
        output.addTaskResult
            .drive()
            .disposed(by: disposeBag)
    }
    
    @objc func addTaskButtonClicked(sender: Any) {
        addTaskSubject.accept(TodoTask(title: "task temp", description: "N/A"))
    }
}
