;; User pack init file
;;
;; User this file to initiate the pack configuration.
;; See README for more information.

;; Emacs shell reads ~/.bashrc by default, so on OSX do:
;;    ln -s .bash_profile .bashrc

;; Set default emacs C source directory
(setq source-directory "/usr/local/emacs/emacs-24.2")
;(setq source-directory "/Users/beni/usr/local/emacs/emacs-24.2")

;; Git support
(add-to-list 'load-path "/usr/local/git/contrib/emacs")
;(add-to-list 'load-path "/Users/beni/usr/local/git/contrib/emacs")
(require 'git)
(require 'git-blame)

;; full-ack
(live-add-pack-lib "full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
(setq ack-executable "/usr/local/bin/ack")
;(setq ack-executable "/Users/beni/usr/local/bin/ack")

;; default directory
(setq default-directory "~/Desktop/")
;(setq default-directory "/Users/beni/LOreal/Prototypes/Platform/base/" )

;; set indent-level for html
(setq sgml-basic-offset 4)

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

;; alternative color-themes
(add-hook 'emacs-lisp-mode-hook
          (lambda nil
            (color-theme-buffer-local 'color-theme-cyberpunk (current-buffer))))
(add-hook 'clojure-mode-hook
          (lambda nil
            (color-theme-buffer-local 'color-theme-cyberpunk (current-buffer))))

;; Magit
(live-add-pack-lib "magit-1.1.1")
(require 'magit)
(global-set-key (kbd "s-r") 'magit-status)

;; monky (mercurial support)
(live-add-pack-lib "monky")
(require 'monky)
;; Add the below if monky is slow
;;(setq monky-process-type 'cmdserver)

;; build-ctags-git
(live-add-pack-lib "build-ctags-git")
(require 'build-ctags-git)

;; etags-select
(live-add-pack-lib "etags-select")
(require 'etags-select)

;; ben-scp
(live-add-pack-lib "ben-scp")
(require 'ben-scp)

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

;; textmate
;(live-add-pack-lib "textmate")
;(require 'textmate)
;(textmate-mode)

;; zenburn-theme
;(live-add-pack-lib "zenburn-theme")
;(require 'zenburn-theme)

;; js-mode    (as opposed to js2-mode below)
;(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

;; js2-mode   (as opposed to js-mode above)
(live-add-pack-lib "js2-mode")
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; php-mode
(live-add-pack-lib "php-mode")
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php" . html-mode))

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

;; js-comint
;; (live-add-pack-lib "js-comint")
;; (require 'js-comint)
;; Use node as our repl
(setq inferior-js-program-command "node")
(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list 'comint-preoutput-filter-functions
                     (lambda (output)
                       (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                                                 (replace-regexp-in-string ".*1G.*3G" ">" output))))))

;; Load bindings config
(live-load-config-file "bindings.el")
