;;; build-ctags-git.el --- Builds ctags

;; Copyright (C) 2009, 2012  Free Software Foundation, Inc.

;; Author:  Ben Immanuel <immanuel_ben@yahoo.co.uk>
;; Version:  0.1
;; Keywords:  ctags, git

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;; Notes:

;; This assumes exuberant ctags is installed http://ctags.sourceforge.net/
;; M-x build-ctags-git searches for first .git file in enclosing folders
;; (or uses default directory if no file is open).
;; If it finds a .git file, it assumes this is the project's root directory.
;; It then creates the TAGS file (using exuberant ctags).

;; Enjoy!

;;; Code:

(defun build-ctags-git ()
  (interactive)
  (message "building project tags")
  (let ((project-home-dir (get-project-home-dir)))
    (shell-command (concat "cd " project-home-dir "; find . -print | xargs /usr/local/bin/ctags -a -e --exclude=db --exclude=test --exclude=.git --exclude=public -f TAGS"))
    (visit-project-tags-git)
    (message "tags built successfully at %sTAGS" project-home-dir)))

(defun visit-project-tags-git ()
  (interactive)
  (let ((tags-file (concat (get-project-home-dir) "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))

(defun get-project-home-dir ()
  "Relative to the current file (or default directory if there is no current file),
returns the first enclosing directory that contains a .git file,
or nil if none found"
  (let ((start-dir (get-start-dir)))
    (if (not start-dir)
        (error "Unable to get project home directory.")
      (let ((project-home-dir (get-first-enclosing-dir-with-dot-git-from-dir
                               start-dir)))
        (unless project-home-dir
          (error "No .git file found in any of the parent directories of '%s'"
                 start-dir))
        project-home-dir))))

(defun get-start-dir ()
  (if (buffer-file-name)
      (file-name-directory (buffer-file-name))
    ;; Current buffer not a file.
    ;; So ask the user if they want to use the default
    (if (yes-or-no-p (format "Current buffer is not a file. Search for project starting at default directory ('%s')?" default-directory))
        (file-name-directory default-directory)
      nil)))

(defun get-first-enclosing-dir-with-dot-git-from-dir (dir)
  "Given dir, returns the first enclosing directory that contains a .git file,
or nil if none found"
  (if (file-exists-p (concat dir ".git"))
      dir
    (if (or (string= dir "/") (string= dir "~/"))
        nil
      ;; recurivse call
      (get-first-enclosing-dir-with-dot-git-from-dir
       (file-name-directory (substring dir 0 (- (length dir) 1)))))))

(provide 'build-ctags-git)
