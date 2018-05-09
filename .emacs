(require 'package)

(add-to-list 'package-archives '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode 2)

(windmove-default-keybindings)

(package-initialize)

(eval-when-compile
  (require 'use-package)
  (setq use-package-always-ensure t))

; hide toolbar, scroll bar, menu bar
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(menu-bar-mode -1)

(set-frame-font "Fira Mono-8")

; org mode export md
(require 'ox-md nil t)

(setq make-backup-files nil)

(setq inhibit-startup-screen t)

(show-paren-mode 1)
(setq show-paren-delay 0)

(require 'electric)
(electric-pair-mode 1)

(global-auto-revert-mode t)

(use-package general
  :config
    (progn
      (setq general-default-keymaps 'evil-normal-state-map)
      (general-define-key "C-w C-h" 'evil-window-left)
      (general-define-key "C-w C-j" 'evil-window-down)
      (general-define-key "C-w C-k" 'evil-window-up)
      (general-define-key "C-w C-l" 'evil-window-right)))

(use-package evil
  :config (evil-mode 1))

(use-package gruvbox-theme
  :config (set-face-background 'highlight "#484341"))

(use-package nlinum-relative
  :config
    (nlinum-relative-setup-evil)
    (global-nlinum-relative-mode))

(use-package avy
  :config
    (progn
      (global-set-key (kbd "C-:") 'avy-goto-char)
      (global-set-key (kbd "C-'") 'avy-goto-char-2)))

(use-package flycheck
  :init (global-flycheck-mode)
  :config
    (general-define-key "J" 'flycheck-next-error)
    (general-define-key "K" 'flycheck-previous-error)
    (setq flycheck-display-errors-delay 0)
    (setq flycheck-indication-mode nil))

(use-package company
  :init (global-company-mode)
  :config
    (setq company-dabbrev-downcase 0)
    (setq company-idle-delay 0)
    (setq company-minimum-prefix-length 1)
    (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
    (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
    (setq company-frontends
      '(company-tng-frontend
        company-pseudo-tooltip-frontend
        company-preview-frontend
        company-echo-metadata-frontend)))

; temporary until next release of company
(defun company-preview-frontend (command)
  "`company-mode' frontend showing the selection as if it had been inserted."
  (pcase command
    (`pre-command (company-preview-hide))
    (`post-command
     (unless (and company-selection-changed
                  (memq 'company-tng-frontend company-frontends))
       (company-preview-show-at-point (point)
                                      (nth company-selection company-candidates))))
    (`hide (company-preview-hide))))

(use-package rjsx-mode
  :config
    (add-to-list 'auto-mode-alist '(".*\\.js\\'" . rjsx-mode))
    (setq js-indent-level 2)
    (setq js2-mode-show-parse-errors nil)
    (setq js2-mode-show-strict-warnings nil)
    (with-eval-after-load 'rjsx-mode
    (define-key rjsx-mode-map "<" nil)
    (define-key rjsx-mode-map (kbd "C-d") nil)
    (define-key rjsx-mode-map ">" nil)))

(use-package emmet-mode
	:config
		(add-hook 'tide-mode-hook 'emmet-mode))

(use-package elpy
  :config (elpy-enable))

(defvar flycheck-typescript-tslint-project "tsconfig.json")
(flycheck-define-checker typescript-tslint-cee
  "Redefine the tslint checker to handle --type-check."
  :command ("tslint" "--format" "json"
            (config-file "--config" flycheck-typescript-tslint-config)
            (option "--rules-dir" flycheck-typescript-tslint-rulesdir)
            (config-file "--project" flycheck-typescript-tslint-project)
            (eval flycheck-tslint-args)
            ;; Must use inplace to satisfy paths in project.
            source-inplace)
  :error-parser flycheck-parse-tslint
  :modes (typescript-mode))

(add-to-list 'flycheck-checkers 'typescript-tslint-cee)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq tide-format-options '(:indentSize 2))
  (setq typescript-indent-level 2)
  (eldoc-mode +1)
  (setq tide-hl-identifier-idle-time 0.1)
  (flycheck-disable-checker 'typescript-tslint)
  (tide-hl-identifier-mode +1)
  (general-define-key 
    "C-<return>" 'tide-jump-to-definition
    "C-S-<return>" 'tide-jump-back)
  (company-mode +1))

(use-package tide
  :config (progn
    (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
    (add-to-list 'auto-mode-alist '("\\.js\\'" . typescript-mode))
    (add-hook 'typescript-mode-hook #'setup-tide-mode)
    (add-hook 'js2-mode-hook #'setup-tide-mode)))

(use-package add-node-modules-path
  :config  (add-hook 'js-mode-hook #'add-node-modules-path))

(use-package prettier-js
  :config
    (add-hook 'js-mode-hook 'prettier-js-mode)
    (add-hook 'typescript-mode-hook 'prettier-js-mode))

(use-package tern
  :config
    (add-hook 'js-mode-hook 'tern-mode)
    (general-define-key :states 'normal :keymaps 'tern-mode-keymap "SPC j d" 'tern-find-definition)
    (general-define-key :states 'normal :keymaps 'tern-mode-keymap "SPC j b" 'tern-pop-find-definition))

;; (use-package company-tern
;;   :config (add-to-list 'company-backends 'company-tern))

(use-package js2-refactor
  :config (progn
    (add-hook 'js-mode-hook #'js2-refactor-mode)
    (general-define-key
      :prefix "SPC r"
      :keymaps 'evil-visual-state-map
        "e f" 'js2r-extract-function)
    (general-define-key
      :prefix "SPC r"
        "t a" 'js2r-toggle-arrow-function-and-expression
        "t f" 'js2r-toggle-function-expression-and-declaration
        "e v" 'js2r-extract-var
        "r v" 'tern-rename-variable
        "l t" 'js2r-log-this)))

(use-package go-mode
  :config
    (progn
      (add-to-list 'auto-mode-alist '(".*\\.go\\'" . go-mode)))
      (add-hook 'go-mode-hook
        (lambda ()
          (add-hook 'before-save-hook 'gofmt-before-save)
          (setq tab-width 2)
          (setq indent-tabs-mode 1))))

(use-package company-go
  :config (add-to-list 'company-backends 'company-go))

(use-package origami
  :config (progn
    (origami-mode 1)
    (general-define-key "TAB" 'origami-recursively-toggle-node)))

(use-package company-quickhelp
  :init (add-hook 'global-company-mode-hook #'company-quickhelp-mode)
  :config (setq company-quickhelp-delay 0))

; (use-package company-emoji
;   :config (add-to-list 'company-backends 'company-emoji))

; (use-package emojify
;   :config (add-hook 'after-init-hook #'global-emojify-mode))

(use-package hl-todo
	:config (global-hl-todo-mode))

(use-package ivy
  :config
    (ivy-mode 1)
    (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
    (define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)
    (define-key ivy-minibuffer-map (kbd "M-j") 'ivy-next-line)
    (define-key ivy-minibuffer-map (kbd "M-k") 'ivy-previous-line))

(use-package projectile
  :config (progn
    (projectile-register-project-type 'npm '("package.json")
        :compile "yarn"
        :test "yarn test"
        :run "yarn start"
        :test-suffix ".test")
    (projectile-mode 1)))

(use-package counsel-projectile
  :config
    (counsel-projectile-mode)
    (define-key evil-normal-state-map (kbd "M-SPC") 'counsel-projectile-find-file)
    (global-set-key (kbd "M-k") 'counsel-projectile-switch-project))

(use-package markdown-mode
  :commands (gfm-mode)
  :mode (("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package magit
  :config (general-define-key "SPC g" 'magit-status))

(use-package evil-magit
  :after magit)

(use-package yasnippet
  :config
    (setq yas-snippet-dirs "/home/caleb/dotfiles/emacs-snippets")
    (define-key yas-minor-mode-map [(tab)] nil)
    (define-key yas-minor-mode-map (kbd "TAB") nil)
    (yas-global-mode 1)
    (define-key yas-minor-mode-map (kbd "C-SPC") 'yas-expand))

(use-package string-inflection)

(use-package evil-commentary
  :config (evil-commentary-mode))

(use-package evil-surround
  :config (global-evil-surround-mode 1))

(use-package evil-args
  :config
    (define-key evil-inner-text-objects-map "," 'evil-inner-arg)
    (define-key evil-outer-text-objects-map "," 'evil-outer-arg))

(use-package expand-region
  :config
    (define-key evil-visual-state-map "K" 'er/expand-region))

(use-package which-key
  :config (which-key-mode))

(use-package treemacs
  :commands treemacs-toggle)

(use-package treemacs-projectile
  :commands treemacs-projectile-toggle
  :init (general-define-key "C-n" 'treemacs-projectile-toggle))

(use-package counsel-dash
  :config (progn (counsel-dash-activate-docset "JavaScript")
                 (counsel-dash-activate-docset "CSS")
                 (counsel-dash-activate-docset "HTML")
                 (counsel-dash-activate-docset "Go")
                 (counsel-dash-activate-docset "TypeScript")
                 (general-define-key "SPC d" 'counsel-dash)
                 (setq browse-url-browser-function 'browse-url-generic
                       browse-url-generic-program "xdg-open")
                 (setq helm-dash-browser-func 'browse-url-generic)))

(use-package multiple-cursors
  :config (general-define-key "C-S-c C-S-c" 'mc/edit-lines))

(use-package meghanada
  :config (add-hook 'java-mode-hook
    (lambda ()
      (meghanada-mode t)
      (flycheck-mode +1)
      (setq c-basic-offset 2)
      (add-hook 'before-save-hook 'meghanada-code-beautify-before-save))))

(use-package groovy-mode
  :config (add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   Functions                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my/hide-buffer ()
  (interactive)
  (if (string= major-mode "eshell-mode")
    (bury-buffer)))

(defun my/register-esc-binding ()
  (interactive)
  (message "hiya")
  (general-define-key "<escape>" 'my/hide-buffer))

(add-hook 'eshell-mode-hook 'my/register-esc-binding)

(defun my/open-eshell ()
  (interactive)
  (if (get-buffer "*eshell 1*")
    (progn
      (switch-to-buffer "*eshell 1*")
      (move-point-to-writeable-last-line)
      (evil-insert 1))
    (progn
      (eshell)
      (rename-buffer "*eshell 1*"))))

(general-define-key "SPC t" 'my/open-eshell)

(defun move-point-to-writeable-last-line ()
  "Move the point to a non-read-only part of the last line.
If point is not on the last line, move point to the maximum position
in the buffer.  Otherwise if the point is in read-only text, move the
point forward out of the read-only sections."
  (interactive)
  (let* ((curline (line-number-at-pos))
         (endline (line-number-at-pos (point-max))))
    (if (= curline endline)
        (if (not (eobp))
            (let (
                  ;; Get text-properties at the current location
                  (plist (text-properties-at (point)))
                  ;; Record next change in text-properties
                  (next-change
                   (or (next-property-change (point) (current-buffer))
                       (point-max))))
              ;; If current text is read-only, go to where that property changes
              (if (plist-get plist 'read-only)
                  (goto-char next-change))))
      (goto-char (point-max)))))

(defun move-point-on-insert-to-writeable-last-line ()
  "Only edit the current command in insert mode."
  (add-hook 'evil-insert-state-entry-hook
        'move-point-to-writeable-last-line
        nil
        t))

(add-hook 'eshell-mode-hook
  'move-point-on-insert-to-writeable-last-line)

;; (add-hook 'eshell-mode-hook
;;    (define-key evil-normal-state-local-map (kbd "<tab>") 'company-complete-common-or-cycle))

; refresh config
(define-key evil-normal-state-map (kbd "C-S-r") '(lambda() (interactive) (load-file "~/.emacs")))

(define-key evil-normal-state-map (kbd ";") 'evil-ex)

(global-set-key (kbd "C-s") 'save-buffer)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
	 (quote
		(emmet-mode groovy-mode eclim jdee hl-todo company-go elpy counsel-dash which-key use-package treemacs-projectile tide string-inflection rjsx-mode prettier-js origami nlinum-relative markdown-mode js2-refactor gruvbox-theme general expand-region evil-surround evil-magit evil-indent-plus evil-commentary evil-args emojify counsel-projectile company-tern company-quickhelp company-emoji add-node-modules-path))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
