(unless (package-installed-p 'crux)
  (package-refresh-contents)
  (package-install 'crux))

(setq evil-want-keybinding nil)
(use-package evil)
(use-package move-text)
(setq evil-disable-insert-state-bindings t)
(setq split-width-threshold nil)
(setq initial-scratch-message "")
(setq evil-mode-line-format nil)
(setq evil-insert-state-message nil)
(setq evil-visual-state-message nil)
(setq evil-normal-state-message nil)
(setq evil-motion-state-message nil)
(setq evil-emacs-state-message nil)
(setq evil-operator-state-message nil)
(setq evil-replace-state-message nil)
(setq evil-echo-state nil)  
(setq evil-show-mode-line nil) 
(setq evil-move-beyond-eol t)                 
(setq-default evil-move-cursor-back nil)              
(setq-default blink-cursor-mode nil)
(setq lsp-diagnostics-provider :none)  
(setq sp-ui-sideline-enable nil) 
(setq sp-modeline-diagnostics-enable nil)
(setq sp-modeline-diagnostics-enable nil)
(setq sp-signature-render-documentation nil) 
(setq sp-enable-symbol-highlighting nil)
(setq sp-headerline-breadcrumb-enable nil) 
(setq lsp-headerline-breadcrumb-enable nil)
(setq ring-bell-function 'ignore)
(setq-default comment-style 'plain)

(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

(line-number-mode 1)
(column-number-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)

(load "~/.emacs.d/root.el")
(load "~/.emacs.d/gnu-elpa-keyring/gnu-elpa-keyring-update.el")

(when (eq system-type 'darwin)
(setq mac-command-modifier 'control)
(setq mac-control-modifier 'meta))

(setq-default inhibit-splash-screen t
            make-backup-files nil
            tab-width 4
            indent-tabs-mode nil
            compilation-scroll-output t)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(setq package-archives
    '(("melpa" . "https://melpa.org/packages/")
    ("org " . "https://orgmode.org/elpa/")
    ("gnu" . "https://elpa.gnu.org/packages/")))

(setq custom-file "~/.emacs.d/custom.el")

(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

(electric-pair-mode 1)
(cua-selection-mode 1)

(require 'use-package)
(setq use-package-always-ensure t)
(setq evil-want-keybinding nil)

(require 'evil)
(evil-mode 1)

(define-key evil-normal-state-map "w" nil)
(define-key evil-normal-state-map "w" nil)
(define-key evil-normal-state-map "d" nil)
(define-key evil-normal-state-map "u" nil)
(define-key evil-normal-state-map "/" nil)
(define-key evil-normal-state-map (kbd "C-o") nil)
(define-key evil-visual-state-map (kbd "DEL") 'delete-region)
(define-key evil-visual-state-map (kbd "<backspace>") 'delete-region)

(define-key evil-motion-state-map "w" nil)
(define-key evil-motion-state-map "u" nil)
(define-key evil-motion-state-map "d" nil)
(define-key evil-motion-state-map "/" nil)

(evil-define-key 'normal 'global
"w" 'forward-word)
(evil-define-key 'motion 'global
"w" 'forward-word)

(evil-mode -1)
(evil-mode 1)

(use-package evil-collection
:after evil
:ensure t
:config
(evil-collection-init))


(use-package dired
:ensure nil
:config

(setq dired-auto-revert-buffer t)
(setq auto-revert-verbose nil)
(setq global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)
(add-hook 'dired-mode-hook 'auto-revert-mode)

(defun my/dired-refresh-after-operation (operation)
(when (derived-mode-p 'dired-mode)
    (revert-buffer)))

(advice-add 'dired-do-rename :after #'my/dired-refresh-after-operation)
(advice-add 'dired-do-copy :after #'my/dired-refresh-after-operation)
(advice-add 'dired-do-delete :after #'my/dired-refresh-after-operation)
(advice-add 'dired-create-directory :after #'my/dired-refresh-after-operation))

(use-package company
:init
(add-hook 'after-init-hook 'global-company-mode)
:config
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1) (setq
company-tooltip-align-annotations t))

(use-package orderless
:ensure t
:custom
(completion-styles '(orderless basic))
(completion--category-override '((file (styles basic partial-completions)))))

(use-package yasnippet
:init
(yas-global-mode 1))

(use-package company
:config
(defun company-backend-with-yas (backend)
"Add yasnippet to the company backend."
(if (and (listp backend) (member 'company-yasnippet backend))
    backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-backend-with-yas company-backends)))

(setq evil-insert-state-cursor '(box "yellow")
    evil-normal-state-cursor '(box "yellow")
    evil-emacs-state-cursor  '(box "yellow")
    evil-motion-state-cursor  '(box "yellow"))

(custom-set-faces
'(mc/cursor-face ((t (:inherit cursor)))))

(add-hook 'window-setup-hook #'toggle-frame-fullscreen)

(require 'evil)
(defun my/enhanced-keyboard-quit ()
(interactive)
(when (and (boundp 'evil-mode) 
            evil-mode
            (not (minibufferp))) 
(evil-normal-state))

(keyboard-quit))
(global-set-key (kbd "C-g") #'my/enhanced-keyboard-quit)
(with-eval-after-load 'evil
(define-key evil-insert-state-map (kbd "C-g") #'my/enhanced-keyboard-quit)
(define-key evil-visual-state-map (kbd "C-g") #'my/enhanced-keyboard-quit)
(define-key evil-replace-state-map (kbd "C-g") #'my/enhanced-keyboard-quit)
(define-key evil-operator-state-map (kbd "C-g") #'my/enhanced-keyboard-quit))


(evil-define-key 'normal 'global (kbd "C-e") #'end-of-line)
(define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
(define-key evil-emacs-state-map (kbd "C-e") 'end-of-line)
(define-key evil-visual-state-map (kbd "C-e") 'end-of-line)

(evil-define-key 'normal 'global (kbd "C-f") #'forward-word)
(define-key evil-insert-state-map (kbd "C-f") 'forward-word)
(define-key evil-emacs-state-map (kbd "C-f") 'forward-word)
(define-key evil-visual-state-map (kbd "C-f") 'forward-word)


(evil-define-key 'normal 'global (kbd "C-b") #'backward-word)
(define-key evil-insert-state-map (kbd "C-b") 'backward-word)
(define-key evil-emacs-state-map (kbd "C-b") 'backward-word)
(define-key evil-visual-state-map (kbd "C-b") 'backward-word)

(evil-define-key 'normal 'global (kbd "C-k") #'kill-line)
(define-key evil-insert-state-map (kbd "C-k") 'kill-line)
(define-key evil-emacs-state-map (kbd "C-k") 'kill-line)
(define-key evil-visual-state-map (kbd "C-k") 'kill-line)


(evil-define-key 'normal 'global (kbd "C-p") #'previous-line)
(define-key evil-insert-state-map (kbd "C-p") 'previous-line)
(define-key evil-emacs-state-map (kbd "C-p") 'previous-line)
(define-key evil-visual-state-map (kbd "C-p") 'previous-line)

(evil-define-key 'normal 'global (kbd "C-n") #'next-line)
(define-key evil-insert-state-map (kbd "C-n") 'next-line)
(define-key evil-emacs-state-map (kbd "C-n") 'next-line)
(define-key evil-visual-state-map (kbd "C-n") 'next-line)

(evil-define-key 'normal 'global (kbd "C-a") #'move-beginning-of-line)
(define-key evil-insert-state-map (kbd "C-a") 'move-beginning-of-line)
(define-key evil-emacs-state-map (kbd "C-a") 'move-beginning-of-line)
(define-key evil-visual-state-map (kbd "C-a") 'move-beginning-of-line)

(evil-define-key 'normal 'global (kbd "C-e") #'move-end-of-line)
(define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-emacs-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-visual-state-map (kbd "C-e") 'move-end-of-line)

(evil-define-key 'normal 'global (kbd "C-d") #'kill-whole-line)
(define-key evil-normal-state-map  (kbd "C-x C-p") 'evil-window-up)
(define-key evil-normal-state-map  (kbd "C-x C-n") 'evil-window-down)
(define-key evil-normal-state-map  (kbd "C-x C-]") 'split-window-vertically)

(evil-define-key 'normal 'global (kbd "C-v") 'set-mark-command)
(define-key evil-insert-state-map (kbd "C-v") 'set-mark-command)
(define-key evil-emacs-state-map (kbd "C-v") 'set-mark-command)
(define-key evil-visual-state-map (kbd "C-v") 'set-mark-command)

(evil-define-key 'normal 'global (kbd "C-c C-c") 'compile)
(define-key evil-insert-state-map (kbd "C-c C-c") 'compile)
(define-key evil-emacs-state-map (kbd "C-c C-c") 'compile)
(define-key evil-visual-state-map (kbd "C-c C-c") 'compile)

(evil-define-key 'normal 'global (kbd "C-l") 'forward-char)
(define-key evil-insert-state-map (kbd "C-l") 'forward-char)
(define-key evil-emacs-state-map (kbd "C-l") 'forward-char)
(define-key evil-visual-state-map (kbd "C-l") 'forward-char)

(evil-define-key 'normal 'global (kbd "C-h") 'backward-char)
(define-key evil-insert-state-map (kbd "C-h") 'backward-char)
(define-key evil-emacs-state-map (kbd "C-h") 'backward-char)
(define-key evil-visual-state-map (kbd "C-h") 'backward-char)

(evil-define-key 'normal 'global (kbd "M-.") 'xref-find-definitions)
(define-key evil-insert-state-map (kbd "M-.") 'xref-find-definitions)
(define-key evil-emacs-state-map (kbd "M-.") 'xref-find-definitions)
(define-key evil-visual-state-map (kbd "M-.") 'xref-find-definitions)

(evil-define-key 'normal 'global (kbd "M-,") 'xref-go-back)
(define-key evil-insert-state-map (kbd "M-,") 'xref-go-back)
(define-key evil-emacs-state-map (kbd "M-,") 'xref-go-back)
(define-key evil-visual-state-map (kbd "M-,") 'xref-go-back)

(evil-define-key 'normal 'global (kbd "M-*") 'xref-go-forward)
(define-key evil-insert-state-map (kbd "M-*") 'xref-go-forward)
(define-key evil-emacs-state-map (kbd "M-*") 'xref-go-forward)
(define-key evil-visual-state-map (kbd "M-*") 'xref-go-forward)

(evil-define-key 'normal 'global (kbd "RET") 'newline)
(define-key evil-insert-state-map (kbd "RET") 'newline)
(define-key evil-emacs-state-map (kbd "RET") 'newline)
(define-key evil-visual-state-map (kbd "RET") 'newline)

(evil-define-key 'normal 'global (kbd "C-.") 'pop-to-mark-command)
(define-key evil-insert-state-map (kbd "C-.") 'pop-to-mark-command)
(define-key evil-emacs-state-map (kbd "C-.") 'pop-to-mark-command)
(define-key evil-visual-state-map (kbd "C-.") 'pop-to-mark-command)

(defun toggle-comment-region ()
"Toggle comment on region if active, otherwise on cunrent line."
(interactive)
(if (region-active-p)
    (let ((start (region-beginning))
        (end (region-end)))
    (comment-or-uncomment-region start end))
(comment-or-uncomment-region (line-beginning-position) (line-end-position))))

(global-set-key (kbd "C-x C-/") 'toggle-comment-region)

;;; Move Text
(require 'move-text)
(global-set-key (kbd "C-S-c") 'move-text-down)
(global-set-key (kbd "C-S-x") 'move-text-up)
(global-set-key (kbd "C-c C-d") 'crux-duplicate-current-line-or-region)

(use-package affe
:ensure t)

(global-set-key(kbd "C-x P p") 'affe-find)
(global-set-key(kbd "C-x i") 'delete-window)
(global-set-key(kbd "C-x k") 'kill-current-buffer)
(global-set-key(kbd "C-x C-x") 'execute-extended-command)

(with-eval-after-load 'magit
(add-hook 'magit-status-mode-hook
        (lambda ()
            (local-set-key (kbd "C-c C-c") 'magit-commit))))

(global-set-key(kbd "C-1") 'scratch-buffer)

(global-unset-key (kbd "C-x C-c"))

(define-key evil-normal-state-map (kbd "C-c C-c") 'compile)
(define-key evil-normal-state-map (kbd "C-x C-c") 'project-compile)
(define-key evil-emacs-state-map (kbd "C-x C-c") 'project-compile)

(defun toggle-maximize-buffer ()
"Maximize buffer if it's not maximized, restore if it is."
(interactive) ;; toggle
(if (= 1 (length (window-list)))
    (jump-to-register '_)
(progn
    (window-configuration-to-register '_)
    (delete-other-windows))))

(global-set-key (kbd "C-x 0") 'toggle-maximize-buffer)
(define-key evil-normal-state-map (kbd ":") 'ignore)
(define-key evil-normal-state-map (kbd ":") 'ignore)
(define-key evil-normal-state-map (kbd "ZZ") 'ignore)
(global-set-key (kbd "C-x c-c") 'ignore )
(global-set-key (kbd "C-x C-b") 'ignore )
(global-set-key (kbd "C-x <") 'ignore )

(use-package vertico
:init
(vertico-mode)
(vertico-flat-mode))

(set-frame-font "Iosevka 17" nil t)
(setq display-line-numbers-type 'relative)
(setq-default display-line-numbers t)


(use-package evil
:ensure t)

(use-package multiple-cursors
:ensure t
:config
(setq mc/always-run-for-all t))

(defun my/mc-temporary-emacs-state ()
(when (bound-and-true-p evil-mode)
(evil-emacs-state)))

(add-hook 'multiple-cursors-mode-enabled-hook 'my/mc-temporary-emacs-state)

(global-set-key (kbd "M-n") 'mc/mark-next-like-this-symbol)
(global-set-key (kbd "M-p") 'mc/mark-previous-like-this-symbol)
(global-set-key (kbd "C-c a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c n") 'mc/mmlte--down)
(global-set-key (kbd "C-c p") 'mc/mmlte--up)

(add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state)

(evil-define-key 'visual global-map
(kbd "C-n") 'mc/mark-next-like-this
(kbd "C-p") 'mc/mark-previous-like-this)

(defun my/mc-mark-next-like-this ()
(interactive)
(when (region-active-p)
(mc/mark-next-like-this-symbol 1)))

(defun my/mc-mark-previous-like-this ()
(interactive)
(when (region-active-p)
(mc/mark-previous-like-this-symbol 1)))

(global-set-key (kbd "C-x C-q") 'wdired-change-to-wdired-mode)

(with-eval-after-load 'compile
(define-key compilation-mode-map (kbd "C-c C-c") 'nil))


(setq magit-display-buffer-function 'magit-display-buffer-fullframe-status-v1)
(setq magit-bury-buffer-function 'magit-restore-window-configuration)


(require 'compile)
compilation-error-regexp-alist-alist

(add-to-list 'compilation-error-regexp-alist
            '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
            1 2 (4) (5)))

(defun newline-above ()
(interactive)
(let ((col (current-column)))
(beginning-of-line)
(open-line 1)
(move-to-column col)))

(defun newline-below ()
(interactive)
(let ((col (current-column)))
(end-of-line)
(open-line 1)
(move-to-column col)))

(global-set-key (kbd "C-S-o") 'newline-above)
(global-set-key (kbd "C-S-l") 'newline-below)
(add-hook 'c-mode-hook
        (lambda ()
        (setq comment-style 'plain)))

(load-theme 'gruber-darker t)
(load-file  custom-file)

