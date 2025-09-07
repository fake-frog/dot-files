;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v dvoom-font' for documentation and more examples of what they
;; accept. For example:

;;    (set-frame-font "terminus-20" nil t)

(setq doom-font (font-spec :family "UW Ttyp0" :size 18 :weight 'normal :slant 'normal))

(add-to-list 'default-frame-alist '(internal-border-width . 40))

(setq-default tab-width 2
              indent-tabs-mode nil)
(setq tab-stop-list (number-sequence 2 60 2))

(setq all-the-icons-scale-factor 0.7)
(setq nerd-icons-scale-factor 0.7)

(after! doom-modeline
  (setq doom-modeline-icon nil))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(add-to-list 'custom-theme-load-path "~/.config/doom/themes/")

(setq doom-theme 'oblong)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

(map! "C-;" #'avy-goto-word-1)
(map! "C-'" #'avy-goto-char-timer)
(map! "C-c r" #'anzu-query-replace)
(map! "C-c d" #'duplicate-line)
(map! "C-d" #'mc/mark-next-like-this)
(map! :map c-mode-map
      "C-d" #'mc/mark-next-like-this)
(map! "M-n" #'+vc-gutter/stage-hunk)
(map! "M-o" #'magit-commit-create)
(map! "M-p" #'magit-push)

;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq backup-directory-alist '(("." . "~/.emacs-backups")))

(setq window-divider-default-bottom-width 0)
(window-divider-mode -1)

;; Swiper configuration
(use-package! swiper
  :bind ("C-s" . swiper))

;; Pulsar configuration
(use-package! pulsar
  :config
  (pulsar-global-mode 1)
  (setq pulsar-delay 0.04
        pulsar-iterations 5
        pulsar-face 'region)
  (setq pulsar-pulse-functions
        '(recenter-top-bottom
          move-to-window-line-top-bottom
          reposition-window
          scroll-down-command
          forward-page
          backward-page
          avy-goto-char-timer
          avy-goto-char
          avy-goto-char-2
          avy-goto-line
          avy-goto-word-1)))

(use-package! avy
  :config
  (setq avy-all-windows 'all-frames))


(setq-default left-margin-width 1)
