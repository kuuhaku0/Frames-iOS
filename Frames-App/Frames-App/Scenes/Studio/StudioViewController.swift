//
//  StudioViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 11/20/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class StudioViewController: UIViewController {
    
    var viewModel: StudioViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func bindViewModel() {
        assert(viewModel != nil)
        
        let input = StudioViewModel.Input()
        let output = StudioViewModel.Output()
    }

}
