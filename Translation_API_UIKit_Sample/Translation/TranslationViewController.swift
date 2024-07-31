//
//  TranslationViewController.swift
//  Translation_API_UIKit_Sample
//
//  Created by takahashi.shiko on 2024/06/30.
//

import UIKit
import SwiftUI
import Combine

final class TranslationViewController: UIViewController {
    
    @IBOutlet weak private var inputTextField: UITextField!
    @IBOutlet weak private var translatedTextView: UITextView!
    
    private var translationButtonViewDataSource = TranslationButtonView.DataSource()
    private var cancellableSet: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Translation (UIKit)"
        
        let translationButton = TranslationButtonView(dataSource: translationButtonViewDataSource)
        let hostingController = UIHostingController(rootView: translationButton)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: hostingController.view)
        
        translationButtonViewDataSource.sourceText = inputTextField.text ?? ""
        translationButtonViewDataSource.$targetText
            .receive(on: RunLoop.main)
            .assign(to: \.translatedTextView.text, on: self)
            .store(in: &cancellableSet)
    }
}

extension TranslationViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        translationButtonViewDataSource.sourceText = textField.text ?? ""
    }
}
