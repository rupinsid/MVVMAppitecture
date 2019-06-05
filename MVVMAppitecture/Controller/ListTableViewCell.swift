//
//  ListTableViewCell.swift
//  MVVMAppitecture
//
//  Created by Rupin on 1/16/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: ViewModel! {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI() {
        titleLabel.accessibilityIdentifier = "CellTitleIdentifier"
        subTitleLabel.accessibilityIdentifier = "CellSubTitleIdentifier"
        imgView.image = nil
        titleLabel.text = viewModel.formalName
        subTitleLabel.text = viewModel.commonName
        activityIndicator.startAnimating()
        viewModel?.download() { (imageData, error) -> Void in
            guard let imageData = imageData,
                error == nil else { return }
            OperationQueue.main.addOperation { [weak self] in
                self?.imgView.image = UIImage(data: imageData as Data)
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}
