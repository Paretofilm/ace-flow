# Button

Button allows users to perform actions.

[ARIA pattern](https://www.w3.org/WAI/ARIA/apg/patterns/button/) [Theme source](https://github.com/aws-amplify/amplify-ui//blob/main/packages/ui/src/theme/tokens/components/button.ts) [React source](https://github.com/aws-amplify/amplify-ui//blob/main/packages/react/src/primitives/Button/Button.tsx)

## Usage

Import the Button primitive and styles.

```jsx
import { Button } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

<Button>Hello world</Button>;
```

### onClick

Use the `onClick` prop to add a click handler to the Button.

```jsx
<Button onClick={() => alert('👋 hello')}>Click me</Button>
```

### Sizes

Use the `size` prop to change the Button size. Available options are `small`, `large`, and none (default).

```jsx
<Button size="small">Small</Button>
<Button>Default</Button>
<Button size="large">Large</Button>
```

### Variations

Use the `variation` prop to change the Button variation. Available options are `primary`, `link`, `menu`, `warning`, `destructive` and none (default).

```jsx
<Button>Default</Button>
<Button variation="primary">Primary</Button>
<Button variation="link">Link</Button>
```

### Color themes

Use the `colorTheme` prop to change the Button's color theme. Available options are `error`, `info`, `warning`, `success`, and `overlay`.

```jsx
<Button>Default</Button>
<Button colorTheme="success">Success</Button>
<Button colorTheme="warning">Warning</Button>
<Button colorTheme="error">Error</Button>
<Button colorTheme="info">Info</Button>
<Button colorTheme="overlay">Overlay</Button>
```

The `colorTheme` prop can be combined with `variation` to provide more Button options.

```jsx
// Primary variation with color themes
<Button variation="primary" colorTheme="success">Success</Button>
<Button variation="primary" colorTheme="error">error</Button>
<Button variation="primary" colorTheme="warning">Warning</Button>
<Button variation="primary" colorTheme="info">Info</Button>
<Button variation="primary" colorTheme="overlay">Overlay</Button>

// Link variation with color themes
<Button variation="link" colorTheme="success">Success</Button>
<Button variation="link" colorTheme="error">error</Button>
<Button variation="link" colorTheme="warning">Warning</Button>
<Button variation="link" colorTheme="info">Info</Button>
<Button variation="link" colorTheme="overlay">Overlay</Button>
```

### Icon buttons

Icons can be added to buttons and will adapt to the surrounding font-size.

```tsx
import * as React from 'react';
import { Button, Flex, Icon, View } from '@aws-amplify/ui-react';

const IconSave = () => {
  return (
    <Icon
      ariaLabel=""
      pathData="M17 3H5C3.89 3 3 3.9 3 5V19C3 20.1 3.89 21 5 21H19C20.1 21 21 20.1 21 19V7L17 3ZM19 19H5V5H16.17L19 7.83V19ZM12 12C10.34 12 9 13.34 9 15C9 16.66 10.34 18 12 18C13.66 18 15 16.66 15 15C15 13.34 13.66 12 12 12ZM6 6H15V10H6V6Z"
    />
  );
};

export const IconButtonExample = () => {
  return (
    <Flex direction="column" gap="1rem">
      <View>
        <Button gap="0.1rem" size="small">
          <IconSave /> Save
        </Button>
        <Button gap="0.2rem">
          <IconSave /> Save
        </Button>
        <Button gap="0.2rem" size="large">
          <IconSave /> Save
        </Button>
      </View>
      <View>
        <Button size="small">
          <IconSave />
        </Button>
        <Button>
          <IconSave />
        </Button>
        <Button size="large">
          <IconSave />
        </Button>
      </View>
    </Flex>
  );
};
```

### Loading state

```jsx
<Button isLoading={true} loadingText="Loading..." variation="primary">
  Hello
</Button>
```

### Other states

```jsx
<Button isDisabled={true}>Disabled</Button>
<Button isFullWidth={true}>Full width</Button>
```

### Accessibility

Setting an `aria-label` attribute for an icon Button:

```jsx
<Button ariaLabel="To the moon!">🚀</Button>
```

### ButtonGroup

Use a `ButtonGroup` to group buttons with the same `size` or `variation`.

```jsx
import { Button, ButtonGroup } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

// same size
<ButtonGroup size="small">
  <Button>🚀</Button>
  <Button>🚀</Button>
  <Button>🚀</Button>
</ButtonGroup>;

// same variation
<ButtonGroup variation="primary">
  <Button>🚀</Button>
  <Button>🚀</Button>
  <Button>🚀</Button>
</ButtonGroup>;
```

`ButtonGroup` is also a flex container, so any flex props can apply to it for layout purpose. See [Flex](https://ui.docs.amplify.aws/components/flex).

```jsx
import { Button, ButtonGroup } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

<ButtonGroup justifyContent="center">
  <Button>🚀</Button>
  <Button>🚀</Button>
  <Button>🚀</Button>
</ButtonGroup>

<ButtonGroup direction="column">
  <Button>🚀</Button>
  <Button>🚀</Button>
  <Button>🚀</Button>
</ButtonGroup>;
```

### Standard HTML attributes

The `Button` will accept any of the standard HTML attributes that a `<button>` element accepts.
Standard `<button>` attributes can be found in the [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/Button#attributes)

```jsx
<Button name="named">Named</Button>
```

## Customization

### Theme

You can customize the appearance of all Button components in your application with a [Theme](https://ui.docs.amplify.aws/theming).

[Button Theme Source](https://github.com/aws-amplify/amplify-ui//blob/main/packages/ui/src/theme/tokens/components/button.ts)

```tsx
import { Button, Flex, ThemeProvider, Theme } from '@aws-amplify/ui-react';

const theme: Theme = {
  name: 'button-theme',
  tokens: {
    colors: {
      border: {
        // this will affect the default button's border color
        primary: { value: 'black' },
      },
    },
    components: {
      button: {
        // this will affect the font weight of all button variants
        fontWeight: { value: '{fontWeights.extrabold}' },
        backgroundColor: { value: '#f1fff5' },
        borderColor: { value: '{colors.purple.80}' },
        color: { value: '{colors.purple.100}' },
        outlined: {
          info: {
            borderColor: '{colors.purple.60}',
            color: '{colors.purple.90}',
          },
        },

        // style the primary variation
        primary: {
          backgroundColor: { value: '{colors.blue.60}' },
          _hover: {
            backgroundColor: { value: '{colors.blue.80}' },
          },
          _focus: {
            backgroundColor: { value: '{colors.blue.80}' },
          },
          _active: {
            backgroundColor: { value: '{colors.blue.90}' },
          },
          _disabled: {
            backgroundColor: { value: 'transparent' },
            borderColor: { value: '{colors.neutral.30}' },
          },
          error: {
            backgroundColor: { value: '{colors.pink.10}' },
            color: { value: '{colors.red.80}' },
            _hover: {
              backgroundColor: { value: '#a51b34' },
            },
            _focus: {
              backgroundColor: { value: '#9a0c26' },
            },
            _active: {
              backgroundColor: { value: '#9a0c26' },
            },
          },
        },
      },
    },
  },
};

export const ButtonThemeExample = () => (
  <ThemeProvider theme={theme} colorMode="light">
    <Flex direction="row">
      <Button>Default</Button>
      <Button variation="primary">Primary</Button>
      <Button variation="primary" colorTheme="error">
        Primary error
      </Button>
      <Button variation="primary" isDisabled={true}>
        Primary (disabled)
      </Button>
      <Button colorTheme="info">Default info</Button>
    </Flex>
  </ThemeProvider>
);
```

### Target classes

| Class | Description |
| --- | --- |
| `amplify-button` | Top level element that wraps the Button primitive |
| `amplify-button__loader-wrapper` | Class applied to the Loader component within the Button Loading state |

### CSS Variables

The Button component supports extensive CSS variable customization. Key variables include:

- `--amplify-components-button-background-color`
- `--amplify-components-button-border-color`
- `--amplify-components-button-color`
- `--amplify-components-button-font-size`
- `--amplify-components-button-padding-*`
- And many more for different variations and states

### CSS

To override styling on all Buttons, you can set the Amplify CSS variables or use the built-in `.amplify-button` class.

```css
/* styles.css */
[data-amplify-theme] {
  --amplify-components-button-primary-background-color: #0057ff;
  --amplify-components-button-primary-hover-background-color: #4d89fc;
}
/* OR */
.amplify-button {
  background-color: #0057ff;
}
.amplify-button:hover {
  background-color: #4d89fc;
}
```

To replace the Button styling, unset it:

```css
.amplify-button {
  all: unset;
  /* Add your styling here*/
}
```

### Local styling

To override styling on a specific Button, you can use (in order of increasing specificity): a class selector, data attributes, or style props.

_Using a class selector:_

```css
/* Example: class selector styling override */
.colorful-button {
  background: linear-gradient(90deg, #fdbb2d 0%, #22c1c3 100%);
}
```

```jsx
import './styles.css';

<Button className="colorful-button">I'm colorful!</Button>;
```

_Using data attributes:_

```css
/* styles.css */
/* Override only primary variation styles */
.amplify-button[data-variation='primary'] {
  background-color: teal;
  color: white;
}

/* Override loading styles */
.amplify-button[data-loading='true'] {
  opacity: 0.8;
}

/* Override disabled styles */
.amplify-button[disabled='true'] {
  opacity: 0.8;
}
```

```jsx
import './styles.css';

<Button variation="primary">Teal background</Button>
<Button isLoading={true}>Loading...</Button>
<Button isDisabled={true}>Lighter opacity</Button>
```

_Using style props:_

```jsx
<Button style={{ backgroundColor: 'green', color: 'white' }}>Green</Button>;
{/* OR */}
<Button backgroundColor="purple" color="white">
  Purple
</Button>;
```