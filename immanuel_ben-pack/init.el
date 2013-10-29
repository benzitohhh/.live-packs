;; User pack init file
;;
;; User this file to initiate the pack configuration.
;; See README for more information.

;; Emacs shell reads ~/.bashrc by default, so on OSX do:
;;    ln -s .bash_profile .bashrc

;; add Marmalade package archive
(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; full-ack
(live-add-pack-lib "full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; set indent-level for html
(setq sgml-basic-offset 4)

;; set indent-level for js
(setq js-indent-level 2)
(custom-set-variables  
 '(js2-basic-offset 2)  
 '(js2-bounce-indent-p t)  
)

;; make sure whitespace-cleanup not being used
(remove-hook 'before-save-hook 'whitespace-cleanup)
(remove-hook 'before-save-hook 'live-cleanup-whitespace)

;; Unix utf8 please
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)

;; set colours for whitespace-mode
(setq whitespace-style (quote (spaces tabs newline space-mark tab-mark newline-mark)))

;; prevent files opened from finder opening in new frame
(setq ns-pop-up-frames nil)

;; Don't break lines for me, please
(setq-default truncate-lines t)

;; Set ediff to split vertically (default is horizontal)
(setq ediff-split-window-function 'split-window-horizontally)

;; color-theme-buffer-local
(live-add-pack-lib "color-theme-buffer-local")
(require 'color-theme-buffer-local)
(require 'load-theme-buffer-local)

;; zenburn-theme
(live-add-pack-lib "zenburn-theme")
(require 'zenburn-theme)

;; blue colour-theme
;(load-theme 'deeper-blue)

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

;; idle-highlight-mode
(live-add-pack-lib "idle-highlight-mode")
(require 'idle-highlight-mode)

;; mark-multiple
(live-add-pack-lib "mark-multiple")
(require 'mark-multiple)

;; zencoding
(live-add-pack-lib "zencoding")
(require 'zencoding-mode)

;; scheme-complete
(live-add-pack-lib "scheme-complete")
(require 'scheme-complete)

(defun pretty-lambdas ()
    (font-lock-add-keywords
     nil `(("(\\(lambda\\>\\)"
            (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                      ,(make-char 'greek-iso8859-7 107))
                      nil))))))

;; javascript
(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json" . js-mode))

;; php-mode
(live-add-pack-lib "php-mode")
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php" . php-mode))
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
