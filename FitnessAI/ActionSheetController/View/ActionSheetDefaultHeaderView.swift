//
//  ActionSheetDefaultHeaderView.swift
//  FitnessAI
//
//  Created by Manuel on 19/07/21.
//

import UIKit

class ActionSheetDefaultHeaderView: ActionSheetBaseCell {

    @IBOutlet private weak var circularImageView: UIImageView!

    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var messageLabel: UILabel!

    func setHeader(_ header: Header) {
        if let image = header.image {
            circularImageView.image = image
            circularImageView.isHidden = false
        } else {
            circularImageView.isHidden = true
        }
        titleLabel.text = header.title
        messageLabel.text = header.message
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        circularImageView.layer.cornerRadius = circularImageView.frame.height / 2
    }
}
