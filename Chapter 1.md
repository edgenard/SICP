# Notes and Exercises from Chapter 1

## Exercises

### 1

Below is a sequence of expressions. What is the result printed by the interpreter in response to each expression? Assume that the sequence is to be evaluated in the order in which it is presented.



	10 --> 10
	
	(+ 5 3 4) --> 12
	
	(- 9 1) --> 8
	
	(/ 6 2) --> 3
	
	(+ (* 2 4) (- 4 6)) --> 6
	
	(define a 3) --> No result printed, assigns the value of 3 to a behind the scenes
	
	(define b (+ a 1)) No result printed defines b the value of b as 1 more than a
	
	(+ a b(*a b)) --> 19
	
	(= a b) --> false

	(if (and (> b a)(< b (* a b))) 
		b 
		a) --> 4
		
	(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25)) --> 16
    
    (+ 2 (if (> b a) b a)) --> 6
    
    (* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   		(+ a 1)) --> 16
   		
   	
	

### 2
Translate the following expression into prefix form:

![exercise 2](ex1-2.gif)

	(/ (+ 5 4 (- 2 (- 3 (- 6 (/ 4 5))))) 
		(* 3 (- 6 2) (- 2 7))) --> -11/50

### 3

Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers. 

	(define (largerSum a b c)
	  (define big1 (if (> a b) a b))
	  (define small1 (if (= big1 a) b a))
	  (define big2 (if (> c small1) c small1))
	  (+ big1 big2))

### 4
Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure: 

	(define (a-plus-abs-b a b)
	  ((if (> b 0) + -) a b))
	
This creates a procedure called "a-plus-abs-b" that takes 2 parameters. It then tests if the second parameter is a positive number. If it is a positive number it the two parameters are added. If it is not the two parameters are subtracted from each other which adds them. 
For example:

Given a = 5 and b = -6. The operation will be 5 - (-6) which is 5 + 6. That way you always get the absolute value of the second parameter. 

### 5

Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures: 

	(define (p) (p))
	
	(define (test x y)
	  (if (= x 0)
	      0
	      y))

Then he evaluates the expression

`(test 0 (p))`

What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer. (Assume that the evaluation rule for the special form if is the same whether the interpreter is using normal or applicative order: The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.)

In an interpreter that uses normal-order evaluation `(test 0 (p))` will return zero because `(p)` will never be evaluated. In applicative-order evaluation we will get an infinite loop because  `(p)` just keeps calling itself.


### 6

Alyssa P. Hacker doesn't see why if needs to be provided as a special form. "Why can't I just define it as an ordinary procedure in terms of cond?" she asks. Alyssa's friend Eva Lu Ator claims this can indeed be done, and she defines a new version of `if`: 

	(define (new-if predicate then-clause else-clause)
	  (cond (predicate then-clause)
	        (else else-clause)))

Eva demonstrates the program for Alyssa:

	(new-if (= 2 3) 0 5)
	5
	
	(new-if (= 1 1) 0 5)
	0

 Delighted, Alyssa uses new-if to rewrite the square-root program:

	(define (sqrt-iter guess x)
	  (new-if (good-enough? guess x)
	          guess
	          (sqrt-iter (improve guess x)
	                     x)))

What happens when Alyssa attempts to use this to compute square roots? Explain. 

When I run this in the debugger, I notice that the `(good-enogh? guess x)` never evaluates to true so the recursion never stops.  I do not understand why this happens. \\

**I googled it.**

It is because `new-if` is a regular compound procedure so before it is returned LISP evaluates all the arguments and one of the arguments is call to itself so LISP never reaches a primitive value. It just keeps calling `sqr-iter` over and over. This is because of applicative order evaluation, if this was evaluated in normal order it would return guess.  