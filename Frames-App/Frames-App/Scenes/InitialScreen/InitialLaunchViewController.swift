//
//  InitialLaunchViewController.swift
//  Frames-App
//
//  Created by Tyler Zhao on 12/5/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InitialLaunchViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var framesImagePicker: FramesPickerView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: FramesButton!
    @IBOutlet weak var captionLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: InitialLaunchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        perform(#selector(scrollTo), with: nil, afterDelay: TimeInterval(0.5))

        framesImagePicker.rx.didSelectItem
            .asObservable()
            .subscribe { (index) in
                guard let index = index.element else { return }
                self.imageView.image = self.viewModel.images[index]
            }
            .disposed(by: disposeBag)
    }
    
    private func setup() {
        captionLabel.isHidden = true
        imageView.image = viewModel.images.last
        framesImagePicker.delegate = self
        framesImagePicker.dataSource = self
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let input = InitialLaunchViewModel.Input(signUpTigger: signUpButton.rx.tap.asDriver(),
                                                 signInTrigger: signInButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.signIn
            .drive()
            .disposed(by: disposeBag)
        
        output.signUp
            .drive()
            .disposed(by: disposeBag)
        
    }
    
    @objc func scrollTo() {
        captionLabel.isHidden = false
        captionLabel.alpha = 0
        framesImagePicker.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: { [weak self] in
            self?.framesImagePicker.scrollToLastItem()
        }, completion: { [weak self] (finished) in
            self?.framesImagePicker.isUserInteractionEnabled = finished
            UIView.animate(withDuration: 2, animations: {
                self?.captionLabel.alpha = 1
            })
        })
    }
}

extension InitialLaunchViewController: FramesPickerViewDelegate, FramesPickerViewDataSource {
    
    func framesPickerView(_ pickerView: FramesPickerView, numberOfItems item: Int) -> Int {
        return viewModel.images.count
    }
    
    func framesPickerView(_ pickerView: FramesPickerView, cellForItem item: Int) -> UIImage {
        return viewModel.images.reversed()[item]
    }

}
