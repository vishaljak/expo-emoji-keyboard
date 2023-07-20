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
        textField.contentVerticalAlignment = .center
        textField.textAlignment = .center
        textField.backgroundColor = .white
        return textField
    }()
    
    func setPlaceholder(_ text: String?) {
        self.textField.placeholder = text ?? ""
    }
    
    func setValue(_ text: String) {
        self.textField.text = text
    }

    func setTextSize(_ size: CGFloat) {
        self.textField.font = UIFont.systemFont(ofSize: size)
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
        
        setupTextFieldConstraints(width: 40, height: 40)
        
        self.textField.emojiDelegate = self
    }
    
    func setupTextFieldConstraints(width: Int, height: Int) {
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: CGFloat(width)),
            textField.heightAnchor.constraint(equalToConstant: CGFloat(height))
        ])
    }
    
    func emojiTextField(_ textField: EmojiTextField, didChange text: String) {
        onSelection?(["value": text])
    }
    
    override var intrinsicContentSize: CGSize {
        return textField.intrinsicContentSize
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
            
            if let newPosition = sender.position(from: sender.endOfDocument, offset: 0) {
                        sender.selectedTextRange = sender.textRange(from: newPosition, to: newPosition)
                    }
        }

        if let dismissKeyboard = sender.text, text.count > 0 {
            self.endEditing(true)    
        }
        
        emojiDelegate?.emojiTextField(self, didChange: sender.text ?? "")
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let newPosition = self.endOfDocument
        self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tintColor = UIColor.clear
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.tintColor = UIColor.clear
        
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        styleTextField()
    }
    
    func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(inputModeDidChange), name: UITextInputMode.currentInputModeDidChangeNotification, object: nil)
        self.font = UIFont.systemFont(ofSize: 30)
    }
    
    @objc func inputModeDidChange(_ notification: Notification) {
        guard isFirstResponder else {
            return
        }
        
        DispatchQueue.main.async {
            [weak self] in self?.reloadInputViews()
        }
    }
    
    func styleTextField() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}


protocol EmojiTextFieldDelegate: AnyObject {
    func emojiTextField(_ textField: EmojiTextField, didChange text: String)
}
