//
//  InitialLaunchViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/5/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class InitialLaunchViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var framesImagePicker: FramesPickerView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: FramesButton!
    
    let images: [UIImage] = [UIImage(imageLiteralResourceName: "Logo"),
                             UIImage(imageLiteralResourceName: "Logo2"),
                             UIImage(imageLiteralResourceName: "Logo3"),
                             UIImage(imageLiteralResourceName: "Logo4"),
                             UIImage(imageLiteralResourceName: "Logo5"),
                             UIImage(imageLiteralResourceName: "Logo6"),
                             UIImage(imageLiteralResourceName: "Logo7")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = images.last
        framesImagePicker.delegate = self
        framesImagePicker.dataSource = self
        perform(#selector(scrollTo), with: nil, afterDelay: TimeInterval(0.5))
    }
    
    @objc func scrollTo() {
        framesImagePicker.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: {
            self.framesImagePicker.scrollToLastItem()
        }, completion: { (finished) in
            self.framesImagePicker.isUserInteractionEnabled = finished
        })
    }
}

extension InitialLaunchViewController: FramesPickerViewDelegate, FramesPickerViewDataSource {
    
    func framesPickerView(_ pickerView: FramesPickerView, numberOfItems item: Int) -> Int {
        return images.count
    }
    
    func framesPickerView(_ pickerView: FramesPickerView, cellForItem item: Int) -> UIImage {
        return images.reversed()[item]
    }
    
    func framesPickerView(_ pickerView: FramesPickerView, didSelectItem item: Int) {
        imageView.image = images.reversed()[item]
    }
    
    func framesPickerView(_ pickerView: FramesPickerView, sizeForItem: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

}
