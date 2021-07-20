//
//  ActionSheetFooterView.swift
//  FitnessAI
//
//  Created by Manuel on 19/07/21.
//

import UIKit

class ActionSheetFooterView: UITableViewHeaderFooterView {

    @IBOutlet private weak var blurryBackgroundView: UIVisualEffectView!

    @IBOutlet private weak var button: UIButton!

    var onButtonTap: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        let clearView = UIView()
        clearView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .gray
        backgroundView = clearView
        addPressAnimations()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        blurryBackgroundView.layer.cornerRadius = 12
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        backgroundView?.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .gray
    }

    func setAction(_ action: Action) {
        button.setTitle(action.title, for: .normal)
        button.setTitleColor(action.textColor, for: .normal)
    }

    private func addPressAnimations() {
        button.addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        button.addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }

    @objc private func animateDown() {
        UIView.animate(button,
                blurryBackgroundView,
                transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }

    @objc private func animateUp() {
        UIView.animate(button,
                blurryBackgroundView,
                transform: .identity)
    }

    @IBAction private func buttonTapped(sender: UIButton) {
        onButtonTap?()
    }
}
