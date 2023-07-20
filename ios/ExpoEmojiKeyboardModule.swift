import ExpoModulesCore

public class ExpoEmojiKeyboardModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoEmojiKeyboard")

    View(ExpoEmojiKeyboardView.self) {
        Events("onSelection")
    
      Prop("placeholder") { (view: ExpoEmojiKeyboardView, text: String) in
          view.emojiKeyboardView.setPlaceholder(text)
      }
        
        Prop("value") { (view, value: String) in
            view.emojiKeyboardView.setValue(value)
        }

        Prop("textSize") { (view, size: NSNumber) in
            view.emojiKeyboardView.setTextSize(CGFloat(size.floatValue))
        }
    }
  }
}
