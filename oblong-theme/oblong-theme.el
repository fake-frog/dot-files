(deftheme oblong "MISS-SHAPPEN AND CYBERPUNK")

;; Color palette - customize these
(let ((bg       "#000000")    ; XTerm background
      (fg       "#aaaaaa")    ; XTerm foreground
      (bg-alt   "#111111")    ; XTerm color8/color2
      (fg-alt   "#666666")    ; XTerm color1
      (accent   "#ba4a16")    ; XTerm bright cyan
      (light-grey   "#bbbbbb")    ; XTerm color11
      (green    "#22998f")    ; XTerm color6 (teal)
      (cyan     "#34e0c1")    ; XTerm bright cyan
      (purple   "#f752cb")    ; XTerm magenta
      (selection "#222222")
      (orange-alt "salmon"))  ; XTerm highlight background

  (custom-theme-set-faces
   'oblong

   ;; Base faces
   `(default ((t (:foreground ,fg :background ,bg))))
   `(cursor ((t (:background ,accent))))
   `(region ((t (:foreground ,fg :background ,selection))))
   `(highlight ((t (:background ,selection))))
   `(hl-line ((t (:background ,bg-alt))))
   `(fringe ((t (:background ,bg :foreground ,fg-alt))))
   `(vertical-border ((t (:foreground ,bg-alt))))

   ;; Font lock (syntax highlighting)
   `(font-lock-comment-face ((t (:foreground ,accent))))
   `(font-lock-doc-face ((t (:foreground ,accent))))
   `(font-lock-string-face ((t (:foreground ,fg :background ,selection))))
   `(font-lock-keyword-face ((t (:foreground ,orange-alt))))
   `(font-lock-builtin-face ((t (:foreground ,green))))
   `(font-lock-function-name-face ((t (:foreground ,purple))))
   `(font-lock-variable-name-face ((t (:foreground ,purple))))
   `(font-lock-type-face ((t (:foreground ,cyan))))
   `(font-lock-constant-face ((t (:foreground ,purple))))
   `(font-lock-warning-face ((t (:foreground ,accent))))
   `(font-lock-negation-char-face ((t (:foreground ,accent))))
   `(button ((t (:foreground ,bg :background ,accent))))

   ;; Mode line
   `(mode-line ((t (:foreground ,fg :background ,selection ))))
   `(mode-line-inactive ((t (:foreground ,fg-alt :background ,bg-alt :box (:line-width 1 :color ,bg-alt)))))
   `(mode-line-buffer-id ((t (:weight bold))))

   ;; Minibuffer
   `(minibuffer-prompt ((t (:foreground ,accent :weight bold))))

   ;; Search
   `(isearch ((t (:foreground ,bg :background ,light-grey :weight bold))))
   `(lazy-highlight ((t (:foreground ,fg :background ,bg-alt :underline t))))

   ;; Line numbers
   `(line-number ((t (:foreground ,fg-alt :background ,bg))))
   `(line-number-current-line ((t (:foreground ,accent :background ,bg :weight bold))))

   ;; Parentheses matching
   `(show-paren-match ((t (:foreground ,light-grey :background ,bg :weight bold))))
   `(show-paren-mismatch ((t (:foreground ,accent :background ,bg :weight bold))))

   ;; Error/warning faces
   `(error ((t (:foreground ,accent :weight bold))))
   `(warning ((t (:foreground ,accent :weight bold))))
   `(success ((t (:foreground ,green :weight bold))))

   ;; Error highlighting

   ;; Diagnostic severity levels
   `(lsp-lsp-flycheck-error-unnecessary-face ((t (:foreground ,selection :underline nil))))
   `(lsp-lsp-flycheck-warning-unnecessary-face ((t (:foreground ,selection :underline nil))))
   
   ;; LSP UI faces (if using lsp-ui)
   `(lsp-ui-doc-background ((t (:background ,selection))))
   `(lsp-ui-doc-header ((t (:foreground ,selection))))
   `(lsp-ui-peek-filename ((t (:foreground ,accent))))
   `(lsp-ui-peek-header ((t (:background ,selection))))
   `(lsp-ui-sideline-code-action ((t (:foreground ,accent))))

   `(lsp-face-highlight-read ((t (:background ,selection))))
   `(lsp-face-highlight-write ((t (:background ,selection))))
   `(lsp-face-highlight-textual ((t (:background ,selection))))

   `(popup-tip-face ((t (:background ,accent :foreground ,bg))))

   ;; Dired
   `(dired-directory ((t (:foreground ,cyan :weight bold))))
   `(dired-symlink ((t (:foreground ,cyan))))
   `(dired-executable ((t (:foreground ,green))))

   `(minibuffer-prompt ((t (:foreground ,accent :weight bold))))
   `(help-key-binding ((t (:foreground ,accent :background ,bg))))
   `(read-multiple-choice-face ((t (:foreground ,accent :weight bold))))

   ;; Company (autocomplete)
   `(company-tooltip ((t (:foreground ,fg :background ,bg-alt))))
   `(company-tooltip-selection ((t (:foreground ,fg :background ,selection))))
   `(company-tooltip-common ((t (:foreground ,accent :weight bold))))

   ;; Org mode
   `(org-level-1 ((t (:foreground ,cyan :weight bold :height 1.3))))
   `(org-level-2 ((t (:foreground ,purple :weight bold :height 1.2))))
   `(org-level-3 ((t (:foreground ,green :weight bold :height 1.1))))
   `(org-level-4 ((t (:foreground ,accent :weight bold))))
   `(org-code ((t (:foreground ,cyan :background ,bg-alt))))
   `(org-block ((t (:background ,bg-alt))))
   `(org-block-begin-line ((t (:foreground ,accent :background ,bg-alt))))
   `(org-block-end-line ((t (:inherit org-block-begin-line))))

   ;; Markdown
   `(markdown-header-face-1 ((t (:inherit org-level-1))))
   `(markdown-header-face-2 ((t (:inherit org-level-2))))
   `(markdown-header-face-3 ((t (:inherit org-level-3))))
   `(markdown-code-face ((t (:inherit org-code))))

   ;; Git (magit)
   `(magit-branch-local ((t (:foreground ,cyan))))
   `(magit-branch-remote ((t (:foreground ,green))))
   `(magit-diff-added ((t (:foreground ,green :background ,(concat green "20")))))
   `(magit-diff-removed ((t (:foreground ,accent :background ,(concat accent "20")))))
   `(magit-diff-context ((t (:foreground ,fg-alt))))

   ;; Which-key
   `(which-key-key-face ((t (:foreground ,accent :weight bold))))
   `(which-key-description-face ((t (:foreground ,fg))))
   `(which-key-group-description-face ((t (:foreground ,purple))))

   ;; Helm/Ivy
   `(helm-selection ((t (:background ,selection))))
   `(ivy-current-match ((t (:background ,selection :weight bold))))
   `(ivy-minibuffer-match-face-1 ((t (:foreground ,accent))))

   ;; In your deftheme faces list
   `(vterm-color-black ((t ( :foreground ,bg :background ,bg))))
   `(vterm-color-red ((t ( :foreground ,accent :background ,accent))))
   `(vterm-color-green ((t ( :foreground ,green :background ,green))))
   `(vterm-color-yellow ((t ( :foreground ,light-grey :background ,light-grey))))
   `(vterm-color-blue ((t ( :foreground ,cyan :background ,cyan))))
   `(vterm-color-magenta ((t ( :foreground ,purple :background ,purple))))
   `(vterm-color-cyan ((t ( :foreground ,cyan :background ,cyan))))
   `(vterm-color-white ((t( :foreground ,fg :background ,fg))))

   ))



(provide-theme 'oblong)

;;; oblong-theme.el ends here
