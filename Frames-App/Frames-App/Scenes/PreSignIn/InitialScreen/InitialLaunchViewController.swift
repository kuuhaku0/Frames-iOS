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

class InitialLaunchViewController: UIViewController, StoryboardInitializable, FramesPickerViewDelegate {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
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
        framesPickerView.isUserInteractionEnabled = false
        perform(#selector(scrollTo), with: nil, afterDelay: TimeInterval(0.5))
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let input = InitialLaunchViewModel.Input(signUpTigger: signUpButton.rx.tap.asObservable(),
                                                 signInTrigger: signInButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.images$.drive(framesVC.collectionView.rx
            .items(cellIdentifier: NSStringFromClass(FramesPickerViewCell.self), cellType: FramesPickerViewCell.self)) { tv, viewModel, cell in
                cell.configure()
                cell.imageView.image = viewModel
            }
            .disposed(by: disposeBag)
        
        framesVC?.rx.didSelectItem
            .asObservable()
            .withLatestFrom(output.images$.asObservable(), resultSelector: { int, images  in
                return images[int]
            })
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    @objc func scrollTo() {
        captionLabel.isHidden = false
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
