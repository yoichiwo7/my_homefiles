;;----------------------------------------
;; General Settings
;;----------------------------------------
; hide menu-bar and tool-bar
(menu-bar-mode -1)
(tool-bar-mode -1)

; show line number
(global-linum-mode t)
(setq linum-format "%4d  ")

; highlight matched parences
(show-paren-mode 1)
;(setq show-paren-style 'mixed)

; highlight current line
;(global-hl-line-mode)

; no backups, remove autosaves
(setq backup-inhibited t)
(setq delete-auto-save-files t)

; save cursor
(require 'saveplace)
(setq-default save-place t)


;;----------------------------------------
;; Color Settings
;;----------------------------------------
(load-theme 'wombat t)


;;----------------------------------------
;; Japanese Settings
;;----------------------------------------
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)


;;----------------------------------------
;; Package Settings
;;----------------------------------------
(require 'package)

; add package URLS
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

; no auto startup for packages
(setq package-enable-at-startup nil)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it's not.
  Return a list of installed packages or nil for every skipped package."
  (mapcar
    (lambda (package)
      (if (package-installed-p package)
        nil
        (if (y-or-n-p (format "Package %s is missing. Install it? " package))
          (package-install package)
          package)))
    packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;; Check and install packages
(ensure-package-installed 
    'auto-complete
    'helm
    'evil
    'flycheck
    ;'magit
    'neotree
    'org
    'projectile
    'solarized-theme
    'undo-tree
    'yasnippet
    )


;;----------------------------------------
;; Vim Settings (evilmode)
;;----------------------------------------
(require 'evil)
(evil-mode t)


;;----------------------------------------
;; Neotree Settings (evilmode)
;;----------------------------------------
(require 'neotree)
; toggle with F8
(global-set-key [f8] 'neotree-toggle)
