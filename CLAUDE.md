# CLAUDE.md

- MACOS.md and WINDOWS.md describe the end state, not steps. Write each item as a present-tense fact.
- Word each setting with its English UI label, adding nothing the label lacks.
- Keep package lists and symlink rows in alphabetical order, with table columns aligned.
- The Claude app is a prerequisite for applying these docs, so never list it as a package.
- Keep the right Command rule in `karabiner/rules.json` as Control-Option-Command-F13 followed by `vk_none`, bound to "Select next source in Input menu".
  - "Select the previous input source" switches on key release and sometimes reverts.
  - A shortcut with Space does nothing while Space is held.
  - A function key alone fails when the hyper key is held with Control, Option, or Command.
  - Without `vk_none`, the first character after switching is typed in the old input source.
