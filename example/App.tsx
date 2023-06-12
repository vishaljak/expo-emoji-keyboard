import { EmojiKeyboardView } from "expo-emoji-keyboard";
import { useState } from "react";
import { SafeAreaView, Text } from "react-native";

export default function App() {
  const [emoji, setEmoji] = useState("👋");

  return (
    <SafeAreaView
      style={{ flex: 1, alignItems: "center", justifyContent: "center" }}
    >
      <EmojiKeyboardView
        value={emoji}
        placeholder="E"
        onSelection={(e) => setEmoji(e.nativeEvent.value)}
        style={{ flex: 1 }}
      />
      <Text style={{ flex: 1 }}>The selected emoji is {emoji}</Text>
    </SafeAreaView>
  );
}
