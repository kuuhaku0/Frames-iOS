//
//  SignUpViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/4/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet weak var createAccountButton: FramesButton!
    @IBOutlet weak var disclaimerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SignUpViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    private func setup() {
        navigationItem.title = "Create an Account"
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FramesTextFieldCell.self, forCellReuseIdentifier: "FramesTextFieldCell")
        tableView.contentOffset = CGPoint(x: 0, y: 20)
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = SignUpViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.formCellDataSource
            .drive(tableView.rx.items(cellIdentifier: "FramesTextFieldCell", cellType: FramesTextFieldCell.self)) { tv, vm, cell in
                cell.configure(title: vm.title, description: vm.description, placeHolder: vm.placeholder)
        }
        .disposed(by: disposeBag)
        
    }
}
