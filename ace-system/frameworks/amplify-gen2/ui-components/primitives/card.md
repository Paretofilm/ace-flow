# Card

Card groups related pieces of content.

[Theme source](https://github.com/aws-amplify/amplify-ui//blob/main/packages/ui/src/theme/tokens/components/card.ts) [React source](https://github.com/aws-amplify/amplify-ui//blob/main/packages/react/src/primitives/Card/Card.tsx)

## Usage

The Card component will include basic styling but the form of the Card component will come from the content passed into it.

```jsx
import {
  Card,
  Image,
  View,
  Heading,
  Flex,
  Badge,
  Text,
  Button,
  useTheme,
} from '@aws-amplify/ui-react';

export const DefaultCardExample = () => {
  const { tokens } = useTheme();
  return (
    <View
      backgroundColor={tokens.colors.background.secondary}
      padding={tokens.space.medium}
    >
      <Card>
        <Flex direction="row" alignItems="flex-start">
          <Image
            alt="Road to milford sound"
            src="/road-to-milford-new-zealand-800w.jpg"
            width="33%"
          />
          <Flex
            direction="column"
            alignItems="flex-start"
            gap={tokens.space.xs}
          >
            <Flex>
              <Badge size="small" variation="info">
                Plus
              </Badge>
              <Badge size="small" variation="success">
                Verified
              </Badge>
            </Flex>

            <Heading level={5}>
              New Zealand White Water Outdoor Adventure
            </Heading>

            <Text as="span">
              Join us on this beautiful outdoor adventure through the glittering
              rivers through the snowy peaks on New Zealand.
            </Text>
            <Button variation="primary">Book it</Button>
          </Flex>
        </Flex>
      </Card>
    </View>
  );
};
```

### Variations

Available Card variations:

```jsx
import { Card } from '@aws-amplify/ui-react';

export const CardVariationsExample = () => {
  return (
    <>
      <Card>Default card</Card>
      <Card variation="outlined">Outlined card</Card>
      <Card variation="elevated">Elevated card</Card>
    </>
  );
};
```

### Set rendered HTML element

The Card component renders as a `div` by default. You can change the HTML element rendered by Card with the `as` property.

```jsx
import { Card } from '@aws-amplify/ui-react';

export const CardAsExample = () => {
  return <Card as="section">{`I'm a section!`}</Card>;
};
```

## Customization

### Theme

You can customize the appearance of all Card components in your application with a [Theme](https://ui.docs.amplify.aws/theming).

[Card Theme Source](https://github.com/aws-amplify/amplify-ui//blob/main/packages/ui/src/theme/tokens/components/card.ts)

```tsx
import { Card, Text, Flex, ThemeProvider, Theme } from '@aws-amplify/ui-react';

const theme: Theme = {
  name: 'card-theme',
  tokens: {
    components: {
      card: {
        // You can reference other tokens
        backgroundColor: { value: '{colors.background.success}' },
        borderRadius: { value: '{radii.large}' },
        padding: { value: '{space.xl}' },

        // Variations
        outlined: {
          // Or use explicit values
          borderWidth: { value: '10px' },
          backgroundColor: { value: '{colors.background.warning}' },
        },
        elevated: {
          backgroundColor: { value: '{colors.background.info}' },
          boxShadow: { value: '{shadows.large}' },
        },
      },
    },
  },
};

export const CardThemeExample = () => {
  return (
    <ThemeProvider theme={theme} colorMode="light">
      <Flex>
        <Card>
          <Text>Default</Text>
        </Card>
        <Card variation="outlined">
          <Text>Outlined</Text>
        </Card>
        <Card variation="elevated">
          <Text>Elevated</Text>
        </Card>
      </Flex>
    </ThemeProvider>
  );
};
```

### Target classes

| Class | Description |
| --- | --- |
| `amplify-card` | Top level element that wraps the Card primitive |

### CSS Variables

Key CSS variables for Card customization:

- `--amplify-components-card-background-color`
- `--amplify-components-card-border-color`
- `--amplify-components-card-border-radius`
- `--amplify-components-card-border-style`
- `--amplify-components-card-border-width`
- `--amplify-components-card-box-shadow`
- `--amplify-components-card-elevated-*` (for elevated variation)
- `--amplify-components-card-outlined-*` (for outlined variation)
- `--amplify-components-card-padding`

### CSS

To override styling on all Cards, you can set the Amplify CSS variables or use the built-in `.amplify-card` class.

```css
/* styles.css */
:root {
  --amplify-components-card-border-color: red;
  --amplify-components-card-border-width: 3px;
}
/* OR */
.amplify-card {
  border: 3px solid red;
}
```

To replace _all_ the Card styling, unset it:

```css
.amplify-card {
  all: unset;
  /* Add your styling here*/
}
```

### Local styling

To override styling on a specific Card, you can use a class selector or style props.

_Using a class selector:_

```jsx
import { Card, Text } from '@aws-amplify/ui-react';

const css = `.custom-card-class {
  border: 3px solid red;
}`;

export const CardClassNameExample = () => {
  return (
    <>
      <style>{css}</style>
      <Card className="custom-card-class">
        <Text>Custom card!</Text>
      </Card>
    </>
  );
};
```

_Using style props:_

```jsx
import { Card, Text, useTheme } from '@aws-amplify/ui-react';

export const CardStylePropsExample = () => {
  const { tokens } = useTheme();
  return (
    <Card backgroundColor={tokens.colors.primary[20]}>
      <Text>Special card!</Text>
    </Card>
  );
};
```

### Default theme

```ts
import type {
  DesignTokenProperties,
  OutputVariantKey,
} from '../types/designToken';

type CardVariationStyleKey =
  | 'backgroundColor'
  | 'borderRadius'
  | 'borderWidth'
  | 'borderStyle'
  | 'borderColor'
  | 'boxShadow';

type CardVariationTokens<OutputType> = DesignTokenProperties<
  CardVariationStyleKey,
  OutputType
>;

export type CardTokens<OutputType extends OutputVariantKey> =
  CardVariationTokens<OutputType> &
    DesignTokenProperties<'padding', OutputType> & {
      elevated?: CardVariationTokens<OutputType>;
      outlined?: CardVariationTokens<OutputType>;
    };

export const card: Required<CardTokens<'default'>> = {
  backgroundColor: { value: '{colors.background.primary.value}' },
  borderRadius: { value: '{radii.xs.value}' },
  borderWidth: { value: '0' },
  borderStyle: { value: 'solid' },
  borderColor: { value: 'transparent' },
  boxShadow: { value: 'none' },
  padding: { value: '{space.medium.value}' },

  outlined: {
    backgroundColor: { value: '{components.card.backgroundColor.value}' },
    borderRadius: { value: '{radii.xs.value}' },
    borderWidth: { value: '{borderWidths.small.value}' },
    borderStyle: { value: 'solid' },
    borderColor: { value: '{colors.border.primary.value}' },
    boxShadow: { value: '{components.card.boxShadow.value}' },
  },

  elevated: {
    backgroundColor: { value: '{components.card.backgroundColor.value}' },
    borderRadius: { value: '{radii.xs.value}' },
    borderWidth: { value: '0' },
    borderStyle: { value: 'solid' },
    borderColor: { value: 'transparent' },
    boxShadow: { value: '{shadows.medium.value}' },
  },
};
```