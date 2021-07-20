//
//  ViewController.swift
//  FitnessAI
//
//  Created by Manuel on 19/07/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var examples: [String] = {
        return ["Default header + Actions",
                "Custom header + Default header + Actions",
                "Custom header + Default header + Custom footer + Actions",
                "Default header (with image) + Actions",
                "Default header + Custom Action (slider)"]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Example \(indexPath.row + 1)\n" + examples[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            showExampleOne()
        } else if indexPath.row == 1 {
            showExampleTwo()
        } else if indexPath.row == 2 {
            showExampleThree()
        } else if indexPath.row == 3 {
            showExampleFour()
        } else if indexPath.row == 4 {
            showExampleFive()
        }
    }
}
