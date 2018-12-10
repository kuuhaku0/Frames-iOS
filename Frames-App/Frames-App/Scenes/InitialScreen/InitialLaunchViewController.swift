//
//  InitialLaunchViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/5/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class InitialLaunchViewController: UIViewController, FramesSegmentControlDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var pickerView: FramesPickerView!
    @IBOutlet weak var segmentControl: SegmentControl!
    @IBOutlet weak var framesButton: FramesButton!
    
    let images: [UIImage] = [UIImage(named: "a")!,
                             UIImage(named: "b")!,
                             UIImage(named: "c")!,
                             UIImage(named: "d")!,
                             UIImage(named: "e")!,
                             UIImage(named: "f")!,
                             UIImage(named: "g")!]
    
    let segments = [UIImage(named: "box")!, UIImage(named: "play")!, UIImage(named: "grid")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.delegate = self
        segmentControl.setSegmentItems(segments)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        framesButton.titleText = "Get Started"
    }
    
    func segmentControl(_ segmentControl: SegmentControl, didSelectSegment index: Int) {
        print(index)
    }
}

extension InitialLaunchViewController: FramesPickerViewDelegate, FramesPickerViewDataSource {
    
    func framesPickerView(_ pickerView: FramesPickerView, numberOfItems item: Int) -> Int {
        return images.count
    }
    
    func framesPickerView(_ pickerView: FramesPickerView, cellForItem item: Int) -> UIImage {
        return images[item]
    }
    
    func framesPickerView(_ pickerView: FramesPickerView, didSelectItem item: Int) {
        print(item)
    }
    
    func framesPickerView(_ pickerView: FramesPickerView, sizeForItem: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

}
