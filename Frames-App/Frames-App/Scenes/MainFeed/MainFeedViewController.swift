//
//  MainFeedViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 11/20/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import AWSAppSync

class MainFeedViewController: UIViewController, StoryboardInitializable {
    
    var viewModel: MainFeedViewModel!
    var appSyncClient: AWSAppSyncClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appSyncClient = appDelegate.appSyncClient
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = MainFeedViewModel.Input()
        let output = MainFeedViewModel.Output()
        
    }

}
