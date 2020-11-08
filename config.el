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
(setq org-roam-directory "~/Dropbox/org/roam")

(setq org-agenda-files '("~/Dropbox/org/" "~/Dropbox/org/roam" "~/Dropbox/org/alerts"))

;; Org Journal
(customize-set-variable 'org-journal-dir "~/Dropbox/org/journal/")
(customize-set-variable 'org-journal-date-format "%A, %d, %B %Y")
(customize-set-variable 'org-journal-file-type 'weekly)

;; When =org-journal-file-pattern= has the default value, this would be the regex.
;; (setq org-agenda-file-regexp "\\`\\\([^.].*\\.org\\\|[0-9]\\\{8\\\}\\\(\\.gpg\\\)?\\\)\\'")
;; (add-to-list 'org-agenda-files org-journal-dir)

;; Super Agenda
(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-agenda-time-grid '((daily today require-timed) "----------------------" nil)
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-include-diary t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-start-with-log-mode t))

(setq org-agenda-custom-commands
      '(("z" "Super zaen view"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                                :time-grid t
                                :date today
                                :todo "TODAY"
                                :scheduled today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next to do"
                                 :todo "NEXT"
                                 :order 1)
                          (:name "Inbox"
                                 :todo "ALERT"
                                 :order 3)
                          (:name "Important"
                                 :tag "Important"
                                 :priority "A"
                                 :order 6)
                          (:name "Due Today"
                                 :deadline today
                                 :order 2)
                          (:name "Due Soon"
                                 :deadline future
                                 :order 8)
                          (:name "Overdue"
                                 :deadline past
                                 :order 7)
                          (:name "Issues"
                                 :tag "Issue"
                                 :order 12)
                          (:name "Projects"
                                 :tag "Project"
                                 :order 14)
                          (:name "Research"
                                 :tag "Research"
                                 :order 15)
                          (:name "To read"
                                 :tag "Read"
                                 :order 30)
                          (:name "Waiting"
                                 :todo "WAITING"
                                 :order 20)
                          (:name "trivial"
                                 :priority<= "C"
                                 :tag ("Trivial" "Unimportant")
                                 :todo ("SOMEDAY")
                                 :order 90)
                          (:discard (:tag ("Chore" "Routine" "Daily")))))))))))
:config (org-super-agenda-mode)

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


;; Org Journal
(customize-set-variable 'org-journal-dir "~/Dropbox/org/journal/")
(customize-set-variable 'org-journal-date-format "%A, %d, %B %Y")
(customize-set-variable 'org-journal-file-type 'weekly)


;; Deft
(use-package! zetteldeft :after deft)
(setq deft-recursive t)
(setq deft-use-filter-string-for-filename t)
(setq deft-default-extension "org")
(setq deft-directory "~/Dropbox/org/roam")

(setq org-roam-directory "~/Dropbox/org/roam")
(setq org-roam-tag-sources '(prop last-directory))
(setq org-roam-capture-templates
      '(
        ("d" "default" plain (function org-roam--capture-get-point)
          "%?"
          :file-name "cz/%<%y%m%d%h%m%s>-${slug}"
          :head "#+TITLE: ${title}\n#+ROAM_TAGS: \n"
          :unnarrowed t)
        ("z" "cloudzero" plain (function org-roam--capture-get-point)
          "%?"
          :file-name "cz/%<%y%m%d%h%m%s>-${slug}"
          :head "#+TITLE: ${title}\n#+ROAM_TAGS: \n"
          :unnarrowed t)
        ("a" "aospam" plain (function org-roam--capture-get-point)
          "%?"
          :file-name "rpg/aospam/%<%y%m%d%h%m%s>-${slug}"
          :head "#+TITLE: ${title}\n#+ROAM_TAGS: \n"
          :unnarrowed t)))

(after! org (setq org-todo-keywords
                  '((sequence "INBOX(i)" "TODO(t)" "NEXT(n!)" "SOMEDAY(s!)" "HOLDING(h!)" "DELEGATED(e!)" "|" "DONE(d!)" "WONTDO(w!)"))))

(setq org-agenda-files '("~/Dropbox/org/" "~/Dropbox/org/roam" "~/Dropbox/org/alerts"))


(defun my-deft/strip-quotes (str)
  (cond ((string-match "\"\\(.+\\)\"" str) (match-string 1 str))
        ((string-match "'\\(.+\\)'" str) (match-string 1 str))
        (t str)))

(defun my-deft/parse-title-from-front-matter-data (str)
  (if (string-match "^title: \\(.+\\)" str)
      (let* ((title-text (my-deft/strip-quotes (match-string 1 str)))
             (is-draft (string-match "^draft: true" str)))
        (concat (if is-draft "[DRAFT] " "") title-text))))

(defun my-deft/deft-file-relative-directory (filename)
  (file-name-directory (file-relative-name filename deft-directory)))

(defun my-deft/title-prefix-from-file-name (filename)
  (let ((reldir (my-deft/deft-file-relative-directory filename)))
    (if reldir
        (concat (directory-file-name reldir) " > "))))

(defun my-deft/parse-title-with-directory-prepended (orig &rest args)
  (let ((str (nth 1 args))
        (filename (car args)))
    (concat
      (my-deft/title-prefix-from-file-name filename)
      (let ((nondir (file-name-nondirectory filename)))
        (if (or (string-prefix-p "README" nondir)
                (string-suffix-p ".txt" filename))
            nondir
          (if (string-prefix-p "---\n" str)
              (my-deft/parse-title-from-front-matter-data
               (car (split-string (substring str 4) "\n---\n")))
            (apply orig args)))))))
(advice-add 'deft-parse-title :around #'my-deft/parse-title-with-directory-prepended)


(setq zettel-indicator "§")
(defun jethro/deft-insert-boilerplate ()
  (interactive)
  (when (= (buffer-size (current-buffer)) 0)
    (let ((title (s-join " " (-map #'capitalize (split-string (file-name-sans-extension (buffer-name)) "_")))))
      (insert "#+TITLE: ")
      (insert title)
      (goto-char (point-max)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-journal-date-format "%A, %d, %B %Y")
 '(org-journal-dir "~/Dropbox/org/journal/")
 '(org-journal-file-type 'weekly)
 '(safe-local-variable-values
   '((cider-ns-refresh-after-fn . "integrant.repl/resume")
     (cider-ns-refresh-before-fn . "integrant.repl/suspend"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
