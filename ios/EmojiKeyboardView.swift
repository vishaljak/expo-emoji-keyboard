//
//  EmojiKeyboardView.swift
//  ExpoEmojiKeyboard
//
//  Created by Vishal Jakhar on 12/6/2023.
//

import Foundation
import ExpoModulesCore
import UIKit

class EmojiKeyboardView: UIView, EmojiTextFieldDelegate {
    var onSelection: EventDispatcher? = nil
    
    let textField: EmojiTextField = {
        let textField = EmojiTextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray2
        return textField
    }()
    
    func setPlaceholder(_ text: String?) {
        self.textField.placeholder = text ?? ""
    }
    
    func setValue(_ text: String) {
        self.textField.text = text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true) // dismiss keyboard on touch outside the text field
    }
    
    func setEventDispatcher(_ eventDispatcher: EventDispatcher) {
        self.onSelection = eventDispatcher
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(textField)
        self.textField.emojiDelegate = self
        self.textField.frame = CGRect(x: 20, y: 100, width: 50, height: 40)
    }
    
    func emojiTextField(_ textField: EmojiTextField, didChange text: String) {
        onSelection?(["value": text])
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}

class EmojiTextField: UITextField {
    weak var emojiDelegate: EmojiTextFieldDelegate?
    
    // required for iOS 13
    override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯
    
    override var canBecomeFirstResponder: Bool { return true }
    override var canResignFirstResponder: Bool { return true }
    
    override var textInputMode: UITextInputMode? {
        .activeInputModes.first(where: { $0.primaryLanguage == "emoji" } )
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
    }
    
    @objc private func editingChanged(sender: UITextField) {
        if let text = sender.text, text.count > 1 {
            sender.text = String(text.suffix(1))
            emojiDelegate?.emojiTextField(self, didChange: sender.text ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(inputModeDidChange), name: UITextInputMode.currentInputModeDidChangeNotification, object: nil)
    }
    
    @objc func inputModeDidChange(_ notification: Notification) {
        guard isFirstResponder else {
            return
        }
        
        DispatchQueue.main.async {
            [weak self] in self?.reloadInputViews()
        }
    }
}


protocol EmojiTextFieldDelegate: AnyObject {
    func emojiTextField(_ textField: EmojiTextField, didChange text: String)
}
