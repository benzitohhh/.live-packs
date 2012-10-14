;; User pack init file
;;
;; User this file to initiate the pack configuration.
;; See README for more information.

;; Set default emacs C source directory
(setq source-directory "/usr/local/emacs/emacs-24.2")

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

;; etags-select
(live-add-pack-lib "etags-select")
(require 'etags-select)

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

(add-hook 'python-mode-hook
     (lambda ()
      (define-key python-mode-map "\"" 'electric-pair)
      (define-key python-mode-map "\'" 'electric-pair)
      (define-key python-mode-map "(" 'electric-pair)
      (define-key python-mode-map "[" 'electric-pair)
      (define-key python-mode-map "{" 'electric-pair)))
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;; js-mode    (as opposed to js2-mode below)
;(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

;; js2-mode   (as opposed to js-mode above)
(live-add-pack-lib "js2-mode")
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

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
