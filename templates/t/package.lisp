;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;; package.lisp
(asdf:oos 'asdf:load-op :fiveam)

(defpackage #:{{project_name}}-test
  (:use :cl
        :fiveam)
  (:import-from
   :{{project_name}}
   :hello))
