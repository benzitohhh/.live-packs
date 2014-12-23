;; This file contains keyboard bindings,
;; but also language-specific settings

;; To cycle between frames
(global-set-key "\M-`" 'other-frame)

;; To close a frame (aka window)
(global-set-key (kbd "C-c C-q") 'delete-frame)

;; To open recent files
(global-set-key "\C-x\ \w" 'recentf-open-files)

;; find file (prompts for start dir, then searches recursively)
(global-set-key "\C-x\ f" 'find-name-dired)

;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;; multiple cursors
(global-set-key (kbd "<f1>") 'set-rectangular-region-anchor)
(global-set-key (kbd "<f5>") 'mc/mark-next-like-this)
(global-set-key (kbd "<f6>") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "<f7>") 'mc/mark-all-like-this)

;; Autocomplete
(global-set-key (kbd "C-.") 'auto-complete)
(global-set-key (kbd "C-`") 'ac-expand)

;; ack
(global-set-key (kbd "<f13>") 'ack-find-file)
(global-set-key (kbd "<f15>") 'ack)

;; speedbar
(global-set-key (kbd "<f14>") 'speedbar)

;; git
(global-set-key (kbd "s-r") 'magit-status)
(global-set-key (kbd "<f16>") 'magit-diff)
(global-set-key (kbd "<f17>") 'magit-log)
(global-set-key (kbd "<f18>") 'magit-pull)

;; things to know
(global-set-key (kbd "<f19>") 'open-things-to-know)
(defun open-things-to-know ()
  "Open thingsToKnow.txt"
  (interactive)
  (find-file things-to-know-file))

;; iy-go-to-char - like f in Vim
(global-set-key (kbd "M-m") 'iy-go-to-char)
(global-set-key (kbd "M-M") 'iy-go-to-char-backward)
(key-chord-define-global "fg" 'iy-go-to-char)
(key-chord-define-global "df" 'iy-go-to-char-backward)

;; etags-select-find-tag-at-point
(global-set-key (kbd "M-.") 'etags-select-find-tag-at-point)

;; code folding
(global-set-key (kbd "C-c C-h") 'hide-sublevels)
(global-set-key (kbd "C-c C-a") 'show-all)

;; cleanup
(global-set-key (kbd "C-c n") 'cleanup-buffer)

;; Revert all buffers
(defun revert-all-buffers ()
    "Refreshes all open buffers from their respective files."
    (interactive)
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (and (buffer-file-name) (file-exists-p (buffer-file-name)) (not (buffer-modified-p)))
          (revert-buffer t t t) )))
    (message "Refreshed open files.") )

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

;; align to equals
(defun align-to-equals (begin end)
  "Align region to equal signs"
   (interactive "r")
   (align-regexp begin end "\\(\\s-*\\)=" 1 1 ))
(global-set-key (kbd "C-x a") 'align-to-equals)

;; beautify json
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LANGUAGE-SPECIFIC SETTINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; lispy modes
(add-hook 'emacs-lisp-mode-hook
          (lambda nil
            (idle-highlight t)
            ;; ";l" (hit simultaneously) puts a RET at the end of the line
            (key-chord-define emacs-lisp-mode-map ";l" "\C-e\C-j")))
(add-hook 'scheme-mode-hook
          (lambda nil
            ;; pretty lambdas
            (pretty-lambdas)
            (idle-highlight t)
            ;; ";l" (hit simultaneously) puts a RET at the end of the line
            (key-chord-define scheme-mode-map ";l" "\C-e\C-j")))
(add-hook 'clojure-mode-hook
          (lambda nil
            (idle-highlight t)
            (local-set-key (kbd "s-k") 'cider-find-and-clear-repl-buffer)
            ;; ";l" (hit simultaneously) puts a RET at the end of the line
            (key-chord-define clojure-mode-map ";l" "\C-e\C-j")))
(remove-hook 'nrepl-connected-hook 'cider-display-connected-message) ;; remove annoying startup message
(require 'ac-cider-compliment)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-compliment-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes cider-mode))

;;; js-mode
(add-hook 'js-mode-hook
          (lambda ()
            (idle-highlight t)
            ;; ";;" (double tap) puts a ; at the end of the line
            (key-chord-define js-mode-map ";;" "\C-e;")
            ;; ";l" (hit simultaneously) puts a ;RET at the end of the line
            (key-chord-define js-mode-map ";l" "\C-e;\C-j")
            ;; electric pair
            (electric-pair-mode)))

;;; js2-mode
(add-hook 'js2-mode-hook
          (lambda ()
            (idle-highlight t)
            (key-chord-define js2-mode-map ";;" "\C-e;")
            (key-chord-define js2-mode-map ";l" "\C-e;\C-j")
            (key-chord-define js2-mode-map "kl" "\C-e\C-j")
            (electric-pair-mode)))

;; octave-mode
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-hook 'octave-mode-hook
          (lambda ()
            (auto-complete-mode)
            (idle-highlight t)
            (setq octave-block-offset 4)
            (electric-pair-mode)
            (define-key octave-mode-map (kbd "C-x C-e") 'octave-send-line)
            (define-key octave-mode-map (kbd "C-M-x") 'octave-send-block)))

;;; php-mode
(add-hook 'php-mode-hook
          (lambda ()
            (idle-highlight t)
            ;; (setq indent-tabs-mode nil
            ;;       tab-width 4
            ;;       c-basic-offset 4)
            ;; (c-set-offset 'topmost-intro 4)
            ;; (c-set-offset 'cpp-macro -4)
            (electric-pair-mode)
            
            ;; ";;" (double tap) puts a ; at the end of the line
            (key-chord-define php-mode-map ";;" "\C-e;")
            ;; ";RET" (hit simultaneously) puts a ;RET at the end of the line
            (key-chord-define php-mode-map ";l" "\C-e;\C-j")
            (key-chord-define php-mode-map "kl" "\C-e\C-j")
            ;;(setq outline-regexp " *\\(private funct\\|public funct\\|funct\\|class\\|#head\\)")
            ))

;; python-mode

(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import pdb")
  (highlight-lines-matching-regexp "pdb.set_trace()"))

(defun python-add-breakpoint ()
  (interactive)
  (newline-and-indent)
  (insert "import pdb; pdb.set_trace()")
  (newline-and-indent)
  (annotate-pdb))

(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;; python code completion (jedi)
(autoload 'jedi:setup "jedi" nil t)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)

(add-hook 'python-mode-hook
          (lambda ()
            (jedi:setup)
            (idle-highlight t)
            (key-chord-define python-mode-map ";l" "\C-e\C-j")
            (key-chord-define python-mode-map ";'" "\C-e:\C-j")
            (define-key python-mode-map "\"" 'electric-pair)
            (define-key python-mode-map "\'" 'electric-pair)
            (define-key python-mode-map "(" 'electric-pair)
            (define-key python-mode-map "[" 'electric-pair)
            (define-key python-mode-map "{" 'electric-pair)
            (define-key python-mode-map (kbd "C-c C-t") 'python-add-breakpoint)
            (setq outline-regexp " *\\(def \\|clas\\|#hea\\)")
            (annotate-pdb)))

;; css-mode
(add-hook 'css-mode-hook
          (lambda ()
            (idle-highlight t)
            (key-chord-define css-mode-map ";;" "\C-e;")
            (key-chord-define css-mode-map ";l" "\C-e;\C-j")
            (key-chord-define js2-mode-map "kl" "\C-e\C-j")
            (electric-pair-mode)))

;; html mode
(add-hook 'sgml-mode-hook
          (lambda ()
            (require 'rename-sgml-tag)
            (idle-highlight t)
            (key-chord-define sgml-mode-map ";l" "\C-e\C-j")
            (key-chord-define sgml-mode-map "kl" "\C-e\C-j")
            (electric-pair-mode)))
