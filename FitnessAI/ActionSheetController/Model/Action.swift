//
//  Action.swift
//  FitnessAI
//
//  Created by Manuel on 19/07/21.
//

import UIKit

struct Action {
    let title: String
    let type: UIAlertAction.Style
    let action: (() -> Void)?

    let textColor: UIColor

    init(title: String, type: UIAlertAction.Style, action: (() -> Void)?) {
        self.title = title
        self.type = type
        self.action = action

        switch type {
        case .default:
            self.textColor = UIColor.systemBlue
        case .cancel:
            self.textColor = UIColor.systemBlue
        case .destructive:
            self.textColor = UIColor.systemRed
        default:
            self.textColor = UIColor.systemBlue
        }
    }
}
