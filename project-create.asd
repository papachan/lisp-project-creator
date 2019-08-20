;;;; project-create.asd

(asdf:defsystem #:project-create
  :author "Dan Loaiza <papachan@gmail.com>"
  :license  "BSD"
  :serial t
  :depends-on (:cl-mustache
               :cl-fad
               :str
               :project-create/cookbook)
  :components ((:module "src"
                :serial t
                :components
                ((:file "package")
                 (:file "main"))))
  :description "Generate a scaffold structure for a customized lisp project")


(asdf:defsystem #:project-create/cookbook
  :author "Dan Loaiza <papachan@gmail.com>"
  :license  "BSD"
  :serial t
  :components ((:module "src"
                :serial t
                :components
                ((:file "functions"))))
  :description "")
