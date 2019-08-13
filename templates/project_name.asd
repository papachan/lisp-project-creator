;;;; {{project_name}}.asd

(asdf:defsystem #:{{project_name}}
  :author ""
  :license  "BSD"
  :depends-on (:fiveam
               :{{project_name}}-test)
  :serial t
  :components (
               (:module "src"
                :serial t
                :components
                ((:file "package")
                 (:file "main"))))
  :description "Please enter a description"
  :long-description #.(uiop:read-file-string
                       (uiop:subpathname *load-pathname* "README.md"))
  :perform (test-op
          (o s)
          (uiop:symbol-call :fiveam '#:run!
                            (uiop:find-symbol* '#:all-tests
                                               :{{project_name}}-test))))
