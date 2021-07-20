//
//  ActionSheetController.swift
//  FitnessAI
//
//  Created by Manuel on 19/07/21.
//

import UIKit

class ActionSheetController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var items = [ActionSheetItemType]()

    private var didSetCustomHeader: Bool = false

    private var didSetDefaultHeader: Bool = false

    private var didSetCustomFooter: Bool = false

    // MARK: - Private

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegateAndDataSource()
        registerTableViewSubViews()
        addTappableBackgroundViewToTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showBackgroundColorAnimated()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewTopInset()
    }

    private func setTableViewDelegateAndDataSource() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerTableViewSubViews() {
        tableView.register(ActionSheetTextCell.self, forCellReuseIdentifier: "ActionSheetTextCell")
        tableView.register(ActionSheetCustomViewCell.self, forCellReuseIdentifier: "ActionSheetCustomViewCell")

        let headerNib = UINib(nibName: "ActionSheetDefaultHeaderView", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "ActionSheetDefaultHeaderView")

        let footerNib = UINib(nibName: "ActionSheetFooterView", bundle: nil)
        tableView.register(footerNib, forHeaderFooterViewReuseIdentifier: "ActionSheetFooterView")
    }

    private func showBackgroundColorAnimated() {
        UIView.animate(withDuration: 0.3, delay: 0.25, options: .allowUserInteraction) { [weak self] in
            self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }

    /// Sets tableView backgroundView to a new UIView that supports tap to dismiss gesture
    private func addTappableBackgroundViewToTableView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissControllerAnimated))
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        backgroundView.addGestureRecognizer(tapGesture)
        tableView.backgroundView = backgroundView
    }

    /// Adds a top inset to the tableview to make it look like the list starts from the bottom and each row adds height to the content view
    private func updateTableViewTopInset() {
        DispatchQueue.main.async {
            let inset = self.view.frame.height - self.tableView.contentSize.height
            self.tableView.contentInset = UIEdgeInsets(top: inset < 0 ? 0 : inset, left: 0, bottom: 0, right: 0)
        }
    }

    private func scrollToLastRowIfTableViewContentSizeHeightIsLessThanViewHeight() {
        if tableView.contentSize.height < view.frame.height {
            let bottomOffset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.height + tableView.contentInset.bottom)
            tableView.setContentOffset(bottomOffset, animated: true)
        }
    }

    /// Animates a background color change and dismisses the controller when animation finishes
    @objc private func dismissControllerAnimated() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.view.backgroundColor = .clear
        } completion: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Public

    /// Adds custom view at the very top
    func addHeader(view: UIView) {
        didSetCustomHeader = true
        items.insert(.customView(view), at: 0)
        tableView.reloadData()
    }

    /// Adds default header below custom header if exists, otherwise at the very top
    func addHeader(image: UIImage?, title: String?, message: String?) {
        didSetDefaultHeader = true

        let header = Header(image: image, title: title, message: message)

        if didSetCustomHeader {
            items.insert(.header(header), at: 1)
        } else {
            items.insert(.header(header), at: 0)
        }

        tableView.reloadData()
    }

    /// Adds custom view below default header if exists, otherwise below custom header, otherwise at the very top
    func addFooter(view: UIView) {
        if didSetCustomHeader && didSetDefaultHeader {
            items.insert(.customView(view), at: 2)
        } else if didSetCustomHeader || didSetDefaultHeader {
            items.insert(.customView(view), at: 1)
        } else {
            items.insert(.customView(view), at: 0)
        }
    }

    /// Adds an action
    func addAction(title: String, type: UIAlertAction.Style, action: (() -> ())? = nil) {
        let action = Action(title: title, type: type, action: action)
        items.append(.action(action))
        tableView.reloadData()
    }

    /// Adds a custom view
    func addCustomAction(view: UIView) {
        items.append(.customView(view))
        tableView.reloadData()
    }
}

// MARK: - UTableView

extension ActionSheetController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Rows

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let actionSheetCell: ActionSheetBaseCell

        switch items[indexPath.row] {
        case .header(let header):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionSheetDefaultHeaderView") as! ActionSheetDefaultHeaderView
            cell.setHeader(header)
            actionSheetCell = cell

        case .action(let action):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionSheetTextCell") as! ActionSheetTextCell
            cell.setAction(action)
            actionSheetCell = cell

        case .customView(let customView):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionSheetCustomViewCell") as! ActionSheetCustomViewCell
            cell.setCustomView(customView)
            actionSheetCell = cell
        }

        if indexPath.row == 0 {
            actionSheetCell.roundedCorners = [.topLeft, .topRight]
        } else if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            actionSheetCell.roundedCorners = [.bottomLeft, .bottomRight]
        } else {
            actionSheetCell.roundedCorners = []
        }

        return actionSheetCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch items[indexPath.row] {

        case .action, .header:
            return UITableView.automaticDimension

        case .customView(let customView):
            return customView.frame.height
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ActionSheetTextCell {
            cell.action?.action?()
            dismissControllerAnimated()
        }
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ActionSheetTextCell else { return }
        UIView.animate(cell.label, transform: .init(scaleX: 0.95, y: 0.95))
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ActionSheetTextCell else { return }
        UIView.animate(cell.label, transform: .identity)
    }

    // MARK: - Footer

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ActionSheetFooterView") as! ActionSheetFooterView
        footerView.onButtonTap = { [weak self] in
            self?.dismissControllerAnimated()
        }
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }

    // MARK: - UIScrollView

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollToLastRowIfTableViewContentSizeHeightIsLessThanViewHeight()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollToLastRowIfTableViewContentSizeHeightIsLessThanViewHeight()
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollToLastRowIfTableViewContentSizeHeightIsLessThanViewHeight()
    }
}
