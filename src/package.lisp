;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;;; package.lisp
(in-package :cl-user)
(defpackage project-create
  (:use #:cl)
  (:import-from
   :cookbook
   :replace-all)
  (:import-from
   :cl-fad
   :walk-directory
   :pathname-parent-directory)
  (:import-from
   :uiop
   :pathname-directory-pathname
   :directory-exists-p
   :split-string
   :read-file-string)
  (:export :main))
