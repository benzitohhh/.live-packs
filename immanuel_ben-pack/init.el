;; User pack init file
;;
;; User this file to initiate the pack configuration.
;; See README for more information.

;; Emacs shell reads ~/.bashrc by default, so on OSX do:
;;    ln -s .bash_profile .bashrc

;; full-ack
(live-add-pack-lib "full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; set indent-level for html
(setq sgml-basic-offset 4)

;; set indent-level for js
(setq js2-indent-level 4)

;; make sure whitespace-cleanup not being used
(remove-hook 'before-save-hook 'whitespace-cleanup)

;; prevent files opened from finder opening in new frame
(setq ns-pop-up-frames nil)

;; Don't break lines for me, please
(setq-default truncate-lines t)

;; color-theme-buffer-local
(live-add-pack-lib "color-theme-buffer-local")
(require 'color-theme-buffer-local)
(require 'load-theme-buffer-local)

;; main colour-theme
(load-theme 'deeper-blue)

;; zenburn-theme
;(live-add-pack-lib "zenburn-theme")
;(require 'zenburn-theme)

;; alternative color-themes
(add-hook 'emacs-lisp-mode-hook
          (lambda nil
            (color-theme-buffer-local 'color-theme-cyberpunk (current-buffer))))
(add-hook 'clojure-mode-hook
          (lambda nil
            (color-theme-buffer-local 'color-theme-cyberpunk (current-buffer))))

;; Magit (git support)
;(require 'git)
;(require 'git-blame)

;; monky (mercurial support)
;;(live-add-pack-lib "monky")
;;(require 'monky)
;; Add the below if monky is slow
;;(setq monky-process-type 'cmdserver)

;; build-ctags-git
(live-add-pack-lib "build-ctags-git")
(require 'build-ctags-git)

;; etags-select
(live-add-pack-lib "etags-select")
(require 'etags-select)

;; shell-command
(live-add-pack-lib "shell-command")
(require 'shell-command)
(eval-after-load 'shell '(require 'setup-shell))
(add-hook 'shell-mode-hook (lambda () (toggle-truncate-lines -1)))

;; misc
(live-add-pack-lib "misc")
(require 'misc)

;; expand-region
(live-add-pack-lib "expand-region")
(require 'expand-region)

;; mark-multiple
(live-add-pack-lib "mark-multiple")
(require 'mark-multiple)

;; multiple-cursors
(live-add-pack-lib "multiple-cursors")
(require 'multiple-cursors)

;; zencoding
(live-add-pack-lib "zencoding")
(require 'zencoding-mode)

;;(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; php-mode
(live-add-pack-lib "php-mode")
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php" . html-mode))
(add-to-list 'auto-mode-alist '("\\.module" . php-mode))

;; less-css-mode
(live-add-pack-lib "less-css-mode")
(require 'less-css-mode)

;; extra snippets for yas
(setq custom-yasnippet-dir (concat (file-name-directory load-file-name) "etc/snippets"))
(setq yas/snippet-dirs (cons custom-yasnippet-dir yas/snippet-dirs))
(yas/reload-all)

;; hack to allow yas tab within js2-mode
;; try running this if you have yas vs js2 conflicts...
;; (eval-after-load 'js2-mode
;;   '(progn
;;      (define-key js2-mode-map (kbd "TAB")
;;        (lambda()
;;          (interactive)
;;          (let ((yas/fallback-behavior 'return-nil))
;;            (unless (yas/expand)
;;              (indent-for-tab-command)
;;              (if (looking-back "^\s*")
;;                  (back-to-indentation))))))))

;; Load bindings config
(live-load-config-file "bindings.el")
