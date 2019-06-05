//
//  DetailViewController.swift
//  MVVMAppitecture
//
//  Created by Rupin on 1/17/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet private weak var formalNameLabel: UILabel!
    @IBOutlet private weak var commonNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var nebulaImageView: UIImageView!
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.name
        updateUI()
    }
    
    private func updateUI() {
        formalNameLabel.text = viewModel?.formalName
        commonNameLabel.text = viewModel?.commonName
        dateLabel.text = viewModel?.dateString
        descriptionLabel.text = viewModel?.description
        activityIndicator.startAnimating()
        nebulaImageView.alpha = 0.0
        viewModel?.download() { (imageData, error) -> Void in
            guard let imageData = imageData,
                error == nil else { return }
            OperationQueue.main.addOperation { [weak self] in
                UIView.animate(withDuration: 1.0, animations: {
                    self?.nebulaImageView.alpha = 1.0
                    self?.nebulaImageView.image = UIImage(data: imageData as Data)
//                    self.view.setNeedsDisplay()
                })
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}
