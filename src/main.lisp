;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;;; main.lisp

(in-package :project-create)

;; setup debug to nil for release
(defvar *debug* nil)

(defvar *local-directory*
  (if *debug*
      (asdf:system-relative-pathname :project-create "")
      (make-pathname :directory '(:relative "."))))

(defvar *templates-dir*
  (asdf:system-relative-pathname :project-create #P"templates"))

(defun get-current-year ()
  (multiple-value-bind (s min h d m y) (decode-universal-time (get-universal-time))
    (declare (ignore s min h))
    y))

(defun copy-files (lst values)
  (loop :for n :in lst
        :do (with-open-file (output-stream (second n)
                                           :direction :output
                                           :if-exists :supersede
                                           :if-does-not-exist :create)
              (mustache:render (read-file-string (car n)) values output-stream)
              (format t "~A~%" (second n)))))

(defun main (&aux (files '()))
  "Ask for a package name and create all files"
  (flet ((prompt (string)
           (let ((*error-output* *query-io*)
                 (*query-io*     *query-io*))
             (format t "~%~A " string)
             (finish-output)
             (handler-case (string-trim '(#\space #\tab) (read-line *query-io*))
               (sb-sys:interactive-interrupt ()
                 (format *error-output* "~%Aborting.~&")
                 (uiop:quit))))))
    (let* ((project-name (prompt "Your package name?"))
           (project-root (make-pathname :directory
                                        (append (pathname-directory *local-directory*)
                                                (list project-name)))))
      ;; create directories
      (loop :for n in '("t" "src")
            :do (ensure-directories-exist
                 (make-pathname :directory
                                (append (pathname-directory project-root)
                                        (list n)))))
      (unless (directory-exists-p project-root)
        (error "~S does not exist." project-root))
      ;; make a list from real path and new path file
      (walk-directory *templates-dir*
                      (lambda (path)
                        (let* ((fname (file-namestring path))
                               (name (subseq fname 0 (position #\. fname :test #'equal)))
                               (subpath (make-pathname :directory
                                                       (append (list :relative)
                                                               (cdr (member "templates" (pathname-directory path) :test #'equal)))
                                                       :name (mustache:render* name (list (cons :project_name project-name)))
                                                       :type (subseq fname (1+ (position #\. fname :test #'equal)))))
                               (newpath (merge-pathnames subpath project-root)))
                          (push (list path newpath) files))))
      (copy-files files (list (cons :project_name project-name)
                              (cons :year (get-current-year))))
      (format t ";; DONE~%"))))

(if *debug*
    (main))

;; main.lisp ends here
