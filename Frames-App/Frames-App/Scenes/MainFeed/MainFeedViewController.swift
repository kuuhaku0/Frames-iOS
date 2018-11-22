//
//  MainFeedViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 11/20/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class MainFeedViewController: UIViewController {
    
    var viewModel: MainFeedViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = MainFeedViewModel.Input()
        let output = MainFeedViewModel.Output()
        
    }
    
}
