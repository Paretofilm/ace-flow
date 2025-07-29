# TextField

TextField allows users to input text content.

[Theme source](https://github.com/aws-amplify/amplify-ui//blob/main/packages/ui/src/theme/tokens/components/textField.ts) [React source](https://github.com/aws-amplify/amplify-ui//blob/main/packages/react/src/primitives/TextField/TextField.tsx)

## Usage

Import the `TextField` component and styles and provide a `label` for accessibility/usability.

```jsx
import { TextField } from '@aws-amplify/ui-react';

export const DefaultTextFieldExample = () => <TextField label="Name" />;
```

### Accessibility / Label behavior

The form primitives are accessible by default. A matching `label` HTML element will be connected to the form control -- simply provide a `label` prop with a `string` or `ReactNode`. If no `id` is provided, one will be automatically generated and connected to both `label` and form control elements.

#### How can I visually hide the label while maintaining accessibility?

In some applications it may be desirable to hide the label when the field purpose is visually apparent such as a search field with button.
The `labelHidden` prop can be used to visually hide the label while still keeping it visible for screenreaders.

UX Tip: refrain hiding label if doing so hides important information needed by the user to fill out the field.

```jsx
import { Button, Flex, TextField } from '@aws-amplify/ui-react';

export const TextFieldAccessibilityExample = () => {
  return (
    <Flex>
      <TextField label="Search" labelHidden={true} />
      <Button>Search</Button>
    </Flex>
  );
};
```

### Sizes

TextField sizes are designed to match styling of other field components such as Buttons. There are three sizes: small, (default), and large.

```jsx
import { Flex, TextField } from '@aws-amplify/ui-react';

export const TextFieldSizeExample = () => {
  return (
    <Flex direction="column">
      <TextField label="Small" size="small" width="50%" />
      <TextField label="Default" width="75%" />
      <TextField label="Large" size="large" width="100%" />
    </Flex>
  );
};
```

### Variations

There are two variation styles available: default and `quiet`.

```jsx
import { TextField } from '@aws-amplify/ui-react';

export const TextFieldVariationExample = () => {
  return (
    <>
      <TextField label="Default" />
      <TextField label="Quiet" variation="quiet" />
    </>
  );
};
```

### Outer components

Compose field components such as `Button` and `Select` at the start or end of an TextField input using the `outerStartComponent` or `outerEndComponent` props.

```jsx
import { Button, Flex, TextField } from '@aws-amplify/ui-react';

export const TextFieldOuterComponentsExample = () => (
  <Flex gap="1rem" direction="column">
    <TextField label="Start" outerStartComponent={<Button>Start</Button>} />
    <TextField
      label="Start and End"
      outerStartComponent={<Button>Start</Button>}
      outerEndComponent={<Button>End</Button>}
    />
    <TextField label="End" outerEndComponent={<Button>End</Button>} />
    <TextField
      label="Multiple End"
      outerEndComponent={
        <>
          <Button>End</Button>
          <Button>End</Button>
        </>
      }
    />
    <TextField
      label="Multiple Start"
      outerStartComponent={
        <>
          <Button>Start</Button>
          <Button>Start</Button>
        </>
      }
    />
  </Flex>
);
```

### Inner components (icons)

Compose `FieldGroupIcon` or `FieldGroupIconButton` components inside TextField input using innerStartComponent and innerEndComponent.
To create an interactive icon button, use the `FieldGroupIconButton` component. To add an icon that's not interactive, use `FieldGroupIcon` component.

Note: When clicked, `FieldGroupIcon` will focus the field, whereas the `FieldGroupIconButton` will trigger its `onClick` event.

```jsx
import {
  Flex,
  FieldGroupIcon,
  FieldGroupIconButton,
  TextField,
} from '@aws-amplify/ui-react';
import { MdInfo, MdSearch } from 'react-icons/md';

export const TextFieldInnerComponentsExample = () => (
  <Flex gap="1rem" direction="column">
    <TextField
      label="Start and End"
      innerStartComponent={
        <FieldGroupIcon ariaLabel="">
          {/** Accessibility tip: pass empty ariaLabel for decorative icons. */}
          <MdInfo />
        </FieldGroupIcon>
      }
      innerEndComponent={
        <FieldGroupIconButton
          ariaLabel="Search"
          variation="link"
          onClick={() => alert('😎')}
        >
          <MdSearch />
        </FieldGroupIconButton>
      }
    />
  </Flex>
);
```

_You can also both inner and outer components together_

```jsx
import {
  Button,
  Flex,
  FieldGroupIcon,
  FieldGroupIconButton,
  TextField,
} from '@aws-amplify/ui-react';
import { MdInfo, MdSearch } from 'react-icons/md';

export const TextFieldOuterAndInnerComponentsExample = () => (
  <Flex gap="1rem" direction="column">
    <TextField
      label="Start and End inner and outer components"
      outerStartComponent={<Button>Start</Button>}
      outerEndComponent={<Button>End</Button>}
      innerStartComponent={
        <FieldGroupIcon ariaLabel="">
          {/** Accessibility tip: pass empty ariaLabel for decorative icons. */}
          <MdInfo />
        </FieldGroupIcon>
      }
      innerEndComponent={
        <FieldGroupIconButton
          ariaLabel="Search"
          variation="link"
          onClick={() => alert('😎')}
        >
          <MdSearch />
        </FieldGroupIconButton>
      }
    />
  </Flex>
);
```

### Descriptive text

To provide additional descriptive text of requirements of the field, use the `descriptiveText` field:

```jsx
import { Text, TextField, View } from '@aws-amplify/ui-react';

export const TextFieldDescriptiveTextExample = () => {
  return (
    <View width="100%">
      <TextField
        type="password"
        label="Password"
        descriptiveText={
          <Text
            as="span"
            color="purple.60"
            fontStyle="italic"
            fontSize="0.8rem"
          >
            Password length must be greater than 8 characters
          </Text>
        }
      />
    </View>
  );
};
```

### States

The available TextField states include `isDisabled` and `isReadOnly`. A disabled field will be not be focusable not mutable and will not be submitted with form data. A readonly field cannot be edited by the user.

```jsx
import { Flex, TextField } from '@aws-amplify/ui-react';

export const TextFieldStatesExample = () => {
  return (
    <Flex direction="column" gap="1rem">
      <TextField label="Disabled" defaultValue="Disabled" isDisabled={true} />
      <TextField
        label="Readonly"
        defaultValue="You can't edit me!"
        isReadOnly={true}
      />
    </Flex>
  );
};
```

### Required fields

Use the `isRequired` prop to specify a required field.

```jsx
import { Button, Flex, TextField } from '@aws-amplify/ui-react';

export const DefaultRequiredTextFieldExample = () => {
  return (
    <Flex as="form" direction="column" width="20rem">
      <TextField label="Email" type="email" isRequired={true} />
      <Button type="submit">Submit</Button>
    </Flex>
  );
};
```

There is no default styling for required fields. Customize the `label` or `descriptiveText` to instruct the form user of the required field.

```jsx
import { Button, Flex, Text, TextField } from '@aws-amplify/ui-react';

export const RequiredTextFieldExample = () => {
  return (
    <Flex as="form" direction="column" width="20rem">
      <TextField
        label={
          <Text>
            Email
            <Text as="span" fontSize="0.8rem" color="red">
              {' '}
              (required)
            </Text>
          </Text>
        }
        type="email"
        isRequired={true}
      />
      <TextField
        label="Password"
        type="password"
        descriptiveText={
          <Text as="span" fontSize="0.8rem" color="red" fontStyle="italic">
            Required
          </Text>
        }
        isRequired={true}
      />
      <Button type="submit">Submit</Button>
    </Flex>
  );
};
```

### Validation error styling

Use the `hasError` and `errorMessage` props to mark a TextField as having a validation error.

```jsx
import { TextField } from '@aws-amplify/ui-react';
import * as React from 'react';

export const TextFieldValidationErrorExample = () => {
  const [hasError, setHasError] = React.useState(true);

  const validateUsername = (e) => {
    const containsDigit = /\d/.test(e.currentTarget.value);
    setHasError(!containsDigit);
  };

  return (
    <TextField
      label="Username"
      hasError={hasError}
      errorMessage="Username must include at least one digit"
      onChange={validateUsername}
    />
  );
};
```

### Event handlers

TextField provides several event handlers: `onSelect`, `onInput`, `onChange`, `onCopy`, `onPaste`, and `onCut`. Open the console to interact with the demo below.

```jsx
import { TextField } from '@aws-amplify/ui-react';

export const TextFieldEventHandlersExample = () => (
  <TextField
    label="Event handlers"
    onSelect={(e) => console.info('onSelect fired:', e.currentTarget.value)}
    onInput={(e) => console.info('onInput fired:', e.currentTarget.value)}
    onChange={(e) => console.info('onChange fired:', e.currentTarget.value)}
    onCopy={(e) => console.info('onCopy fired:', e.currentTarget.value)}
    onPaste={(e) => console.info('onPaste fired:', e.currentTarget.value)}
    onCut={(e) => console.info('onCut fired:', e.currentTarget.value)}
  />
);
```

### Standard HTML attributes

The `TextField` will accept any of the standard HTML attributes that a `<input>` element accepts.
Standard `<input>` attributes can be found in the [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#attributes)

```jsx
<TextField
  label="Name"
  placeholder="Galadriel"
  name="name"
/>
```

## CSS Styling

### Theme

You can customize the appearance of all TextField components in your application with a [Theme](https://ui.docs.amplify.aws/theming).

[TextField Theme Source](https://github.com/aws-amplify/amplify-ui//blob/main/packages/ui/src/theme/tokens/components/textField.ts)

```tsx
import { TextField, ThemeProvider, Theme } from '@aws-amplify/ui-react';

const theme: Theme = {
  name: 'textfield-theme',
  tokens: {
    components: {
      textfield: {
        color: { value: '{colors.blue.90}' },
        _focus: {
          borderColor: { value: '{colors.blue.40}' },
        },
      },
    },
  },
};

export const TextFieldThemeExample = () => (
  <ThemeProvider theme={theme} colorMode="light">
    <TextField label="Name" />
  </ThemeProvider>
);
```

### Target classes

| Class | Description |
| --- | --- |
| `amplify-textfield` | Top level element that wraps the TextField primitive |

### CSS Variables

Key CSS variables for TextField customization:

- `--amplify-components-textfield-border-color`
- `--amplify-components-textfield-color`
- `--amplify-components-textfield-focus-border-color`
- `--amplify-components-textfield-font-size`

### Global styling

To override styling on all TextField primitives, you can set the Amplify CSS variables with the built-in `.amplify-textfield` class.

```css
/* styles.css */
.amplify-textfield {
  --amplify-components-fieldcontrol-border-color: rebeccapurple;
}
```

### Local styling

To override styling on a specific TextField, you can use a class selector or style props.

_Using a class selector:_

```css
/* styles.css */
.custom-textfield-class .amplify-input {
  border-radius: 0;
}
```

_Using style props:_

All style props will be applied to the [`Flex`](https://ui.docs.amplify.aws/react/components/flex) wrapper of the `TextField`. To style the `input` of the `TextField`, you can pass a `inputStyles` prop with the style props you want to apply to the input.

```jsx
import { Text, TextField, useTheme } from '@aws-amplify/ui-react';

export const TextFieldStylePropsExample = () => {
  const { tokens } = useTheme();
  return (
    <>
      <TextField
        label={
          <Text
            fontWeight={tokens.fontWeights.bold}
            fontSize={tokens.fontSizes.xl}
          >
            Name:
          </Text>
        }
        padding="xl"
        border={`1px solid ${tokens.colors.primary[60]}`}
      />
      <TextField
        label="Special Field"
        inputStyles={{
          backgroundColor: 'primary.10',
          border: `1px solid ${tokens.colors.primary[60]}`,
        }}
      />
    </>
  );
};
```