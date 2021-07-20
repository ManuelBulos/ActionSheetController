//
//  ActionSheetCustomViewCell.swift
//  FitnessAI
//
//  Created by Manuel on 19/07/21.
//

import UIKit

class ActionSheetCustomViewCell: ActionSheetBaseCell {

    private var customView: UIView?

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.roundCorners(corners: roundedCorners, radius: 12)
    }

    func setCustomView(_ customView: UIView) {
        self.customView = customView
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.clipsToBounds = true

        contentView.addSubview(customView)

        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
