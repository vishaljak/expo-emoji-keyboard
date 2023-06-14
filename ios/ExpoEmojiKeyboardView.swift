import ExpoModulesCore

// This view will be used as a native component. Make sure to inherit from `ExpoView`
// to apply the proper styling (e.g. border radius and shadows).
class ExpoEmojiKeyboardView: ExpoView {
    let emojiKeyboardView = EmojiKeyboardView()
    let onSelection = EventDispatcher()
    
    required init(appContext: AppContext? = nil) {
        super.init(appContext: appContext)
        
        clipsToBounds = true
        addSubview(emojiKeyboardView)
        emojiKeyboardView.setEventDispatcher(onSelection)
        
        emojiKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emojiKeyboardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emojiKeyboardView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return emojiKeyboardView.intrinsicContentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
