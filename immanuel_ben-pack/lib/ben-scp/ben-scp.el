
(setq
 ben-scp-source-base-dir          "/Users/beni/LOreal/Prototypes/Platform/base/"
 ben-scp-source-prototypes-dir    (concat ben-scp-source-base-dir "prototypes/")
 ben-scp-source-delivery-dir      (concat ben-scp-source-base-dir "delivery/")
 ben-scp-source-delivery-css-dir  (concat ben-scp-source-delivery-dir "css/")
 ben-scp-source-delivery-js-dir   (concat ben-scp-source-delivery-dir "js/")
 ben-scp-target-base-dir          "devlorealreview@stormshadow.dmz.ny.rga.com:platform_qa/"
 ben-scp-target-css-dir           (concat ben-scp-target-base-dir "css/")
 ben-scp-target-js-dir            (concat ben-scp-target-base-dir "js/"))

(defun parent-dir-path (f)
  "return path of parent dir of f, with a trailing '/'. f may be a file or a directory"
  (file-name-directory (directory-file-name f)))

(defun parent-dir-name (f)
  "return name of parent dir of f (no trailing '/')."
  (file-name-nondirectory (directory-file-name (parent-dir-path f))))

(defun file-base-name (f)
  "return the base name of f, exluding path and extension"
  (file-name-nondirectory (file-name-sans-extension (buffer-file-name))))

(defun do-scp (source target)
  "scp source file to the target"
  (shell-command (concat "scp " source " " target)))

(defun ben-scp ()
  "sends current buffer to remote server, based on file type"
  (interactive)
  (let ((b (buffer-file-name)))
    (cond
          ((and (equal (parent-dir-name b) "less")
                (equal (parent-dir-path (parent-dir-path (parent-dir-path b))) ben-scp-source-prototypes-dir))
           (let* ((derived-css-dir               (concat (parent-dir-path (parent-dir-path b)) "css/"))
                  (derived-css-file              (concat (file-base-name b) ".css"))
                  (derived-css-file-full-path    (concat derived-css-dir derived-css-file)))
             (message
              (concat "less file. calling scp: '" derived-css-file-full-path "' to '" ben-scp-target-css-dir "'" ))
             (do-scp derived-css-file-full-path ben-scp-target-css-dir)))

          ((and (equal (parent-dir-name b) "js")
                (equal (parent-dir-path (parent-dir-path (parent-dir-path b))) ben-scp-source-prototypes-dir))
           (message
            (concat "js file. calling scp: '" b "' to '" ben-scp-target-js-dir "'" ))
           (do-scp b ben-scp-target-js-dir))

          ((and (equal (parent-dir-path (parent-dir-path b)) ben-scp-source-prototypes-dir)
                (equal (file-name-extension b) "php"))
           (let* ((derived-html-file             (concat (file-base-name b) ".html"))
                  (derived-html-file-full-path   (concat ben-scp-source-delivery-dir derived-html-file)))
             (message
              (concat "php file. calling scp: '" derived-html-file-full-path "' to '" ben-scp-target-base-dir "'" ))
             (do-scp derived-html-file-full-path ben-scp-target-base-dir)
             )
           )

          ((and (equal (parent-dir-name b) "less")
                (equal (parent-dir-path (parent-dir-path b)) ben-scp-source-base-dir))
           (let* ((derived-css-dir               (concat (parent-dir-path (parent-dir-path b)) "css/"))
                  (derived-css-file              (concat (file-base-name b) ".css"))
                  (derived-css-file-full-path    (concat derived-css-dir derived-css-file)))
             (message
              (concat "global less file. calling scp: '" derived-css-file-full-path "' to '" ben-scp-target-css-dir "'" ))
             (do-scp derived-css-file-full-path ben-scp-target-css-dir)))

          (t (message (concat "ben-scp error: type of file '" b "' not recognised"))))))

(provide 'ben-scp)

