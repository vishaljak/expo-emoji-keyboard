import { requireNativeViewManager } from "expo-modules-core";
import * as React from "react";
import type { ViewProps } from "react-native";

export type Props = {
  value: string;
  placeholder?: string;
  textSize?: number;
  size: number;
  onSelection: (event: { nativeEvent: { value: string } }) => void;
} & ViewProps;

const NativeView: React.ComponentType<Props> =
  requireNativeViewManager("ExpoEmojiKeyboard");

export default function ExpoEmojiKeyboardView(props: Props) {
  return <NativeView {...props} />;
}
