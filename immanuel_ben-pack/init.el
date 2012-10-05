;; User pack init file
;;
;; User this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")

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

;; js2-mode
;; (live-add-pack-lib "js2-mode")
;; (require 'js2-mode)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

;; js snippets for yas
(setq tempytemp load-file-name)
(setq custom-yasnippet-dir (concat (file-name-directory load-file-name) "etc/snippets"))
(setq yas/snippet-dirs (cons custom-yasnippet-dir yas/snippet-dirs))
(yas/reload-all)

;; Hack for indents
(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 1))

(defun shift-left ()
  (interactive)
  (shift-region -1))

(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)
