;;; init.el --- Emacs Configuration
;; Version: 1.3.0

;;; Commentary:
;; This configuration is tailored for Org-mode, Python, Jupyter, Java, and LaTeX development.
;; It includes packages for enhanced functionality such as autocompletion, version control,
;; and spell checking.
;; ES: Esta configuración adapta Emacs para Org-mode, Python, Jupyter, Java y LaTeX.

;;; ============================================================
;;; 0. First-time setup / Configuración inicial
;;; ============================================================
;; EN: 1. Personal data: replace the placeholders in lines 62-63
;;     (user-full-name / user-mail-address, section 1.1).
;; ES: 1. Datos personales: reemplaza los marcadores de las líneas 62-63
;;     (user-full-name / user-mail-address, sección 1.1).
;;
;; EN: 2. Python environment: run one of these in a terminal to find it:
;;       mamba env list      (or: conda env list)
;;     The output shows the full path, for example:
;;       /home/<your-user>/miniforge3/envs/<your-env>
;;     so:  {USER} = <your-user>    {ENVIRONMENT} = <your-env>
;;     (if your installation lives in miniconda3/anaconda3, adjust that part too).
;; ES: 2. Entorno de Python: ejecuta uno de estos en una terminal para ubicarlo:
;;       mamba env list      (o: conda env list)
;;     La salida muestra la ruta completa, por ejemplo:
;;       /home/<tu-usuario>/miniforge3/envs/<tu-entorno>
;;     es decir:  {USER} = <tu-usuario>    {ENVIRONMENT} = <tu-entorno>
;;     (si tu instalación está en miniconda3/anaconda3, ajusta también esa parte).
;;
;; EN: 3. Replace {USER} and {ENVIRONMENT} in these lines of THIS version:
;; ES: 3. Reemplaza {USER} y {ENVIRONMENT} en estas líneas de ESTA versión:
;;       line  section  setting
;;       184   4.5      org-babel-python-command
;;       259   5.1      elpy-rpc-python-command
;;       260   5.1      python-shell-interpreter
;;       290   5.2      (setenv "WORKON_HOME" ...)
;;       293   5.6      python-shell-interpreter   (overrides line 260)
;;
;; EN: Restart Emacs and verify with M-x elpy-config (section 5).
;; ES: Reinicia Emacs y verifica con M-x elpy-config (sección 5).

;;; AuthSource for Apis
;; EN: Loads credentials (API keys, passwords) from ~/.authinfo.
;; ES: Carga credenciales (claves API, contraseñas) desde ~/.authinfo.
;; EN: Example ~/.authinfo line:  machine api.example.com login myuser password mysecret
;; ES: Ejemplo de línea en ~/.authinfo:  machine api.example.com login myuser password mysecret
;; EN: Prefer ~/.authinfo.gpg (GPG-encrypted) for secrets.
;; ES: Prefiere ~/.authinfo.gpg (cifrado con GPG) para los secretos.
(require 'auth-source)
(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo"))

;;; ============================================================
;;; 1. Initialization and Basic Setup
;;; ============================================================
;; EN: Basic setup: your name/email, package archives, history.
;; ES: Configuración básica: nombre/correo, repositorios de paquetes, historial.

;; 1.1 User Information
;; EN: Replace with your own name and email.
;; ES: Reemplaza con tu propio nombre y correo.
(setq user-full-name "USER NAME GOES HERE"
      user-mail-address "my.email@epn.edu.ec")

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
;; EN: Editor UI: smart indentation and line numbers.
;; ES: Interfaz del editor: indentación inteligente y números de línea.

;; 2.1 Indentation
(electric-indent-mode 1)

;; 2.2 Line Numbers in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)


;;; ============================================================
;;; 3. Text and Document Editing
;;; ============================================================
;; EN: Text editing: auto-fill and spell-check.
;; ES: Edición de texto: relleno automático y corrección ortográfica.

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
;; EN: Org mode: Babel code blocks, Jupyter, LaTeX export, presentations.
;; ES: Org mode: bloques Babel, Jupyter, exportación LaTeX, presentaciones.

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
;; EN: Change this path to your own Python (see section 0 for the placeholders).
;; ES: Cambia esta ruta a tu propio Python (ver la sección 0 para los marcadores).
(setq org-babel-python-command "/home/{USER}/miniforge3/envs/{ENVIRONMENT}/bin/python")

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
;; EN: Python IDE: Elpy, virtualenvs, IPython shell, linting (Flycheck).
;; ES: IDE de Python: Elpy, virtualenvs, shell IPython, linting (Flycheck).
;; ---------------------------------------------------------------------
;; 5.1 Elpy — full Python IDE in Emacs
;; ---------------------------------------------------------------------

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  ;; EN: Point these paths to your conda environment (see section 0).
  ;; ES: Apunta estas rutas a tu entorno de conda (ver la sección 0).
  (setq elpy-rpc-python-command "/home/{USER}/miniforge3/envs/{ENVIRONMENT}/bin/python")
  (setq python-shell-interpreter "/home/{USER}/miniforge3/envs/{ENVIRONMENT}/bin/ipython"
        python-shell-interpreter-args "-i --simple-prompt")
  ;; EN: Pop up the Python shell automatically after C-c C-c so results are visible.
  ;; ES: Muestra la shell de Python automáticamente tras C-c C-c para ver los resultados.
  (setq elpy-shell-display-buffer-after-send t)
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
(setenv "WORKON_HOME" "/home/{USER}/miniforge3/envs/")

;; 5.6 Python shell (IPython)
(setq python-shell-interpreter "/home/{USER}/miniforge3/envs/{ENVIRONMENT}/bin/ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;; 5.7 Flycheck — real-time linting (pyright errors appear here too)
(use-package flycheck
  :ensure t
  :hook (python-mode . flycheck-mode))
;;; ============================================================
;;; 6. Code Completion — Company
;;; ============================================================
;; EN: Company: code-completion popup.
;; ES: Company: menú emergente de autocompletado.

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
;; EN: Yasnippet: expand keywords into code templates.
;; ES: Yasnippet: expande palabras clave en plantillas de código.

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
;; EN: EIN: Jupyter notebooks inside Emacs.
;; ES: EIN: notebooks de Jupyter dentro de Emacs.

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
;; EN: LaTeX: AUCTeX + RefTeX + latexmk.
;; ES: LaTeX: AUCTeX + RefTeX + latexmk.

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
;; EN: Java: LSP (jdtls) + debugger (dap-mode).
;; ES: Java: LSP (jdtls) + depurador (dap-mode).

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
;; (require 'lsp-java-boot)
(add-hook 'lsp-mode-hook  #'lsp-lens-mode)
;; (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode) ; uncomment for Spring Boot


;;; ============================================================
;;; 11. Version Control
;;; ============================================================
;; EN: Git: Magit interface + spell-check in commits.
;; ES: Git: interfaz Magit + corrección en commits.

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
;; EN: Helm: fuzzy search; which-key: keybinding hints.
;; ES: Helm: búsqueda difusa; which-key: ayuda de atajos de teclado.
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
;; EN: Auto-update packages every 30 days (asks first).
;; ES: Actualiza paquetes cada 30 días (pregunta antes).

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
;; EN: gptel: chat with LLMs (Copilot / DeepSeek).
;; ES: gptel: chat con LLMs (Copilot / DeepSeek).


;;; ============================================================
;;; 14.1 GPTel — Copilot primary, DeepSeek secondary
;;; ============================================================
;; EN: Copilot is the default backend and DeepSeek stays registered as
;; secondary. Log in to Copilot once with M-x gptel-gh-login.
;; ES: Copilot es el backend por defecto y DeepSeek queda registrado
;; como secundario. Inicia sesión en Copilot una vez con
;; M-x gptel-gh-login.
;;
;; EN: Only ONE of the two gptel blocks (14.1 and 14.1b) may be
;; uncommented: the last `gptel-backend' assignment wins.
;; ES: Solo UNO de los dos bloques de gptel (14.1 y 14.1b) puede estar
;; descomentado: la última asignación a `gptel-backend' gana.

(use-package gptel
  :ensure t
  :config
  ;; (setq gptel-default-mode 'org-mode) ; comment for Markdown-free chat
  (setq gptel-log-level 'debug)
  ;; EN: 1. Copilot is the default backend (log in once with M-x gptel-gh-login).
  ;; ES: 1. Copilot es el backend por defecto (inicia sesión una vez con M-x gptel-gh-login).
  (setq gptel-backend (gptel-make-gh-copilot "Copilot"))

  ;; EN: 2. Model used by Copilot, as a symbol (e.g. gpt-4o, gpt-4.1, claude-sonnet-4.5).
  ;; ES: 2. Modelo que usará Copilot, como símbolo (p. ej. gpt-4o, gpt-4.1, claude-sonnet-4.5).
  (setq gptel-model 'gpt-4o)
  ;; --------------------------------------------------------------------------------
  ;; Alternative or secondary backends / Backends alternativos o secundarios
  ;; --------------------------------------------------------------------------------
  ;; EN: Uncomment to REGISTER DeepSeek as secondary. Registering does NOT
  ;; change the default; switch with C-u before gptel-send (or M-x gptel-menu)
  ;; and pick the model with the "-m" key.
  ;; ES: Quita el comentario para REGISTRAR DeepSeek como secundario. Registrarlo
  ;; NO cambia el backend por defecto; cambia con C-u antes de gptel-send (o
  ;; M-x gptel-menu) y elige el modelo con la tecla "-m".
  ;; (gptel-make-deepseek "DeepSeek" :stream t :key 'gptel-api-key)
  ;; EN: Uncomment to add Claude or other backends.
  ;; ES: Quita el comentario para agregar Claude u otros backends.
  ;; (gptel-make-anthropic "Claude" :stream t :key "your-api-key")
 )

;; ------------------------------------------------------------------
;; 14.1b Alternative: DeepSeek primary, Copilot secondary
;; ------------------------------------------------------------------
;; EN: Uncomment this block and comment out the one above. Keep the
;; DeepSeek key in ~/.authinfo as:
;;   machine api.deepseek.com login apikey password sk-...
;; ES: Descomenta este bloque y comenta el anterior. Guarda la clave de
;; DeepSeek en ~/.authinfo así:
;;   machine api.deepseek.com login apikey password sk-...

;; (use-package gptel
;;   :ensure t
;;   :config
;;   ;; (setq gptel-default-mode 'org-mode) ; comment for Markdown-free chat
;;   (setq gptel-log-level 'debug)
;;   ;; EN: 1. DeepSeek as the default backend. ":key" is REQUIRED: gptel's
;;   ;;       DeepSeek header sends no credentials without it.
;;   ;; ES: 1. DeepSeek como backend por defecto. ":key" es OBLIGATORIO: la
;;   ;;       cabecera DeepSeek de gptel no envía credenciales sin él.
;;   (setq gptel-model 'deepseek-flash
;;         gptel-backend (gptel-make-deepseek "DeepSeek"
;;                         :stream t
;;                         :key 'gptel-api-key))
;;   ;; EN: 2. Register Copilot as secondary (this does NOT change the
;;   ;;       default); run M-x gptel-gh-login once to authorize it.
;;   ;; ES: 2. Registra Copilot como secundario (esto NO cambia el backend
;;   ;;       por defecto); ejecuta M-x gptel-gh-login una vez para autorizarlo.
;;   (gptel-make-gh-copilot "Copilot")
;;   ;; EN: Uncomment to add Claude or other backends.
;;   ;; ES: Quita el comentario para agregar Claude u otros backends.
;;   ;; (gptel-make-anthropic "Claude" :stream t :key "your-api-key")
;;   )

;; -------------------------------------------------------------
;; 14.2 Inline completion assistant (copilot.el) / Asistente de autocompletado en línea
;; -------------------------------------------------------------
;; EN: Uncomment to enable inline ghost text autocompletion. copilot.el is a
;; separate MELPA package (not installed by default) that needs Node.js 22+
;; and a GitHub Copilot account.
;; ES: Descomenta para habilitar el autocompletado fantasma en línea. copilot.el
;; es un paquete MELPA aparte (no se instala por defecto) que requiere
;; Node.js 22+ y una cuenta de GitHub Copilot.
;;
;; EN: IMPORTANT: after uncommenting and restarting Emacs, run these two
;; commands the first time: 1. M-x copilot-install-server  2. M-x copilot-login
;; ES: IMPORTANTE: si descomentas este bloque y reinicias Emacs, ejecuta
;; estos dos comandos la primera vez: 1. M-x copilot-install-server  2. M-x copilot-login

;; (use-package copilot
;;   :ensure t
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . 'copilot-accept-completion)
;;               ("TAB" . 'copilot-accept-completion)
;;               ("C-<right>" . 'copilot-accept-completion-by-word)))


;;; ============================================================
;;; 15. WSL Browser
;;; Requires: sudo apt install wslu
;;; ============================================================
;; EN: Open links with the Windows browser (WSL: wslview).
;; ES: Abre enlaces con el navegador de Windows (WSL: wslview).

(setq browse-url-generic-program  "wslview")
(setq browse-url-browser-function 'browse-url-generic)


;;; ============================================================
;;; 16. Doom Emacs Themes
;;; ============================================================
;; EN: Doom themes: optional dark themes, disabled by default.
;; ES: Temas Doom: temas oscuros opcionales, desactivados por defecto.
;;Disable custom-enabled-themes
;; Doom themes / Temas Doom:
;;   EN: Doom: uncomment the doom-themes and nerd-icons blocks below, then uncomment `custom-safe-themes' and comment out `custom-enabled-themes' (section 17).
;;   ES: Doom: descomenta los bloques doom-themes y nerd-icons de abajo, luego descomenta `custom-safe-themes' y comenta `custom-enabled-themes' (sección 17).
;;   EN: Default: leave everything as is — deeper-blue stays active.
;;   ES: Default: déjalo todo como está — deeper-blue sigue activo.
;; (use-package doom-themes
;;   :ensure t
;;   :custom
;;   ;; Global settings (defaults)
;;   (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
;;   (doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   ;; for treemacs users
;;   (doom-themes-treemacs-theme "doom-homage-black") ; use "doom-colors" for less minimal icon theme ; doom-ir-black ; doom-atom
;;   :config
;;   (load-theme 'doom-homage-black t)		;doom-1337

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (nerd-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

;; (use-package nerd-icons
;;   :ensure t
;; )

;;; ============================================================
;;; 17. Customizations (managed by Custom — do not edit by hand)
;;; ============================================================
;; EN: Auto-generated by Emacs Custom: theme, dictionary, installed packages.
;; ES: Generado por Custom de Emacs: tema, diccionario, paquetes instalados.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; Doom themes / Temas de Doom:
 ;;   EN: uncomment `custom-safe-themes' below and comment out `custom-enabled-themes'.
 ;;   ES: descomenta `custom-safe-themes' (abajo) y comenta `custom-enabled-themes'.
 ;; '(custom-safe-themes '(default))
 '(custom-enabled-themes '(deeper-blue)) 
 '(ispell-dictionary "castellano")
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
