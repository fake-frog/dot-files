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

(electric-pair-mode 1)

(add-to-list 'custom-theme-load-path "~/oblong-theme")
(load-theme 'minoblong t)

;; Package setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'swiper)
  (package-refresh-contents)
  (package-install 'swiper))
(unless (package-installed-p 'avy)
  (package-install 'avy))
(unless (package-installed-p 'company)
  (package-install 'company))
(unless (package-installed-p 'ivy)
  (package-install 'ivy))
(unless (package-installed-p 'clang-format)
  (package-install 'clang-format))
(unless (package-installed-p 'multiple-cursors)
  (package-install 'multiple-cursors))

;; Format on save for C/C++ modes
(add-hook 'c-mode-hook
          (lambda () (add-hook 'before-save-hook 'clang-format-buffer nil 'local)))
(add-hook 'c++-mode-hook
          (lambda () (add-hook 'before-save-hook 'clang-format-buffer nil 'local)))

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;; Enable completion
(add-hook 'after-init-hook 'global-company-mode)

;; Keybindings
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-i") 'avy-goto-char-timer)

(require 'multiple-cursors)
(global-set-key (kbd "M-;") 'mc/mark-next-like-this)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(avy clang-format company multiple-cursors swiper)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
