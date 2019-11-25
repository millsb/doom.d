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
