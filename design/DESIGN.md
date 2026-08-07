---
name: Nur
colors:
  surface: '#131313'
  surface-dim: '#131313'
  surface-bright: '#393939'
  surface-container-lowest: '#0e0e0e'
  surface-container-low: '#1c1b1b'
  surface-container: '#201f1f'
  surface-container-high: '#2a2a2a'
  surface-container-highest: '#353534'
  on-surface: '#e5e2e1'
  on-surface-variant: '#bdcac2'
  inverse-surface: '#e5e2e1'
  inverse-on-surface: '#313030'
  outline: '#87948d'
  outline-variant: '#3d4944'
  surface-tint: '#6edab4'
  primary: '#6edab4'
  on-primary: '#003829'
  primary-container: '#2fa280'
  on-primary-container: '#003023'
  inverse-primary: '#006c52'
  secondary: '#e9c349'
  on-secondary: '#3c2f00'
  secondary-container: '#af8d11'
  on-secondary-container: '#342800'
  tertiary: '#c8c6c5'
  on-tertiary: '#303030'
  tertiary-container: '#929090'
  on-tertiary-container: '#2a2a2a'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#8bf7cf'
  primary-fixed-dim: '#6edab4'
  on-primary-fixed: '#002117'
  on-primary-fixed-variant: '#00513d'
  secondary-fixed: '#ffe088'
  secondary-fixed-dim: '#e9c349'
  on-secondary-fixed: '#241a00'
  on-secondary-fixed-variant: '#574500'
  tertiary-fixed: '#e5e2e1'
  tertiary-fixed-dim: '#c8c6c5'
  on-tertiary-fixed: '#1b1b1c'
  on-tertiary-fixed-variant: '#474746'
  background: '#131313'
  on-background: '#e5e2e1'
  surface-variant: '#353534'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 57px
    fontWeight: '700'
    lineHeight: 64px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
  title-lg:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.1px
  arabic-display:
    fontFamily: serif
    fontSize: 32px
    fontWeight: '400'
    lineHeight: 52px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  margin-mobile: 20px
  margin-desktop: 40px
  gutter: 16px
  card-padding: 24px
---

## Brand & Style

The design system is centered on a premium, contemplative experience for Islamic lifestyle and prayer. It utilizes a **Modern Corporate** style with heavy influences from **Minimalism** and **Tonal Layering** to create a focused, spiritual environment. 

The aesthetic is "Premium Sacred," achieved through deep, immersive backgrounds paired with high-quality accents. The goal is to evoke a sense of tranquility, reverence, and modern sophistication, moving away from traditional ornate patterns toward a cleaner, systematic interpretation of Islamic identity.

## Colors

The palette is anchored in a deep dark-mode environment to minimize eye strain during night or early morning prayers.

- **Primary (Emerald):** Used for active states, primary actions, and brand identification. It represents life and growth.
- **Secondary (Gold/Amber):** Used sparingly for highlights, achievements, and signifying "Sunnah" or special spiritual moments.
- **Neutral/Background:** The base is a deep charcoal (#121212) rather than pure black to maintain softness and depth.
- **Surface Levels:** Tonal variations of charcoal are used to define elevation, with primary containers utilizing subtle emerald tints to signify importance.

## Typography

This design system utilizes **Inter** for all UI elements to ensure maximum legibility and a contemporary, systematic feel. 

- **Hierarchy:** Display and Headline styles use tighter letter-spacing and heavier weights to command attention.
- **Body Text:** Ample line-height is maintained for readability, especially in long-form content like Quranic translations.
- **Arabic Text:** When displaying Quranic script, fallback to a high-quality Naskh-style serif font is required, ensuring it is scaled 1.5x larger than surrounding English text to accommodate the complexity of diacritics.

## Layout & Spacing

The layout follows a **Fluid Grid** model with high internal breathing room to reflect the theme of "Spiritual Space."

- **Mobile:** 4-column grid with 20px side margins.
- **Tablet/Desktop:** 12-column centered grid with a maximum content width of 1200px.
- **Rhythm:** An 8px linear scale governs all padding and margins. Vertical rhythm is relaxed, favoring large gaps between distinct content sections to avoid visual clutter.

## Elevation & Depth

Hierarchy is established through **Tonal Layers** rather than heavy shadows. In this dark mode environment, surfaces "lift" by becoming lighter in color.

- **Level 0 (Base):** #121212.
- **Level 1 (Cards/Large Containers):** #1E1E1E.
- **Level 2 (Dialogs/Popovers):** #2C2C2C.
- **Overlays:** A 40% blur (Glassmorphism) is used for top navigation bars and bottom tab bars to maintain context of the content scrolling beneath them. 
- **Accents:** Inner glows (1px stroke with 10% white) are applied to primary buttons to give them a polished, premium feel.

## Shapes

The shape language is defined by significant, friendly roundedness to soften the "digital" feel of the app.

- **Small Components:** Buttons, chips, and input fields use a **16px** (rounded-lg) radius.
- **Large Components:** Feature cards, prayer time dashboards, and modals use a **24px** (rounded-xl) radius.
- **Interactive States:** Active chips and selected navigation items should transition into pill shapes (full round) to indicate selection clearly.

## Components

- **Buttons:** Primary buttons use the Emerald gradient (Primary to a slightly darker shade). Text is white. Secondary buttons use a transparent background with a Gold border.
- **Cards:** Large cards for "Prayer Times" should have a subtle background tint of Emerald (approx 4% opacity) to distinguish them from generic content cards.
- **Chips:** Used for filtering "Tasbih" counts or "Surah" categories. Unselected: Dark Grey fill. Selected: Gold fill with Black text.
- **Input Fields:** Outlined style with a 1px border (#333333). On focus, the border transitions to Emerald with a subtle outer glow.
- **Prayer Progress Ring:** A custom component using a circular stroke. The background stroke is Emerald at 10% opacity; the active progress is a solid Emerald stroke with a Gold "glow" at the leading edge.
- **Lists:** Clean dividers using 1px line with 5% white opacity. Icons in lists should be "duotone" using Emerald and Gold.