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

class InitialLaunchViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: FramesButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var framesPickerView: UIView!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: InitialLaunchViewModel!
    weak var framesVC: FramesPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "childVC1" {
            if let destination = segue.destination as? FramesPickerView {
                self.framesVC = destination
            }
        }
    }
    
    private func setup() {
        captionLabel.isHidden = true
        captionLabel.alpha = 0
        navigationController?.isNavigationBarHidden = true
        
        framesVC?.rx.setDataSource(self)
            .disposed(by: disposeBag)
        
        framesVC?.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        perform(#selector(scrollTo), with: nil, afterDelay: TimeInterval(0.5))
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
        
        framesVC?.rx.didSelectItem
            .asObservable()
            .subscribe { (index) in
                guard let index = index.element else { return }
                output.images$.map ({ [weak self] image in
                    self?.imageView.image = image[index]
                })
                    .drive()
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
        output.images$.map({ image in
            self.imageView.image = image.first
        })
            .drive()
            .disposed(by: disposeBag)
    }
    
    @objc func scrollTo() {
        captionLabel.isHidden = false
        framesPickerView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseInOut, animations: { [weak self] in
            self?.framesVC?.scrollToLastItem()
        }, completion: { [weak self] (finished) in
            self?.framesPickerView.isUserInteractionEnabled = true
            UIView.animate(withDuration: 2, animations: {
                self?.captionLabel.alpha = 1
            })
        })
    }
}

extension InitialLaunchViewController: FramesPickerViewDelegate, FramesPickerViewDataSource {

    func framesPickerView(_ pickerView: FramesPickerView, numberOfItems item: Int) -> Int {
        return 7
    }

    func framesPickerView(_ pickerView: FramesPickerView, cellForItem item: Int) -> UIImage {
        return #imageLiteral(resourceName: "d")
    }
    
    
}
