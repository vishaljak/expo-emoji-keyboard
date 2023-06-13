import { requireNativeViewManager } from 'expo-modules-core';
import * as React from 'react';

import { ExpoEmojiKeyboardViewProps } from './ExpoEmojiKeyboard.types';

const NativeView: React.ComponentType<ExpoEmojiKeyboardViewProps> =
  requireNativeViewManager('ExpoEmojiKeyboard');

export default function ExpoEmojiKeyboardView(props: ExpoEmojiKeyboardViewProps) {
  return <NativeView {...props} />;
}
