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
            emojiKeyboardView.topAnchor.constraint(equalTo: self.topAnchor),
            emojiKeyboardView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            emojiKeyboardView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emojiKeyboardView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return emojiKeyboardView.intrinsicContentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        emojiKeyboardView.frame = bounds
    }
}
