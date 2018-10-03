//
//  AddTaskViewController.swift
//  TodoListRx
//
//  Created by can.khac.nguyen on 10/3/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then

class AddTaskViewController: UIViewController {
    
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var addTaskButton: UIButton!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var titleTextField: UITextField!
    var viewModel = AddTaskViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = AddTaskViewModel.Input(titleTrigger: titleTextField.rx.text.orEmpty.asObservable(),
                                           descriptionTrigger: descriptionTextField.rx.text.orEmpty.asObservable(),
                                           addTaskTrigger: addTaskButton.rx.tap.asObservable(),
                                           cancelAddTaskTrigger: cancelButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        output.isAddable
            .bind(to: addTaskButton.rx.isEnabled)
            .disposed(by: disposeBag)
        output.addTaskResult
            .subscribe(onNext: { [unowned self] task in
                self.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "NewTask"), object: TodoTask.self, userInfo: ["data" : task])
            })
            .disposed(by: disposeBag)
        output.cancelAddTaskResult
            .subscribe(onNext: { [unowned self] _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension UIButton {
    open override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
    }
}
