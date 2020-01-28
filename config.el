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
(setq deft-directory "~/Dropbox/org")

(map! :leader
      (:when (featurep! :lang org)
        :prefix ("z" . "zetteldeft")
        :desc "Follow link" "f" #'zetteldeft-follow-link
        :desc "Search current id" "F" #'zetteldeft-search-current-id
        :desc "Find and insert id" "i" #'zetteldeft-find-file
        :desc "Create new file and insert id" "I" #'zetteldeft-new-file-and-link
        :desc "Create new file" "n" #'zetteldeft-new-file
        :desc "Tag search with avy jump" "t" #'zetteldeft-avy-tag-search
        :desc "Show tag buffer" "T" #'zetteldeft-tag-buffer))
