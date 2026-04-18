(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(set-fringe-mode 10)
(global-set-key (kbd "C-d") 'delete-backward-char)
(with-eval-after-load 'cc-mode
  (define-key c-mode-base-map (kbd "C-d") 'delete-backward-char))
(global-set-key (kbd "C-u") 'undo)
(global-set-key (kbd "C-r") 'undo-redo)
(global-set-key (kbd "M-s") 'isearch-backward)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)
(setq-default truncate-lines t)
(setq scroll-conservatively 101)
(electric-pair-mode 1)
(global-display-line-numbers-mode 1)
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/backups/" t)))
(add-to-list 'custom-theme-load-path "~/system-themes/min-bling")
(add-to-list 'custom-theme-load-path "~/cloudy-theme")
(load-theme 'min-bling t)

;; Package setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(dolist (pkg '(swiper avy ivy clang-format multiple-cursors magit diff-hl 
               corfu corfu-terminal orderless cape indent-guide))
  (unless (package-installed-p pkg)
    (package-refresh-contents)
    (package-install pkg)))

(global-set-key (kbd "C-x g") 'magit-status)
(global-diff-hl-mode 1)

(indent-guide-global-mode 1)

;; Format on save for C/C++
(add-hook 'c-mode-hook
          (lambda () (add-hook 'before-save-hook 'clang-format-buffer nil 'local)))
(add-hook 'c++-mode-hook
          (lambda () (add-hook 'before-save-hook 'clang-format-buffer nil 'local)))

;; Ivy / Swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(global-set-key (kbd "C-s") 'swiper)

;; Orderless completion style

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

;; Corfu (in-buffer popup completion)
(unless (display-graphic-p)
  (require 'corfu-terminal)
  (corfu-terminal-mode +1))

(require 'corfu)

(setq corfu-auto t
      corfu-auto-delay 0.2
      corfu-auto-prefix 2
      corfu-quit-no-input t)
(global-corfu-mode 1)

;; Cape (extra completion sources)
(require 'cape)
(add-hook 'prog-mode-hook
          (lambda ()
            (add-to-list 'completion-at-point-functions #'cape-file)
            (add-to-list 'completion-at-point-functions #'cape-dabbrev)))

;; Eglot (LSP) for C
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Avy / multiple-cursors
(global-set-key (kbd "C-i") 'avy-goto-char-timer)
(require 'multiple-cursors)
(global-set-key (kbd "M-;") 'mc/mark-next-like-this)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(avy cape clang-format company corfu corfu-terminal diff-hl
	 hl-indent-scope indent-guide magit multiple-cursors orderless
	 swiper)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
