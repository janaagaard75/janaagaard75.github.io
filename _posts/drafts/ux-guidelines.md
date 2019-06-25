---
layout: post
title: "UX From a Helicopter"
published: false
---

This is like a style guide, but focusing on the user experience instead of the user interface. The points in there are somewhere between rules and guidelines. You're allowed to break the rules, but argue well enough.

## General

- “Keep things as simple as possible, but not simpler.”
- Remove features when adding new features to keep the total low.
- It’s *much* easier to expand a layout that works on a small screen to a large screen than shrinking big screen a layout to a small screen.

## Buttons

- Primary buttons are for action that the Enter key maps to, i.e. the submit button, or to highlight a recommended choice.
- Most buttons are secondary buttons.
- Prefer specific wording like ‘yes, delete’ and ‘no, keep the file’ over generic like ‘ok’ and ‘cancel’.

## Modal Dialogs

- Avoid modal dialogs. They hide the interface behind them. They have too much chrome on small screens. Scrollbars are tricky to get right.
- The URL is not updated, and in a web app, ‘back’ means cancel.
- Use separate pages or slide outs instead.
- No input fields in modal dialogs. Only a few buttons with choices.
- Historically used because page loads were slow.

## Navigation

- Primarily navigating between pages, scrolling a page, and navigating back.
- No internal scrollbars because they do not work well on touch screens, and because it can be difficult to see that an area is scrollable in modern browsers that hide the scrollbars.
- Use anchor elements (&lt;a href...&gt;) when navigating pages - not JavaScript. They can be styles as buttons if that is desired.

## State

- Reloading the window should only make the state on the current page disappear. This greatly complicates splitting up a form into multiple pages.
- Use the URL since it's an inherit way of storing and stacking state.
- If the URL changes, the user expects that it's possible to navigate back to the previous page.
