;; 01 Name and email
(setq user-full-name "Lenin G. Falconí"
      user-mail-address "lenin.falconi@epn.edu.ec")

;; Initialize Package Archives if not already done
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)


;; Install required packages if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Load use-package for package management
(eval-when-compile
  (require 'use-package))

;; Install and configure org mode
(use-package org
  :ensure t
  :config
  (setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-src-preserve-indentation t
        org-edit-src-content-indentation 0))

;; proper identation in all modes
(electric-indent-mode 1)
;; Install and configure ob-ipython for Python execution
(use-package ob-ipython
  :ensure t
  :after org)

;; Add your conda environment to Emacs's exec-path ;; This seems to look for native instaltion for instance in wsl looks for windows conda
;(setq exec-path (append (split-string (shell-command-to-string "conda info --base") "\n")
;                        (list "envs/tfwin/bin")))

;; Set the correct path to the Python executable within your conda environment
(setq org-babel-python-command "/home/leningfe/miniforge3/envs/tfmlenv/bin/python")

;; Set up Python environment and Java for org-mode 
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (java . t)
   (shell .t)))


;; Customize the python shell executable path
(setq python-shell-interpreter "/home/leningfe/miniforge3/envs/tfmlenv/bin/ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;; Install and configure elpy for Python development
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; Install and configure company for code completion
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'LaTeX-mode-hook #'company-mode)
  :config
  (global-set-key (kbd "<C-return>") 'company-complete)
  (global-auto-complete-mode 1))

;; Get auto completion of :emoji: names.
(use-package company-emoji
  :ensure t
  :after company-mode
  :config
  (company-emoji-init))

;; Save configuration
(savehist-mode 1)

;; Set custom key bindings if needed
;; (global-set-key (kbd "C-c r") 'org-babel-execute-buffer)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(deeper-blue))
 '(ispell-dictionary "american")
 '(package-selected-packages
   '(babel helm-lsp helm projectile lsp-javacomp company-auctex git-gutter+ flycheck which-key lsp-ui lsp-java lsp-mode magit company-emoji auto-complete-auctex ac-math auto-complete yasnippet-snippets markdown-mode ein gnu-elpa-keyring-update auctex elpy ob-ipython use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; --------------- Setting up emacs for LaTeX ---------------
;; (use-package tex			
;;   :ensure auctex
;;   :config(add-hook 'LaTeX-mode-hook #'turn-on-auto-reftex))

;; load auctex
(load "auctex.el" nil t t)
(require 'tex-mik)


;; Setting Yasnippet for Emacs
(use-package yasnippet
  :ensure t
  :config (use-package yasnippet-snippets
	    :ensure t))
(yas-reload-all)
(yas-global-mode t) 			;activate yasnippet
(define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand)
;; https://jdhao.github.io/2021/10/06/yasnippet_setup_emacs/

;; Configure Auto Complete
(use-package auto-complete
  :ensure t
  :defer t)
(require 'auto-complete)
(add-to-list 'ac-modes 'latex-mode) ; Add LaTeX mode to Auto-Complete modes
(use-package ac-math
  :ensure t
  :defer t)
(require 'ac-math) ; Install ac-math package first

;; Set up LaTeX-specific Auto-Complete sources
(defun my-ac-latex-mode ()
  (setq ac-sources
        (append '(ac-source-math-unicode
                  ac-source-math-latex
                  ac-source-latex-commands)
                ac-sources)))

;; Hook into LaTeX mode
(add-hook 'LaTeX-mode-hook 'my-ac-latex-mode)

;; Enable Unicode math input
(setq ac-math-unicode-in-math-p t)

;; Workaround for flyspell delay (if you use flyspell)
(ac-flyspell-workaround)

;; Add Auto-Complete for org-mode (optional)
(add-to-list 'ac-modes 'org-mode)

;; Load Auto-Complete configuration
(require 'auto-complete-config)
(ac-config-default)

;; --------------- Setting up emacs for LaTeX ---------------

;; Setting up company
(require 'company)
;; Enable Company mode globally
(add-hook 'after-init-hook 'global-company-mode)

;; jupyter notebooks
(use-package ein
  :ensure t
  :defer t)
(setq ein:use-auto-complete t) ; Enable auto-completion
;; could be handy 2 check https://www.sharons.org.uk/emacs-init-from-an-org-mode-file.html
;; enabling line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; java configuration https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-java.html


;; Following are taken from https://gitlab.com/skybert/my-little-friends/-/blob/master/emacs/.emacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 40 Version control
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing VC log messages
(add-hook 'log-edit-hook (lambda () (flyspell-mode 1)))

(use-package magit
  :ensure t
  :config
  (setq magit-log-arguments '("-n256" "--graph" "--decorate" "--color")
        ;; Show diffs per word, looks nicer!
        magit-diff-refine-hunk t))
(use-package git-gutter+
  :ensure t
  :config
  (setq git-gutter+-disabled-modes '(org-mode))
  ;; Move between local changes
  (global-set-key (kbd "M-<up>") 'git-gutter+-previous-hunk)
  (global-set-key (kbd "M-<down>") 'git-gutter+-next-hunk))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 71 fly check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package flycheck :ensure t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 80 Java
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)
(condition-case nil
    (require 'use-package)
  (file-error
   (require 'package)
   (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
   (package-initialize)
   (package-refresh-contents)
   (package-install 'use-package)
   (setq use-package-always-ensure t)
   (require 'use-package)))

(use-package projectile)
(use-package flycheck)
(use-package yasnippet :config (yas-global-mode))
(use-package lsp-mode :hook ((lsp-mode . lsp-enable-which-key-integration)))
(use-package hydra)
(use-package company)
(use-package lsp-ui)
(use-package which-key :config (which-key-mode))
(use-package lsp-java :config (add-hook 'java-mode-hook 'lsp))
(use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
(use-package dap-java :ensure nil)
(use-package helm-lsp)
(use-package helm
  :config (helm-mode))
(use-package lsp-treemacs)

(require 'lsp-java-boot)

;; to enable the lenses
(add-hook 'lsp-mode-hook #'lsp-lens-mode)
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)


