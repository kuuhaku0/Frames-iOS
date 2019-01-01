//
//  DiscoverPageViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 11/20/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class DiscoverPageViewController: UIViewController, StoryboardInitializable {

    var viewModel: DiscoverPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func bindViewModel() {
        
        let input = DiscoverPageViewModel.Input()
        let output = DiscoverPageViewModel.Output()
        
    }

}
