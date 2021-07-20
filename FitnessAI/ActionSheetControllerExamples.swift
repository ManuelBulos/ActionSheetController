//
//  ActionSheetControllerExamples.swift
//  FitnessAI
//
//  Created by Manuel on 20/07/21.
//

import UIKit

extension ViewController {
    func showExampleOne() {
        let actionSheetController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ActionSheetController") as! ActionSheetController

        present(actionSheetController, animated: true, completion: nil)

        actionSheetController.addHeader(image: nil, title: "Incline Bench", message: "Pro tip: long press and drag an exercise to move it")
        actionSheetController.addAction(title: "Edit Reps or Weight", type: .default, action: { print("Edit Reps or Weight") })
        actionSheetController.addAction(title: "View Alternatives", type: .default, action: { print("View Alternatives") })
        actionSheetController.addAction(title: "Remove", type: .destructive, action: { print("Remove") })
    }

    func showExampleTwo() {
        let actionSheetController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ActionSheetController") as! ActionSheetController

        present(actionSheetController, animated: true, completion: nil)

        let customHeader = UILabel(frame: .init(x: 0, y: 0, width: 100, height: 100))
        customHeader.text = "Custom Header"
        customHeader.textColor = .white
        customHeader.textAlignment = .center
        customHeader.backgroundColor = .systemPink
        actionSheetController.addHeader(view: customHeader)

        actionSheetController.addHeader(image: nil, title: "Incline Bench", message: "Pro tip: long press and drag an exercise to move it")
        actionSheetController.addAction(title: "Edit Reps or Weight", type: .default, action: { print("Edit Reps or Weight") })
        actionSheetController.addAction(title: "View Alternatives", type: .default, action: { print("View Alternatives") })
        actionSheetController.addAction(title: "Remove", type: .destructive, action: { print("Remove") })
    }

    func showExampleThree() {
        let actionSheetController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ActionSheetController") as! ActionSheetController

        present(actionSheetController, animated: true, completion: nil)

        let customHeader = UILabel(frame: .init(x: 0, y: 0, width: 100, height: 100))
        customHeader.text = "Custom Header"
        customHeader.textColor = .white
        customHeader.textAlignment = .center
        customHeader.backgroundColor = .systemPink
        actionSheetController.addHeader(view: customHeader)

        let customFooter = UILabel(frame: .init(x: 0, y: 0, width: 100, height: 100))
        customFooter.text = "Custom Footer"
        customFooter.textColor = .white
        customFooter.textAlignment = .center
        customFooter.backgroundColor = .systemPink
        actionSheetController.addFooter(view: customFooter)

        actionSheetController.addHeader(image: nil, title: "Incline Bench", message: "Pro tip: long press and drag an exercise to move it")
        actionSheetController.addAction(title: "Edit Reps or Weight", type: .default, action: { print("Edit Reps or Weight") })
        actionSheetController.addAction(title: "View Alternatives", type: .default, action: { print("View Alternatives") })
        actionSheetController.addAction(title: "Remove", type: .destructive, action: { print("Remove") })
    }

    func showExampleFour() {
        let actionSheetController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ActionSheetController") as! ActionSheetController

        present(actionSheetController, animated: true, completion: nil)

        actionSheetController.addHeader(image: UIImage(named: "jake"), title: "Jake Mor", message: "Founder at FitnessAI\nMember since '19")
        actionSheetController.addAction(title: "Add Friend", type: .default, action: { print("Add Friend") })
        actionSheetController.addAction(title: "View Stats", type: .default, action: { print("View Stats") })
        actionSheetController.addAction(title: "Block", type: .destructive, action: { print("Block") })
    }

    func showExampleFive() {
        let actionSheetController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ActionSheetController") as! ActionSheetController

        present(actionSheetController, animated: true, completion: nil)

        actionSheetController.addHeader(image: nil, title: "How hard was that set?", message: "Drag the slider")

        let customActionView = UIView(frame: .init(x: 0, y: 0, width: 100, height: 80))
        let slider = UISlider()
        slider.setValue(0.7, animated: true)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(didChangeSliderValue(_:)), for: .valueChanged)

        customActionView.addSubview(slider)

        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: customActionView.leadingAnchor, constant: 16),
            slider.trailingAnchor.constraint(equalTo: customActionView.trailingAnchor, constant: -16),
            slider.centerYAnchor.constraint(equalTo: customActionView.centerYAnchor),
        ])

        actionSheetController.addCustomAction(view: customActionView)
    }

    @objc private func didChangeSliderValue(_ sender: UISlider) {
        print("slider value: ", sender.value)
    }
}
