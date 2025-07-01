;;; initel.el --- Emacs Configuration

;;; Commentary:
;; This configuration is tailored for Org-mode, Python, Jupyter, Java, and LaTeX development.
;; It includes packages for enhanced functionality such as autocompletion, version control,
;; and spell checking.

;;; AuthSource for Apis
(require 'auth-source)
(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo"))

;;; Code:

;;; 1.  Initialization and Basic Setup

;; 1.1 User Information
(setq user-full-name "Lenin G. Falconí"
      user-mail-address "lenin.falconi@epn.edu.ec") ; [cite: 1]

;; 1.2 Package Management
(require 'package)

;; 1.3 Package Archives
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t) ; [cite: 2]
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t) ; [cite: 2]

;; 1.4 Initialize Packages
(package-initialize) ; [cite: 3]

;; 1.5 Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)) ; [cite: 4]

;; 1.6 Load use-package
(eval-when-compile
  (require 'use-package)) ; [cite: 5]

;; 1.7 Save History
(savehist-mode 1) ; [cite: 18]

;;; 2. Core Functionality and UI

;; 2.1 Indentation
(electric-indent-mode 1) ; [cite: 6]

;; 2.2 Line Numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode) ; [cite: 31]

;;; 3. Text and Document Editing

;; 3.1 Auto-fill Mode
(add-hook 'org-mode-hook #'auto-fill-mode) ; [cite: 6]

;; 3.2 Spell Checking
(use-package flyspell
  :ensure t
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))) ; For spell-checking in comments and strings [cite: 34, 35]

;;; 4. Org Mode Configuration

;; 4.1 Org Mode Basics
(use-package org
  :ensure t
  :config
  (setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-src-preserve-indentation t
        org-edit-src-content-indentation 0)) ; [cite: 5]

;; 4.2 Babel Languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (java . t)
   (shell .t))) ; [cite: 10]

;; 4.3 ob-ipython
(use-package ob-ipython
  :ensure t
  :after org) ; [cite: 7]

;; 4.4 Python Configuration for Org-Babel
(setq org-babel-python-command "/home/leningfe/miniforge3/envs/tfmlenv/bin/python") ; [cite: 9]

;; 4.5 LaTeX in Org Mode
(require 'ox-latex)
(add-to-list 'org-latex-classes
	     '("IEEEtran"
                 "\\documentclass[10pt]{IEEEtran}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))) ; [cite: 45, 46]

(setq org-format-latex-options
      (plist-put org-format-latex-options :scale 2.0)) ;; increase preview font [cite: 47]

;;; 5. Python Development

;; 5.1 Elpy
(use-package elpy
  :ensure t
  :init
  (elpy-enable)) ; [cite: 12]

;; 5.2 Yasnippet with Elpy
(add-hook 'elpy-mode-hook 'yas-minor-mode) ; [cite: 13]

;; 5.3 Python Shell
(setq python-shell-interpreter "/home/leningfe/miniforge3/envs/tfmlenv/bin/ipython"
      python-shell-interpreter-args "-i --simple-prompt") ; [cite: 11]

;;; 6. Code Completion

;; 6.1 Company Mode
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'LaTeX-mode-hook #'company-mode)
  :config
  (global-set-key (kbd "C-c s") 'company-complete-selection)) ;C-c C-SPC [cite: 15, 30]

;; 5.4 Company with Elpy
(with-eval-after-load 'elpy
  (define-key elpy-mode-map (kbd "M-TAB") nil) ; disable M-TAB in ELPY [cite: 16, 17]
  (define-key elpy-mode-map (kbd "C-c SPC") 'company-complete))

;; 6.2 Company Emoji
(use-package company-emoji
  :ensure t
  :after company-mode
  :config
  (company-emoji-init)) ; [cite: 17]

;;; 7. Yasnippet

;; 7.1 Yasnippet Setup
(use-package yasnippet
  :ensure t
  :config (use-package yasnippet-snippets
	    :ensure t)) ; [cite: 22]
(yas-reload-all)
(yas-global-mode t) 			;activate yasnippet [cite: 22]
(define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand)
;; ref: https://jdhao.github.io/2021/10/06/yasnippet_setup_emacs/ [cite: 23]

;;; 8. Jupyter (EIN)

;; 8.1 EIN Setup
(use-package ein
  :ensure t
  :defer t
  :init
  (setq ein:use-auto-complete t)
  :config
  (require 'ein-notebook)) ; [cite: 30, 49, 50]
;; ref: https://millejoh.github.io/emacs-ipython-notebook/ [cite: 49]
;; ref: https://github.com/tkf/emacs-ipython-notebook [cite: 50]

;;; 9. LaTeX Configuration

;; 9.1 AUCTeX Setup
(unless (package-installed-p 'auctex)
  (package-refresh-contents)
  (package-install 'auctex)) ; [cite: 37]

;; 9.2 RefTeX Setup
(unless (package-installed-p 'reftex)
  (package-refresh-contents)
  (package-install 'reftex)) ; [cite: 38]

;; 9.3 AUCTeX Configuration
(require 'tex-site) ; [cite: 39]
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil) ;; Use nil for multi-file projects [cite: 39]

;; 9.4  AUCTeX and RefTeX Integration
(with-eval-after-load 'tex
  ;; Enable RefTeX in AUCTeX
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  ;; Enable auto-fill-mode and flyspell-mode in LaTeX mode
  (add-hook 'LaTeX-mode-hook #'auto-fill-mode)
  (add-hook 'LaTeX-mode-hook #'flyspell-mode)
  (setq reftex-plug-into-AUCTeX t)
  ;; Configure RefTeX to automatically detect bibliography files from the document
  (setq reftex-bibliography-commands '("bibliography" "addbibresource" "nobibliography"))
  ;; Configure citation format for biblatex
  ;; (setq reftex-cite-format '((?a . "\\autocite[]{%l}")
  ;;                            (?b . "\\blockcite[]{%l}")
  ;;                            (?c . "\\cite[]{%l}")
  ;;                            (?f . "\\footcite[]{%l}")
  ;;                            (?n . "\\nocite{%l}")
  ;;                            (?p . "\\parencite[]{%l}")
  ;;                            (?s . "\\smartcite[]{%l}")
  ;;                            (?t . "\\textcite[]{%l}")))
  ) ; [cite: 40, 41, 42, 43, 44]
;; Ensure .tex files automatically open in LaTeX-mode.
;; (add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))

;;; 10. Java Development

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
;; (use-package lsp-java-boot :ensure t)

;; 10.3 Lenses
(add-hook 'lsp-mode-hook #'lsp-lens-mode)
;; (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)

;;; 11. Version Control

;; 11.1 VC Log Messages
(add-hook 'log-edit-hook (lambda () (flyspell-mode 1))) ; [cite: 32]

;; 11.2 Magit
(use-package magit
  :ensure t
  :config
  (setq magit-log-arguments '("-n256" "--graph" "--decorate" "--color")
        ;; Show diffs per word, looks nicer!
        magit-diff-refine-hunk t)) ; [cite: 32]

;; 11.3  git-gutter+ (disabled)
;; (use-package git-gutter+
;;   :ensure t
;;   :config
;;   (setq git-gutter+-disabled-modes '(org-mode))
;;   ;; Move between local changes
;;   (global-set-key (kbd "M-<up>") 'git-gutter+-previous-hunk)
;;   (global-set-key (kbd "M-<down>") 'git-gutter+-next-hunk)) ; [cite: 33]

;;; 12. Helm Configuration

(use-package helm
  :ensure t
  :init) ; [cite: 44]
(use-package helm-flyspell
  :ensure t
  :after (helm flyspell)) ; Ensure Helm and Flyspell are loaded first
;; (use-package helm-bibtex
;;   :ensure t
;;   :init) ; [cite: 45]

;; 12.1 Helm Doc View
(setq doc-view-continuous t) ; [cite: 36]

;;; 13. Auto-update Packages

(use-package auto-package-update
  :ensure t
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00")) ; [cite: 48]

;;; 14. Enabling LLMs GPTel https://github.com/karthink/gptel
(use-package gptel
  :ensure t
  :config
  ;; Uncomment the next line to use markdown-mode as default when
  ;; chatting, otherwise org-mode is used
  ;; (setq gptel-default-mode 'org-mode)
  (setq gptel-model 'gpt-4.1
	gptel-backend (gptel-make-gh-copilot "Copilot"))
  (gptel-make-deepseek "DeepSeek" :stream t :key gptel-api-key)
  (gptel-make-gh-copilot "Copilot")
)

;; (gptel-make-anthropic "Claude" :stream t :key "your-api-key")
;; (gptel-make-deepseek "DeepSeek" :stream t :key gptel-api-key)
;; (gptel-make-gh-copilot "Copilot")


;;; 15. wskview
;;; requires sudo apt install wslu
(setq browse-url-generic-program "wslview")
(setq browse-url-browser-function 'browse-url-generic)
;;; 16. Customizations

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
   '(gptel helm-flyspell auto-complete-auctex company-auctex auctex-lua auto-package-update helm-bibtex company-reftex htmlize csv-mode csv simple-httpd calc-at-point org elpygen babel helm-lsp helm projectile lsp-javacomp flycheck which-key lsp-ui lsp-java lsp-mode magit company-emoji ac-math auto-complete yasnippet-snippets markdown-mode ein gnu-elpa-keyring-update elpy ob-ipython use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 ; [cite: 19, 20, 21]

;; 16. mac keyboard
;; (setq mac-command-modifier 'meta)
;; (setq mac-option-modifier 'none)
;;;###autoload
;;;###e
