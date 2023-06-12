import { NativeModulesProxy, EventEmitter, Subscription } from 'expo-modules-core';

// Import the native module. On web, it will be resolved to ExpoEmojiKeyboard.web.ts
// and on native platforms to ExpoEmojiKeyboard.ts
import ExpoEmojiKeyboardModule from './ExpoEmojiKeyboardModule';
import ExpoEmojiKeyboardView from './ExpoEmojiKeyboardView';
import { ChangeEventPayload, ExpoEmojiKeyboardViewProps } from './ExpoEmojiKeyboard.types';

// Get the native constant value.
export const PI = ExpoEmojiKeyboardModule.PI;

export function hello(): string {
  return ExpoEmojiKeyboardModule.hello();
}

export async function setValueAsync(value: string) {
  return await ExpoEmojiKeyboardModule.setValueAsync(value);
}

const emitter = new EventEmitter(ExpoEmojiKeyboardModule ?? NativeModulesProxy.ExpoEmojiKeyboard);

export function addChangeListener(listener: (event: ChangeEventPayload) => void): Subscription {
  return emitter.addListener<ChangeEventPayload>('onChange', listener);
}

export { ExpoEmojiKeyboardView, ExpoEmojiKeyboardViewProps, ChangeEventPayload };
