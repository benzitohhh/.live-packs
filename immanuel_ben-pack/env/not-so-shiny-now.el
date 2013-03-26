;; Set default emacs C source directory
(setq source-directory "/usr/local/emacs/emacs-24.3")

;; Git support
(add-to-list 'load-path "/usr/local/git/contrib/emacs")

;; full-ack
(setq ack-executable "/usr/local/bin/ack")

;; python executable (i.e as of March 2013, ipython emacs osx does not seem to work)
;;(setq python-shell-interpreter "/usr/local/bin/ipython")

;; default directory
(setq default-directory "~/Desktop/")

;; visit tags
;(visit-tags-table "/Volumes/PwC-VM/TAGS")
