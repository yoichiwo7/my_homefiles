;;----------------------------------------
;; Package Settings
;;----------------------------------------
(require 'package)

; add package URLS
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
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
    'ag
    'auto-complete
    'helm
    'evil
    'flycheck
    ;'magit
    'neotree
    'org
    'projectile
    'powerline
    'solarized-theme
    'undo-tree
    'yasnippet
    )


;;----------------------------------------
;; General Settings
;;----------------------------------------
;; hide menu-bar and tool-bar
;(menu-bar-mode -1)
(tool-bar-mode -1)

;; show line number
(global-linum-mode t)
(setq linum-format "%4d")
(set-face-attribute 'linum nil
                    :foreground "#800"
                    :height 0.9)

;; highlight matched parences
(show-paren-mode 1)
;(setq show-paren-style 'mixed)

;; highlight current line
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;; no backups, remove autosaves
(setq backup-inhibited t)
(setq delete-auto-save-files t)

;; save cursor
(require 'saveplace)
(setq-default save-place t)

;; space, tab
(setq-default tab-width 4 indent-tabs-mode nil)
(setq-default c-basic-offset 4 c-default-style "bsd")
(define-key global-map (kbd "RET") 'newline-and-indent)


;;----------------------------------------
;; Key Settings
;;----------------------------------------
;; Ctrl + up/down
;; -> jump through results of grep, erros, etc..
(global-set-key (kbd "<C-down>") 'next-error)
(global-set-key (kbd "<C-up>") 'previous-error)

;; Ctrl + left/right
;; -> swtich to next/previous buffers
(global-set-key (kbd "<C-right>") 'next-buffer)
(global-set-key (kbd "<C-left>") 'previous-buffer)


;;----------------------------------------
;; Mouse Settings
;;----------------------------------------
;; Enable mouse in terminal
(xterm-mouse-mode t)
(mouse-wheel-mode t)


;;----------------------------------------
;; Color Settings
;;----------------------------------------
(load-theme 'wombat t)


;;----------------------------------------
;; Font Settings
;; ex. "源ノ角ゴシック Code JP R", "Ricty", "MyricaM M"
;;----------------------------------------
(setq myfont-name-win "MyricaM M")
;(setq myfont-name-win "源ノ角ゴシック Code JP R")
(setq myfont-name-mac "Ricty")
(setq myfont-height 100)

(let ((ws window-system))
  (cond ((eq ws 'w32)
	 ; Windows Font 
	 (set-face-attribute 'default nil
			     :family myfont-name-win
			     :height myfont-height))
	 ;(set-fontset-font nil 'japanese-jisx0208 (font-spec :family myfont-name-win)))
	((eq ws 'ns)
	 ; Mac OSX Font
	 (set-face-attribute 'default nil
			     :family myfont-name-mac
			     :height myfont-height))))
	 ;(set-fontset-font nil 'japanese-jisx0208 (font-spec :family myfont-name-mac)))))


;;----------------------------------------
;; Japanese Settings
;;----------------------------------------
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)



;;----------------------------------------
;; Vim Settings (evilmode)
;;----------------------------------------
(require 'evil)
(evil-mode t)

;; Move wrapped lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)


;;----------------------------------------
;; PowerLine Settings 
;;----------------------------------------
(require 'powerline)
(display-time-mode t)


;;----------------------------------------
;; Neotree Settings
;;----------------------------------------
(require 'neotree)
; toggle with F8
(global-set-key [f8] 'neotree-toggle)


;;----------------------------------------
;; Grep Settings
;;----------------------------------------
;; recursive grep
(require 'grep)
(setq grep-command-before-query "grep -nH -r -e ")
(defun grep-default-command ()
  (if current-prefix-arg
      (let ((grep-command-before-target
             (concat grep-command-before-query
                     (shell-quote-argument (grep-tag-default)))))
        (cons (if buffer-file-name
                  (concat grep-command-before-target
                          " *."
                          (file-name-extension buffer-file-name))
                (concat grep-command-before-target " ."))
              (+ (length grep-command-before-target) 1)))
    (car grep-command)))
(setq grep-command (cons (concat grep-command-before-query " .")
                         (+ (length grep-command-before-query) 1)))



;;----------------------------------------
;; Python Settings
;;----------------------------------------
(let ((ws window-system))
  ; Windows setting
  (cond ((eq ws 'w32)
    (setq python-shell-interpreter "ipython"))))
    ;(setq python-shell-interpreter "python2.7"))))
