#lang racket
(define (average x y)
  (/ (+ x y) 2))

(define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (square x) (* x x))

(define (good-enough? guess x)
  (< (abs ( - (square guess) x)) .001))

(define (try guess x)
  (new-if (good-enough? guess x)
      guess
      (try (improve guess x) x)))
(define (sqroot x) (try 1.00 x))

 