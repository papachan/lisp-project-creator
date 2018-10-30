;;;; project-create.asd

(asdf:defsystem #:project-create
  :author "Dan Loaiza <papachan@gmail.com>"
  :license  "BSD"
  :serial t
  :components (
               (:module "src"
                :serial t
                :components
                ((:file "package")
                 (:file "main"))))
  :description "Generate quickly a customized lisp project scaffold")
