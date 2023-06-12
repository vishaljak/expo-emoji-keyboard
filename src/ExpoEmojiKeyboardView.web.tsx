import * as React from 'react';

import { ExpoEmojiKeyboardViewProps } from './ExpoEmojiKeyboard.types';

export default function ExpoEmojiKeyboardView(props: ExpoEmojiKeyboardViewProps) {
  return (
    <div>
      <span>{props.name}</span>
    </div>
  );
}
