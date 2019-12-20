//
//  ViewController.swift
//  LocalizeApp
//
//  Created by Vaifat on 12/19/19.
//  Copyright © 2019 Vaifat. All rights reserved.
//

import UIKit
import Localize_Swift

private let TITLE_LABEL = "title_label"
private let LANG_BUTTON = "language_button"

class ViewController: UIViewController {

    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    private let localization = Localization()
    
    private var changeLanguageHandler: ((UIAlertAction) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
        setupViews()
    }
    
    fileprivate func setupLocalization(){
        titleLabel.text = TITLE_LABEL.localized()
        languageButton.setTitle(LANG_BUTTON.localized(), for: .normal)
    }
    
    fileprivate func setupViews(){
        languageButton.addTarget(self, action: #selector(handleLanguageButton), for: .touchUpInside)
        
        changeLanguageHandler = {
            print("Action title: \($0.title ?? "N/A")")
            if let key = self.localization.convertReableKeyToLanguageKey(readableKey: $0.title!) {
                self.localization.setCurrentLanguage(key: key)
                self.setupLocalization()
                print("Language code: \(key.rawValue)")
            }
        }
    }
    
    @objc func handleLanguageButton(){
        let bottomSheetController = UIAlertController(title: "Select Language", message: "Choose your preferred language", preferredStyle: .actionSheet)
        for languageKey in localization.readableLanuguageKeys {
            let languageAction = UIAlertAction(title: languageKey, style: .default, handler: changeLanguageHandler)
            bottomSheetController.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        bottomSheetController.addAction(cancelAction)
        present(bottomSheetController, animated: true, completion: nil)
    }
    
}

