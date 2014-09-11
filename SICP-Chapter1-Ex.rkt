#lang racket

;Exercise 2 from Chapter 1 of SICP
#|
 Define a procedure that takes three numbers as arguments 
and returns the sum of the squares of the two larger numbers. 
 |#

(define (largerSum a b c)
  (define big1 (if (> a b) a b))
  (define small1 (if (= big1 a) b a))
  (define big2 (if (> c small1) c small1))
  (+ big1 big2))

         