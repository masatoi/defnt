(defpackage #:defnt/main
  (:nicknames #:defnt)
  (:use #:cl)
  (:export #:defnt
           #:tlet))
(in-package #:defnt/main)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *optimize-setting*
    '(optimize (speed 3) (safety 0) (debug 0)))

  (defvar *type-nickname-alist*
    '((f . single-float)
      (af . (simple-array single-float))))

  (defun rename-type-by-nickname (type)
    (let ((nickname-pair (assoc type *type-nickname-alist* :test #'equal)))
      (if nickname-pair
          (cdr nickname-pair)
          type))))

(defmacro defnt (function-spec (&rest arg-specs) &body body)
  "define typed function

Examples:
(defnt (tak fixnum) ((x fixnum) (y fixnum) (z fixnum))
  (if (<= x y)
      z
      (tak (tak (1- x) y z)
           (tak (1- y) z x)
           (tak (1- z) x y))))

(defnt (mulval (values fixnum double-float)) ((x fixnum) (y double-float))
  (values (floor y) (* x 1.0d0)))
"
  `(progn
     (declaim (ftype (function ,(mapcar (lambda (spec)
                                          (rename-type-by-nickname (cadr spec)))
                                        arg-specs)
                               ,(rename-type-by-nickname (cadr function-spec)))
                     ,(car function-spec)))
     (defun ,(car function-spec) ,(mapcar #'car arg-specs)
       (declare ,*optimize-setting*
                ,@(mapcar (lambda (arg arg-type)
                            (list 'type arg-type arg))
                          (mapcar #'car arg-specs)
                          (mapcar (lambda (spec)
                                    (rename-type-by-nickname (cadr spec)))
                                  arg-specs)))
       ,@body)))

(defmacro tlet (bindings &body body)
  "typed let

Examples:
(tlet ((x 1 fixnum)
       (y (+ 2 2) fixnum))
  (+ x y))
"
  `(let (,@(mapcar (lambda (binding)
                     (subseq binding 0 2))
                   bindings))
     (declare ,@(mapcar (lambda (binding)
                          (list 'type
                                (rename-type-by-nickname (caddr binding))
                                (car binding)))
                        bindings))
     ,@body))
