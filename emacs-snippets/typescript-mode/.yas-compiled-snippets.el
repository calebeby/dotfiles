;;; Compiled snippets and support files for `rjsx-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'rjsx-mode
                     '(("re" "const ${2:${1:$(string-inflection-lower-camelcase-function yas-text)}} = require('${1:module}')\n" "require" nil
                        ("es6")
                        nil "/home/caleb/dotfiles/emacs-snippets/rjsx-mode/require" nil nil)
                       ("im" "import ${2:${1:$(string-inflection-lower-camelcase-function yas-text)}} from '${1:module}'" "import" nil
                        ("es6")
                        nil "/home/caleb/dotfiles/emacs-snippets/rjsx-mode/import" nil nil)
                       ("compo" "\ncomponent here\n" "component" nil
                        ("es6")
                        nil "/home/caleb/dotfiles/emacs-snippets/rjsx-mode/component" nil nil)))


;;; Do not edit! File generated at Mon Dec 18 16:51:04 2017
