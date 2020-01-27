;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Enable cursor change in evil mode when using terminal emacs
;; (unless (display-graphic-p)
        ;; (evil-terminal-cursor-changer-activate) ; or (etcc-on)
        ;; )
;; Place your private configuration here
(setq-default evil-escape-key-sequence "fd")
(setq doom-localleader-key ",")

;; Command to run eslint --fix
(defun eslint-fix-file ()
  (interactive)
  (message "eslint_d --fix " (buffer-file-name)))

(defun eslint-fix-file-and-revert ()
  (interactive)
  (eslint-fix-file)
  (revert-buffer t t))

(map!
 "C-=" #'eslintd-fix
 "S-<tab>" #'org-do-promote)


;; Typescript
(setq tide-format-options '(:indentSize 2))

;; Org
(setq org-agenda-files (list '("~/Dropbox/org")))

;; Org Journal
(customize-set-variable 'org-journal-dir "~/Dropbox/org/journal/")
(customize-set-variable 'org-journal-date-format "%A, %d, %B %Y")
(customize-set-variable 'org-journal-file-type 'weekly)

;; When =org-journal-file-pattern= has the default value, this would be the regex.
(setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
(add-to-list 'org-agenda-files org-journal-dir)

;; Deft
(use-package! zetteldeft :after deft)
(setq deft-recursive t)
(setq deft-use-filter-string-for-filename t)
(setq deft-default-extension "org")
(setq deft-directory "~/Dropbox/org/endo")

(setq zettel-indicator "§")
(defun jethro/deft-insert-boilerplate ()
  (interactive)
  (when (= (buffer-size (current-buffer)) 0)
    (let ((title (s-join " " (-map #'capitalize (split-string (file-name-sans-extension (buffer-name)) "_")))))
      (insert "#+TITLE: ")
      (insert title)
      (goto-char (point-max)))))

(defun org-insert-zettel (file-name)
  "Finds a file, inserts it as a link with the base file name as the link name, and adds the zd-link-indicator I use to the front."
  (interactive (list (completing-read "File: " (deft-find-all-files-no-prefix))))
  (org-insert-link nil (concat "file:" (file-name-base file-name) "." (file-name-extension file-name)) (concat zettel-indicator (file-name-base file-name))))

(defun jethro/get-linked-files ()
  "Show links to this file."
  (interactive)
  (let* ((search-term (file-name-nondirectory buffer-file-name)
          (files deft-all-files)
          (tnames (mapcar #'file-truename files))))
    (multi-occur
      (mapcar (lambda (x)
                (with-current-buffer
                    (or (get-file-buffer x) (find-file-noselect x))
                  (widen)
                  (current-buffer)))
              files)
      search-term
      3)))
