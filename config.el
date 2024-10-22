;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-login-name "AlexxSap"
      user-mail-address "alexxandrsap@mail.ru")

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 16))

;; disable exit confirmation
(setq confirm-kill-emacs nil)

;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; show relative row numbers
(setq display-line-numbers-type 'relative)

;; hide hidden files in tree
(setq treemacs-show-hidden-files nil)

;;instal lsp package
(require 'lsp-mode)

;; hooks for golang - format and add imports on save
(add-hook 'go-mode-hook #'lsp-deferred)
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; keys for dired navigation
(evil-define-key 'normal dired-mode-map
  (kbd "l") 'dired-find-file
  (kbd "h") 'dired-up-directory)

;; comments
(map! "C-/" #'comment-line)

;; dashboard settings
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-loaded)
(setq fancy-splash-image (concat doom-user-dir "lenin3.svg"))
(add-hook! '+doom-dashboard-functions :append
  (insert "\n" (+doom-dashboard--center +doom-dashboard--width "Пролетарии всех стран, соединяйтесь!")))

;; org settings
;; source code pretty
(setq org-src-fontify-natively t)

;; begin and end block smaller
(custom-set-faces
 '(org-block-begin-line
   ((t (:height 0.8 :extend t :weight bold))))
 '(org-block-end-line
   ((t (:height 0.8 :extend t :weight bold)))))

;; set headers size
(defun my-org-faces ()
  (set-face-attribute 'org-level-1 nil :height 1.2)
  (set-face-attribute 'org-level-2 nil :height 1.2)
  (set-face-attribute 'org-level-3 nil :height 1.2)
  (set-face-attribute 'org-level-4 nil :height 1.2))
(add-hook 'org-mode-hook #'my-org-faces)

;; hide Org markup indicators.
(after! org (setq org-hide-emphasis-markers t))

(map! :leader
      (:prefix ("t")
       :desc "pretty org mode" "o" #'+org-pretty-mode))

;; eshell toggle keys
(map! :leader
      :desc "Eshell"                 "e s" #'eshell
      :desc "Eshell popup toggle"    "e t" #'+eshell/toggle)

;; disable flymake - not support c++20 and 23
(setq flymake-start-on-flymake-mode nil)
(setq flymake-start-on-save-buffer nil)
