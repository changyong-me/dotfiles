# CLAUDE.md

## MACOS.md and WINDOWS.md

- These docs describe the end state, not steps. Write each item as a present-tense fact.
- Word each setting with its English UI label, adding nothing the label lacks.
- Keep package lists and symlink rows in alphabetical order, with table columns aligned.
- The Claude app is a prerequisite for applying these docs, so never list it as a package.

## Input source switching

Keep the right Command rule in `karabiner/rules.json` sending Control-Option-Command-F13 followed by `vk_none`, with that shortcut bound to "Select the previous input source". Each part is there for a reason:

- F13, because a shortcut with Space does nothing while Space is held.
- Control-Option-Command, because a function key alone fails when the hyper key is held with one of those modifiers.
- `vk_none`, because the switch happens on key release, and this releases the key as soon as it is pressed.
