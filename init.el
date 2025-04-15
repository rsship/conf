(delete-selection-mode 1)
(line-number-mode 1)
(column-number-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
(setq dired-dwim-target t)

(setq lsp-diagnostics-provider :none)
(setq split-width-threshold nil)
(setq sp-ui-sideline-enable nil)
(setq sp-modeline-diagnostics-enable nil)
(setq sp-signature-render-documentation nil)
(setq sp-enable-symbol-highlighting nil)
(setq sp-headerline-breadcrumb-enable nil)
(setq lsp-headerline-breadcrumb-enable nil)
(setq ring-bell-function 'ignore)
(setq-default comment-style 'plain)
(setq initial-scratch-message nil)

(setq-default inhibit-splash-screen t
             make-backup-files nil
             tab-width 4
             indent-tabs-mode nil
             compilation-scroll-output t)


(setq custom-file "~/.emacs.d/custom.el")
(load "~/.emacs.d/.emacs.local/simpc-mode.el")
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(load "~/.emacs.d/gnu-elpa-keyring/gnu-elpa-keyring-update.el")
(setq custom-file "~/.emacs.d/custom.el")
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq package-archives
     '(("melpa" . "https://melpa.org/packages/")
       ("org"   . "https://orgmode.org/elpa/")
       ("gnu"   . "https://elpa.gnu.org/packages/")))

(set-frame-font "Iosevka 17" nil t)
(setq display-line-numbers-type 'relative)
(setq package-archives
     '(("melpa" . "https://melpa.org/packages/")
       ("org"   . "https://orgmode.org/elpa/")
       ("gnu"   . "https://elpa.gnu.org/packages/")))

(set-frame-font "Iosevka 17" nil t)
(load-theme 'gruber-darker t)

(setq mac-command-modifier 'control)
(setq mac-control-modifier 'meta)

(use-package company
   :init
   (add-hook 'after-init-hook 'global-company-mode)
   :config
   (setq company-idle-delay 0.2)
   (setq company-minimum-prefix-length 1)
   (setq company-tooltip-align-annotations t))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion--category-override '((file (styles basic partial-completions)))))

(use-package vertico
  :init
  (vertico-mode)
  (vertico-flat-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion--category-override '((file (styles basic partial-completions)))))

(use-package vertico
  :init
  (vertico-mode)
  (vertico-flat-mode))

(require 'smartparens-config)
(smartparens-global-mode 1)

(global-set-key (kbd "C-f") 'forward-word)  
(global-set-key (kbd "C-b") 'backward-word)
(global-set-key (kbd "M-f") 'forward-char)  
(global-set-key (kbd "M-b") 'backward-char)
(global-set-key (kbd "C-d") 'kill-word)
(global-set-key (kbd "M-d") 'delete-char)
(global-set-key (kbd "C-x C-]") 'split-window-vertically)
(global-set-key (kbd "C-x gg") 'beginning-of-buffer)
(global-set-key (kbd "C-x G") 'end-of-buffer)
(global-set-key (kbd "C-}") 'forward-paragraph)
(global-set-key (kbd "C-{") 'backward-paragraph)
(global-set-key (kbd "C-v") 'mark-paragraph)
(global-set-key (kbd "C-x .") 'string-rectangle)
(global-set-key (kbd "C-x C-/") 'comment-or-uncomment-region)

(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this) 
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this) 
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this) 
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-1") 'scratch-buffer)


(global-set-key (kbd "C-:") 'goto-line)
(global-set-key (kbd "C-x C-c") 'compile)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-+") 'indent-region)
(global-set-key (kbd "C-w") 'kill-ring-save)
(global-set-key (kbd "C-q") 'kill-region)

(defun rc/toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(global-set-key (kbd "C-x 0") 'rc/toggle-maximize-buffer)
(global-unset-key (kbd "C-x C-d"))


(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'rc/duplicate-line)

(defun rc/kill-autoloads-buffers ()
  (interactive)
  (dolist (buffer (buffer-list))
    (let ((name (buffer-name buffer)))
      (when (string-match-p "-autoloads.el" name)
        (kill-buffer buffer)
        (message "Killed autoloads buffer %s" name)))))

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc|mm]\\(pp\\)?\\'" . simpc-mode))
