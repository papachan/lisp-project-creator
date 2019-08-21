;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;;; main.lisp

(in-package :project-create)

;; setup debun to nil when you make an image
(defconstant *debug* nil)

(defvar *templates-dir*
  (asdf:system-relative-pathname :project-create #P"templates"))

(defvar *local-directory*
  (if *debug*
      (pathname-parent-directory (asdf:system-relative-pathname :project-create ""))
      (make-pathname :directory '(:relative "."))))

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

;; ask the project name
(defun main ()
  "Ask for a project name and create all files"
  (flet ((prompt (string)
           (format *query-io* "~a: " string)
           (force-output *query-io*)
           (read-line *query-io*)))
    (let* ((project-name (prompt "What is your project name?"))
           (project-root (make-pathname :directory
                                        (append (pathname-directory *local-directory*) (list project-name))))
           (files '()))
      (progn
        ;; create directories
        (loop :for n in '("t" "src")
              :do (ensure-directories-exist
                   (make-pathname :directory
                                  (append (pathname-directory project-root) (list n)))))
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
        (format t ";; DONE~%")))))


(if *debug*
    (main))

;; main.lisp ends here
