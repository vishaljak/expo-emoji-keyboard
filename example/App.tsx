import { FlashList } from "@shopify/flash-list";
import { EmojiKeyboardView } from "expo-emoji-keyboard";
import { useState } from "react";
import { View, SafeAreaView, Text } from "react-native";

const Card = ({ count }: { count: number }) => {
  const [emoji, setEmoji] = useState("👋");

  return (
    <View>
      <View
        style={{
          flexDirection: "row",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        <EmojiKeyboardView
          value={emoji}
          placeholder="t"
          onSelection={(e) => console.log(e.nativeEvent.value)}
          style={{ width: 45, height: 45 }}
        />
        <Text style={{ fontSize: 16 }}>Title {count}</Text>
      </View>
    </View>
  );
};

export default function App() {
  return (
    <SafeAreaView
      style={{
        flex: 1,
        alignItems: "center",
        borderWidth: 1,
        borderColor: "black",
        justifyContent: "center",
      }}
    >
      <View style={{ flex: 1, width: "100%" }}>
        <FlashList
          data={[
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
            20, 21, 22, 23, 24, 25,
          ]}
          renderItem={({ item }) => <Card count={item} />}
          keyExtractor={(item) => item.toString()}
          estimatedItemSize={100}
        />
      </View>
    </SafeAreaView>
  );
}
