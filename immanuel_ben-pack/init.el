;; User pack init file
;;
;; User this file to initiate the pack configuration.
;; See README for more information.

;; Set default emacs C source directory
(setq source-directory "/usr/local/emacs/emacs-24.2")

;; Set binding for opening recent files
(global-set-key "\C-x\ \w" 'recentf-open-files)

;; Git support
(add-to-list 'load-path "/usr/local/git/contrib/emacs")
(require 'git)
(require 'git-blame)

;; Magit
(live-add-pack-lib "magit-1.1.1")
(require 'magit)
(global-set-key (kbd "s-r") 'magit-status)

;; build-ctags-git
(live-add-pack-lib "build-ctags-git")
(require 'build-ctags-git)

;; multiple-cursors
(live-add-pack-lib "multiple-cursors")
(require 'multiple-cursors)

;; etags-select
(live-add-pack-lib "etags-select")
(require 'etags-select)

;; js-mode    (as opposed to js2-mode below)
;(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

;; js2-mode   (as opposed to js-mode above)
(live-add-pack-lib "js2-mode")
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; js snippets for yas
(setq tempytemp load-file-name)
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
