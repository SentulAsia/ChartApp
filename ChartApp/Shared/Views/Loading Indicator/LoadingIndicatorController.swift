//
//  LoadingIndicatorController.swift
//  ChartApp
//
//  Created by Zaid Said on 09/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit

class LoadingIndicatorController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupContentView()
    }

    // MARK: - Content View

    func setupContentView() {
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }

    // MARK: - Use Case

    // MARK: Show

    func show(on sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
        spinner.startAnimating()
    }

    // MARK: Dismiss

    func dismiss() {
        spinner.stopAnimating()
        self.dismiss(animated: false)
    }
}
