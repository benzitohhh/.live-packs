;; Place your bindings here.

;; For example:
;;(define-key global-map (kbd "C-+") 'text-scale-increase)
;;(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Map OSX command-key to M-
;(setq mac-command-modifier 'meta)

;; To cycle between frames
(global-set-key "\M-`" 'other-frame)

;; To close a frame (aka window)
(global-set-key (kbd "C-c C-q") 'delete-frame)

;; Set binding for opening recent files
(global-set-key "\C-x\ \w" 'recentf-open-files)

;; Autocomplete
(global-set-key (kbd "C-`") 'ac-expand)

;; ackf
(global-set-key (kbd "<f13>") 'ack-find-file)
;; ack
(global-set-key (kbd "<f15>") 'ack)

;; Mercurial
(global-set-key (kbd "<f16>") 'monky-status)
(global-set-key (kbd "<f17>") 'monky-log)
(global-set-key (kbd "<f18>") 'monky-pull)
(global-set-key (kbd "<f19>") 'monky-push)

;; iy-go-to-char - like f in Vim
(global-set-key (kbd "M-m") 'iy-go-to-char)
(global-set-key (kbd "M-M") 'iy-go-to-char-backward)
(key-chord-define-global "fg" 'iy-go-to-char)
(key-chord-define-global "df" 'iy-go-to-char-backward)

;;; js-mode
(add-hook 'js-mode-hook
          (lambda ()
            ;; ";;" (double tap) puts a ; at the end of the line
            (key-chord-define js-mode-map ";;" "\C-e;")
            ;; ";RET" (hit simultaneously) puts a ;RET at the end of the line
            (key-chord-define js-mode-map ";l" "\C-e;\C-j")
            ;; electric pair
            (electric-pair-mode)
            ;; Scan the file for nested code blocks
            (imenu-add-menubar-index)
            ;; Activate the folding mode
            (hs-minor-mode t)))

;;; js2-mode
;; ";;" (double tap) puts a ; at the end of the line
(key-chord-define js2-mode-map ";;" "\C-e;")
(key-chord-define js2-mode-map ";l" "\C-e;\C-j")
(key-chord-define js2-mode-map "kl" "\C-e\C-j")
(add-hook 'js2-mode-hook
          (lambda ()
            (electric-pair-mode)
            ;; Scan the file for nested code blocks
            (imenu-add-menubar-index)
            ;; Activate the folding mode
            (hs-minor-mode t)))

;;; php-mode
;; ";;" (double tap) puts a ; at the end of the line
(key-chord-define php-mode-map ";;" "\C-e;")
;; ";RET" (hit simultaneously) puts a ;RET at the end of the line
(key-chord-define php-mode-map ";l" "\C-e;\C-j")
(add-hook 'php-mode-hook
          (lambda ()
            (setq c-basic-offset 4)
            ;(c-set-offset 'topmost-intro 4)
            ;(c-set-offset 'cpp-macro -4)
            ))

;; python-mode
(require 'python)
(key-chord-define python-mode-map ";l" "\C-e\C-j")
(key-chord-define python-mode-map ";'" "\C-e:\C-j")
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


;; code folding
(global-set-key (kbd "C-c C-h") 'hs-toggle-hiding)
(global-set-key (kbd "C-c C-j") 'hs-show-all)

;; misc stuff
(global-set-key (kbd "C-c n") 'cleanup-buffer)


(add-hook 'css-mode-hook
          (lambda ()
            ;; ";;" (double tap) puts a ; at the end of the line
            (key-chord-define css-mode-map ";;" "\C-e;")
            (key-chord-define css-mode-map ";l" "\C-e;\C-j")
            (key-chord-define js2-mode-map "kl" "\C-e\C-j")
            ;; electric pair
            (electric-pair-mode)))

;; html stuff
(add-hook 'sgml-mode-hook
          (lambda ()
            (require 'rename-sgml-tag)
            (key-chord-define sgml-mode-map ";l" "\C-e\C-j")
            (key-chord-define js2-mode-map "kl" "\C-e\C-j")
            (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)
            (zencoding-mode)
            (electric-pair-mode)))
(eval-after-load 'zencoding-mode
  '(progn
     (define-key zencoding-mode-keymap (kbd "C-j") nil)
     (define-key zencoding-mode-keymap (kbd "<C-return>") nil)
     (define-key zencoding-mode-keymap (kbd "C-c C-j") 'zencoding-expand-line)

     (defun zencoding-indent (text)
       "Indent the text"
       (if text
           (replace-regexp-in-string "\n" "\n  " (concat "\n" text))
         nil))
     ))

;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;; multiple cursors
(global-set-key (kbd "<f1>") 'set-rectangular-region-anchor)
(global-set-key (kbd "<f5>") 'mc/mark-next-like-this)
(global-set-key (kbd "<f6>") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "<f7>") 'mc/mark-all-like-this)

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
