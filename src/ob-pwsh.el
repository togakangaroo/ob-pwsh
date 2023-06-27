;; inspired by ob-racket.el by Chris Vig (chris@invictus.so)

(require 'ob)

;; TODO require `powershell-mode' here as well?

;; -- Variables --

(add-to-list 'org-babel-tangle-lang-exts '("Pwsh" . "ps"))

(add-to-list 'org-src-lang-modes '("pwsh" . powershell))

(defcustom org-babel-default-header-args:pwsh '((:lang . "pwsh"))
  "A list of default header args for Pwsh code blocks."
  :type '(alist :key-type (symbol :tag "Keyword") :value-type (string :tag "Value")))

(defcustom org-babel-command:pwsh "pwsh"
  "The path to the Pwsh interpreter executable."
  :group 'ob-pwsh
  :type 'string)

;; -- Babel Functions --

(defun org-babel-expand-body:pwsh (body params)
  "Expands the body of a Pwsh code block."
  ;; Currently we don't do any expansion for tangled blocks. Just return
  ;; body unmodified as specified by the user.
  body)

(defun org-babel-execute:pwsh (body params)
  "Executes a Powershell code block."
  ;; Round up the stuff we need
  (let* ((parsed-params (ob-pwsh--parse-params params))
         (expanded-body (org-babel-expand-body:pwsh body params))
         (result-type (nth 0 parsed-params))
         (vars (nth 1 parsed-params))
         (temp-file (make-temp-file "ob-pwsh-" nil ".ps1")))
    (message (format "===vars %s" vars))
    ;; Build script in temporary file
    (with-temp-file temp-file
      (let ((vars-string
             (mapconcat (lambda (var) (format "$%s = %s;\n" (car var) (ob-pwsh--serialize-value (cdr var)))) vars " ")))
        (insert (format "%s\n\n%s"
                        vars-string
                        expanded-body)))
      )
    ;; Run script with Racket interpreter, delete temp file, and return output
    (with-temp-buffer
      (prog2
          (call-process org-babel-command:pwsh nil (current-buffer) nil temp-file)
          (buffer-string)
        (delete-file temp-file)))))

(defun org-babel-prep-session:pwsh (session params)
  (error "Pwsh does not currently support sessions."))

;; -- Parameter Parsing --

(defun ob-pwsh--parse-params (params)
  "Processes and parses parameters for an Org Babel code block. The results are
returned as a list."
  (let ((processed-params (org-babel-process-params params))
        (result-type nil)
        (vars nil))
    (dolist (processed-param processed-params)
      (let ((key (car processed-param)) (value (cdr processed-param)))
        (cond
         ((equal key :result-type) (setq result-type value))
         ((equal key :var) (push value vars)))))
    (list result-type vars)))

(defun ob-pwsh--serialize-value (value)
  "Serialize a value for use in a PowerShell script."
  (cl-typecase value
    (integer value)
    (float value)
    (character (ob-pwsh--serialize-stringlike value))
    (string (ob-pwsh--serialize-stringlike value))
    (symbol (ob-pwsh--serialize-stringlike value))
    (cons (ob-pwsh--serialize-sequence value))
    (t (error "Pwsh cannot currently serialize values of type %s." (type-of value)))))

(defun ob-pwsh--serialize-stringlike (value)
  "Serialize a string-like value for use in a PowerShell script. Relies on `powershell-mode'."
  (with-temp-buffer
    (push-mark)
    (insert value)
    (setq mark-active t)
    (powershell-doublequote-selection (point-min) (point-max))
    (buffer-string)))

(defun ob-pwsh--serialize-sequence (value)
  "Serialize a sequence for use in a PowerShell script."
  (format "@(%s)" (mapconcat #'identity (ob-pwsh--serialize-value) ", ")))

(provide 'ob-pwsh)
