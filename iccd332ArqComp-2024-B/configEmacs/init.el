;;; initel.el --- Emacs Configuration

;;; Commentary:
;; This configuration is tailored for Org-mode, Python, Jupyter, Java, and LaTeX development.
;; It includes packages for enhanced functionality such as autocompletion, version control,
;; and spell checking.

;;; AuthSource for Apis
(require 'auth-source)
(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo"))

;;; ============================================================
;;; 1. Initialization and Basic Setup
;;; ============================================================

;; 1.1 User Information
(setq user-full-name "Lenin G. Falconí"
      user-mail-address "lenin.falconi@epn.edu.ec")

;; 1.2 Package Management
(require 'package)

;; 1.3 Package Archives
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/") t)

;; 1.3b Allow upgrading built-in packages (required for transient >= 0.13)
(setq package-install-upgrade-built-in t)

;; 1.4 Initialize Packages
(package-initialize)


;; 1.5 Ensure use-package is installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; 1.6 Load use-package
(eval-when-compile
  (require 'use-package))

;; 1.6b Compat — forward-compatibility library (required by transient/magit)
(unless (package-installed-p 'compat)
  (package-install 'compat))
(require 'compat)

;; 1.7 Save History
(savehist-mode 1)

;; 1.8 Enable auto-revert everywhere
(global-auto-revert-mode 1)


;;; ============================================================
;;; 2. Core Functionality and UI
;;; ============================================================

;; 2.1 Indentation
(electric-indent-mode 1)

;; 2.2 Line Numbers in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)


;;; ============================================================
;;; 3. Text and Document Editing
;;; ============================================================

;; 3.1 Auto-fill Mode for Org
(add-hook 'org-mode-hook #'auto-fill-mode)

;; 3.2 Spell Checking
(use-package flyspell
  :ensure t
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))) ; spell-check in comments and strings


;;; ============================================================
;;; 4. Org Mode Configuration
;;; ============================================================

;; 4.1 Org Mode Basics (loads default Org Mode 9.6.15)
;; To update to latest Org (requires Emacs 30):
;;   emacs -Q -batch -eval "(progn (require 'package) (package-initialize) (package-refresh-contents) (package-upgrade 'org))"
;; https://orgmode.org/org.html#Installation
(use-package org
  :ensure t
  :config
  (setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-src-preserve-indentation t
        org-edit-src-content-indentation 0))
;; to add documentation display
;; (add-hook 'org-src-mode-hook #'eldoc-mode)
;; (add-hook 'org-src-mode-hook #'company-quickhelp-mode)

;; 4.2 Babel Languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (java   . t)
   (shell  . t)))

;; 4.3 ob-ipython
(use-package ob-ipython
  :ensure t
  :after org)

;; 4.4 emacs-jupyter
(use-package jupyter
  :ensure t
  :after org
  :config
  ;; Images from Jupyter results are saved in the "images" subfolder by default
  (setq jupyter-org-resource-container "images")
  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages '((jupyter . t))))
  ;; Enable Jupyter autocompletion directly in the Org buffer
  ;; (add-hook 'org-mode-hook #'jupyter-org-interaction-mode)
  )
;; emacs-jupyter seems to require zmq
;; sudo apt-get install -y libzmq3-dev pkg-config autoconf automake libtool
(use-package zmq
  :ensure t)

;; 4.5 Python for Org-Babel
(setq org-babel-python-command "/home/leningfe/miniforge3/envs/tfmlenv/bin/python")

;; 4.7 LaTeX in Org Mode
(require 'ox-latex)
(add-to-list 'org-latex-classes
             '("IEEEtran"
               "\\documentclass[10pt]{IEEEtran}"
               ("\\section{%s}"       . "\\section*{%s}")
               ("\\subsection{%s}"    . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}"     . "\\paragraph*{%s}")
               ("\\subparagraph{%s}"  . "\\subparagraph*{%s}")))

(setq org-format-latex-options
      (plist-put org-format-latex-options :scale 2.0)) ; increase preview size

;; 4.7b Proceso de compilación: pdflatex × 2 → biber → pdflatex × 2
;; (with-eval-after-load 'ox-latex
;;   (setq org-latex-pdf-process
;;         '("pdflatex -interaction nonstopmode -output-directory=%o %f"
;;           "pdflatex -interaction nonstopmode -output-directory=%o %f"
;;           "biber %b"
;;           "pdflatex -interaction nonstopmode -output-directory=%o %f"
;;           "pdflatex -interaction nonstopmode -output-directory=%o %f")))

;; 4.7b Proceso de compilación con latexmk para Org-export
(with-eval-after-load 'ox-latex
  (setq org-latex-pdf-process
        '("latexmk -f -pdf -%latex -interaction=nonstopmode -output-directory=%o %f")))

;; 4.7c Org-cite: biblatex como procesador para exportación LaTeX
(with-eval-after-load 'oc
  (setq org-cite-export-processors
        '((latex biblatex)
          (t basic))))

;; 4.8 Org Present (academic presentations)
(use-package org-present
  :ensure t
  :after org
  :hook ((org-present-mode . (lambda ()
                               (org-present-big)
                               (org-display-inline-images)
                               (org-present-hide-cursor)
                               (org-present-read-only)
                               (org-latex-preview 64)))
         (org-present-mode-quit . (lambda ()
                                    (org-present-small)
                                    (org-remove-inline-images)
                                    (org-present-show-cursor)
                                    (org-present-read-write)
                                    (org-clear-latex-preview)
                                    (setq cursor-type 'box)))))
;; 4.9 ORG + Emacs + Reveal JS
(use-package ox-reveal
  :ensure t
  :after org)


;;; ============================================================
;;; 5. Python Development — 
;;; ============================================================
;; ---------------------------------------------------------------------
;; 5.1 Elpy — full Python IDE in Emacs
;; ---------------------------------------------------------------------

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  ;; Point to your conda environment
  (setq elpy-rpc-python-command "/home/leningfe/miniforge3/envs/tfmlenv/bin/python")
  (setq python-shell-interpreter "/home/leningfe/miniforge3/envs/tfmlenv/bin/ipython"
        python-shell-interpreter-args "-i --simple-prompt")
  (setq elpy-eldoc-show-current-function t)
  (setq elpy-rpc-timeout 2)   ; uncomment if completions are slow
  (setq elpy-eldoc-show-current-function t)

  ;; Ensure company-elpy is the main backend in Python buffers
  (add-hook 'python-mode-hook
            (lambda ()
              (setq-local company-backends
			  '(elpy-company-backend
			    company-dabbrev-code
			    company-files))))

  ;; Keep your other Elpy settings (e.g., key bindings)...
  (define-key elpy-mode-map (kbd "C-<return>") 'company-complete)
  (define-key elpy-mode-map (kbd "M-TAB")      nil))

;; Elpy hooks: enable yasnippet and flycheck in Python buffers
(add-hook 'elpy-mode-hook #'yas-minor-mode)
(add-hook 'elpy-mode-hook #'flycheck-mode)
(add-hook 'python-mode-hook 'eldoc-mode)

;; ---------------------------------------------------------------------
;; 5.2 Virtual environment management (for pyvenv-working)
;; ---------------------------------------------------------------------
;; check elpy state with M-x elpy-config follow recommendations 
(setenv "WORKON_HOME" "/home/leningfe/miniforge3/envs/")

;; 5.6 Python shell (IPython)
(setq python-shell-interpreter "/home/leningfe/miniforge3/envs/tfmlenv/bin/ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;; 5.7 Flycheck — real-time linting (pyright errors appear here too)
(use-package flycheck
  :ensure t
  :hook (python-mode . flycheck-mode))
;;; ============================================================
;;; 6. Code Completion — Company
;;; ============================================================

;; 6.1 Company Mode
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'LaTeX-mode-hook #'company-mode)
  :config
  ;; Use company-capf as the main backend (for LSP, Elisp, etc.)
  ;; (setq company-backends '(company-capf company-emoji company-dabbrev-code company-jupyter))
  (setq company-idle-delay 0.5)
  (setq company-minimum-prefix-length 2)
  ;; (global-set-key (kbd "C-c s") 'company-complete-selection)
  )


;; 6.2 Company Help
;; (use-package company-quickhelp
;;   :ensure t
;;   :after company
;;   :config
;;   (company-quickhelp-mode 1))


;; 6.3 Company Emoji
;; (use-package company-emoji
;;   :ensure t
;;   :after company
;;   :config (company-emoji-init))


;;; ============================================================
;;; 7. Yasnippet
;;; ============================================================

;; 7.1 Yasnippet setup
(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets :ensure t)
  (yas-reload-all)
  (yas-global-mode t)
  (define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand))

;; ref: https://jdhao.github.io/2021/10/06/yasnippet_setup_emacs/


;;; ============================================================
;;; 8. Jupyter — EIN
;;; ============================================================

(use-package ein
  :ensure t
  :defer t
  :init
  (setq ein:jupyter-server-use-subcommand "server"))
;; ref: https://millejoh.github.io/emacs-ipython-notebook/
;; ref: https://github.com/tkf/emacs-ipython-notebook


;;; ============================================================
;;; 9. LaTeX Configuration
;;; ============================================================

;; 9.1 AUCTeX
(unless (package-installed-p 'auctex)
  (package-refresh-contents)
  (package-install 'auctex))

;; 9.2 RefTeX
(unless (package-installed-p 'reftex)
  (package-refresh-contents)
  (package-install 'reftex))

;; 9.3 AUCTeX configuration
(require 'tex-site)
(setq TeX-auto-save  t)
(setq TeX-parse-self t)
(setq-default TeX-master nil) ; nil = multi-file projects

;; The following enables LaTeXMk
;; Use latexmk as default compilation command
(setq-default TeX-command-default "LatexMk")

;; Enable PDF mode by default (generates PDF instead of DVI)
(setq TeX-PDF-mode t)

;; Add latexmk command to AUCTeX
(with-eval-after-load 'tex
  (add-to-list 'TeX-command-list
               '("LatexMk" "latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode -synctex=1' %s"
                 TeX-run-TeX nil t
                 :help "Run latexmk on file"))
  
  ;; Alternative: latexmk with explicit biber support
  (add-to-list 'TeX-command-list
               '("LatexMkBiber" "latexmk -pdf -pdflatex='pdflatex -interaction=nonstopmode -synctex=1' -bibtex %s"
                 TeX-run-TeX nil t
                 :help "Run latexmk with explicit biber support")))

;; 9.4 AUCTeX + RefTeX integration
(with-eval-after-load 'tex
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'LaTeX-mode-hook #'auto-fill-mode)
  (add-hook 'LaTeX-mode-hook #'flyspell-mode)
  (setq reftex-plug-into-AUCTeX t)
  (setq reftex-bibliography-commands
        '("bibliography" "addbibresource" "nobibliography"))
  ;; Uncomment for biblatex citation styles:
  ;; (setq reftex-cite-format '((?a . "\\autocite[]{%l}")
  ;;                            (?b . "\\blockcite[]{%l}")
  ;;                            (?c . "\\cite[]{%l}")
  ;;                            (?f . "\\footcite[]{%l}")
  ;;                            (?n . "\\nocite{%l}")
  ;;                            (?p . "\\parencite[]{%l}")
  ;;                            (?s . "\\smartcite[]{%l}")
  ;;                            (?t . "\\textcite[]{%l}")))
  )


;;; ============================================================
;;; 10. Java Development — LSP (jdtls via lsp-java)
;;; ============================================================

;; lsp-mode is already loaded in section 5; these packages extend it for Java.

(use-package projectile  :ensure t)
(use-package hydra       :ensure t)
(use-package helm-lsp    :ensure t)
(use-package lsp-treemacs :ensure t)

(use-package lsp-java
  :ensure t
  :after lsp-mode
  :config (add-hook 'java-mode-hook #'lsp))

(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config (dap-auto-configure-mode))

(use-package dap-java :ensure nil) ; bundled with lsp-java

;; 10.1 lsp-java-boot lenses (Spring Boot hints)
(require 'lsp-java-boot)
(add-hook 'lsp-mode-hook  #'lsp-lens-mode)
;; (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode) ; uncomment for Spring Boot


;;; ============================================================
;;; 11. Version Control
;;; ============================================================

;; 11.1 Spell checking in commit messages
(add-hook 'log-edit-hook (lambda () (flyspell-mode 1)))

;; 11.2 Magit
(use-package magit
  :ensure t
  :config
  (setq magit-log-arguments '("-n256" "--graph" "--decorate" "--color")
        magit-diff-refine-hunk t)) ; word-level diff highlighting

;; 11.3 git-gutter+ (disabled — uncomment to enable)
;; (use-package git-gutter+
;;   :ensure t
;;   :config
;;   (setq git-gutter+-disabled-modes '(org-mode))
;;   (global-set-key (kbd "M-<up>")   'git-gutter+-previous-hunk)
;;   (global-set-key (kbd "M-<down>") 'git-gutter+-next-hunk))


;;; ============================================================
;;; 12. Helm Configuration
;;; ============================================================
;;; added which key to have support when trying to find commands for latex
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package helm
  :ensure t
  :config (helm-mode))

(use-package helm-flyspell
  :ensure t
  :after (helm flyspell))

;; (use-package helm-bibtex :ensure t)

;; 12.1 Continuous scroll in doc-view
(setq doc-view-continuous t)


;;; ============================================================
;;; 13. Auto-update Packages
;;; ============================================================

(use-package auto-package-update
  :ensure t
  :custom
  (auto-package-update-interval         30)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results     t)
  (auto-package-update-delete-old-versions t) ; to remove obsolete
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))


;;; ============================================================
;;; 14. GPTel — LLM integration
;;; https://github.com/karthink/gptel
;;; ============================================================

;;  Set up Copilot as Primary LLM and DeepSeek as secondary
;; (use-package gptel
;;   :ensure t
;;   :config
;;   ;; (setq gptel-default-mode 'org-mode) ; comment for Markdown-free chat
;;   (setq gptel-log-level 'debug)
;;   (setq gptel-model   'gpt-4.1
;;         gptel-backend (gptel-make-gh-copilot "Copilot"))
;;   (gptel-make-deepseek "DeepSeek" :stream t :key gptel-api-key)
;;   (gptel-make-gh-copilot "Copilot")
;;   ;; Uncomment to add Claude or other backends:
;;   ;; (gptel-make-anthropic "Claude" :stream t :key "your-api-key")
;;   )

;; Set up DeepSeek as Primary LLM and Copilot as Secondary

(use-package gptel
  :ensure t
  :config
  ;; (setq gptel-default-mode 'org-mode) ; comment for Markdown-free chat
  (setq gptel-log-level 'debug)
  (setq gptel-model 'deepseek-chat
	gptel-backend (gptel-make-deepseek "Deepseek"
			:stream t
			:key gptel-api-key))
  (gptel-make-gh-copilot "Copilot")
  ;; Uncomment to add Claude or other backends:
  ;; (gptel-make-anthropic "Claude" :stream t :key "your-api-key")
)

;;; ============================================================
;;; 15. WSL Browser
;;; Requires: sudo apt install wslu
;;; ============================================================

(setq browse-url-generic-program  "wslview")
(setq browse-url-browser-function 'browse-url-generic)


;;; ============================================================
;;; 16. Doom Emacs Themes
;;; ============================================================
;;Disable ansi color names vector and custom-enabled-themes

(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-homage-black") ; use "doom-colors" for less minimal icon theme ; doom-ir-black ; doom-atom
  :config
  (load-theme 'doom-homage-black t)		;doom-1337

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package nerd-icons
  :ensure t
)
;;; ============================================================
;;; 17. Customizations (managed by Custom — do not edit by hand)
;;; ============================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("6963de2ec3f8313bb95505f96bf0cf2025e7b07cefdb93e3d2e348720d401425" "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd" "be0d9f0e72a4ebc4a59c382168921b082b4dc15844bdaf1353c08157806b3321" "f6ea954a9544b0174a876d195387f444da441535ee88c7fb0fc346af08b0d228" "19d62171e83f2d4d6f7c31fc0a6f437e8cec4543234f0548bad5d49be8e344cd" "3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b" "87fa3605a6501f9b90d337ed4d832213155e3a2e36a512984f83e847102a42f4" default))
 '(ispell-dictionary "american")
 '(package-selected-packages
   '(zmq auctex ein nerd-icons doom-themes ox-reveal company-quickhelp lsp-pyright org-present json-mode markdown-preview-mode yaml-mode gptel helm-flyspell auto-complete-auctex company-auctex auctex-lua auto-package-update helm-bibtex company-reftex htmlize csv-mode csv simple-httpd calc-at-point org elpygen babel helm-lsp helm projectile lsp-javacomp flycheck which-key lsp-ui lsp-java lsp-mode magit company-emoji ac-math auto-complete yasnippet-snippets markdown-mode gnu-elpa-keyring-update elpy ob-ipython use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;###autoload
;;;###e
