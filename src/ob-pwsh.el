;; inspired by ob-racket.el by Chris Vig (chris@invictus.so)

(require 'ob)

;; -- Variables --

(add-to-list 'org-babel-tangle-lang-exts '("Pwsh" . "ps"))

(defvar org-babel-default-header-args:pwsh '((:lang . "pwsh"))
  "A list of default header args for Pwsh code blocks.")

(defvar org-babel-command:pwsh "pwsh"
  "The path to the Pwsh interpreter executable.")

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
         (temp-file (make-temp-file "ob-pwsh-")))
    (message (format "===vars %s" vars))
    ;; Build script in temporary file
    (with-temp-file temp-file
      (let ((vars-string
             (mapconcat (lambda (var) (format "$%s = %s;\n" (car var) (cdr var))) vars " ")))
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

(provide 'ob-pwsh)
