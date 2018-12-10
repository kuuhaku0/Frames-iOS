//
//  InitialLaunchViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/5/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class InitialLaunchViewController: UIViewController, FramesSegmentControlDelegate {
    
    @IBOutlet weak var pickerView: FramesPickerView!
    @IBOutlet weak var segmentControl: SegmentControl!
    
    let segments = [UIImage(named: "box")!, UIImage(named: "play")!, UIImage(named: "grid")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.delegate = self
        segmentControl.setSegmentItems(segments)
    }
    
    func segmentControl(_ segmentControl: SegmentControl, didSelectSegment index: Int) {
        print(index)
    }
}
