//
//  ToastController.swift
//  ChartApp
//
//  Created by Zaid Said on 09/05/2020.
//  Copyright © 2020 Zaid Said. All rights reserved.
//

import UIKit

class ToastController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    var message: String?

    // MARK: - View Lifecycle

    /// Initialize the view controller with message to be shown when presented
    ///
    /// - Parameter message: Message to be shown in the toast
    convenience init(message: String?) {
        self.init()
        self.message = message
        super.modalPresentationStyle = .overFullScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
        setupTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupContentView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.dismiss(self)
        }
    }

    // MARK: - Texts

    func setupTexts() {
        text.text = message
    }

    // MARK: - Content View

    func setupContentView() {
        contentView.layer.cornerRadius = contentView.frame.height / 2
        contentView.clipsToBounds = true
    }

    // MARK: - Tap gesture

    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        tapGesture.cancelsTouchesInView = false
        backgroundView.addGestureRecognizer(tapGesture)
    }

    // MARK: - Use Case

    // MARK: Dismiss

    @objc func dismiss(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.alpha = 0
        }) { [weak self] (completed) in
            self?.dismiss(animated: false)
        }
    }
}
