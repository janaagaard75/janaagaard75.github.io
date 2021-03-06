---
layout: post
title: "Using both Traced SVGs and WebP with gatsby-contentful-source"
tags:
  [
    Contentful,
    Gatsby,
    GraphQL
  ]
published: true
---

[gatsby-contentful-source](https://www.gatsbyjs.com/plugins/gatsby-source-contentful/) supports Traced SVGs and WebP, by using either `GatsbyContentfulFluid_tracedSVG` or `GatsbyContentfulFluid_withWebp`, but you have to choose between one or the other. Fortunately is not that difficult to add a fragment query this allows having both.

## 1. Define a Fragment With Both Traced SVG and WebP

Create a file with shared query fragments, e.g. `fragments.ts`. Just make sure that Contentful can see the file. Mat Clutter has more information about [Using GraphQL fragments across multiple templates in GatsbyJS](https://medium.com/flatiron-labs/using-graphql-fragments-across-multiple-templates-in-gatsbyjs-7731a2d28bbd#c06c).

```typescript
import { graphql } from "gatsby"

// The name of this constant isn't important.
export const tracedSvgAndWithWebp = graphql`
  fragment GatsbyContentfulFluid_tracedSvg_withWebp on ContentfulFluid {
    tracedSVG
    aspectRatio
    src
    srcSet
    srcWebp
    srcSetWebp
    sizes
  }
`
```

## 2. Use the New Fragment

Replace your exiting fragments with new `GatsbyContentfulFluid_tracedSvg_withWebp`, e.g.

```typescript
export const imageQuery = graphql`
  image {
    fluid(maxWidth: 1680, maxHeight: 1050) {
      ...GatsbyContentfulFluid_tracedSvg_withWebp
    }
    description
  }
`
```

## Bonus info: Creating Your Own Fragments

The fragments that gatsby-contentful-source comes with are all defined in their [`fragments.js` file](https://github.com/gatsbyjs/gatsby/blob/master/packages/gatsby-source-contentful/src/fragments.js). `GatsbyContentfulFluid_tracedSvg_withWebp` is a combination of  `GatsbyContentfulFluid_tracedSVG` and `GatsbyContentfulFluid_withWebp`.
