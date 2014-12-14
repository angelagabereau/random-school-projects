;-----------------------------------------------------------
;representation for figure 7.30 pg 275 Artificial Intelligence, Luger
;inside a square is a triangle, side a triangle is a circle
(define A '(inside square (inside triangle circle)))
(define B '(inside square (inside circle triangle)))
(define C '(inside square1 (inside square2 triangle)))

(define D1 '(inside square1 (inside circle square2)))
(define D2 '(inside square (inside triangle circle)))
(define D3 '(inside square1 (inside triangle square2)))
(define D4 '(inside square1 (right-of square2 triangle)))
;-----------------------------------------------------------
(define A '(inside triangle circle))
(define B '(above triangle circle))
(define C '(inside oval square))

(define D1 '(inside circle square))
(define D2 '(above oval square))
(define D3 '(right-of circle square))
(define D4 '(above triangle oval))
;-----------------------------------------------------------

(define representations '(a b c d e f g h))
(define mapping '())

(define target_model '())

(define patternAB '())
(define patternCD1 '())
(define patternCD2 '())
(define patternCD3 '())
(define patternCD4 '())

;takes a list of 3 items
;the first element is the predicate (inside, above, right, etc)
;the 2nd and 3rd are the terms, circle, square, triangle or another list.
;if the terms are shapes it maps them to target
;if the term is a list it call map_base_to_target on the list.
(define map_base
  (lambda (base)
    ;first term
    (if (symbol? (cadr base))
        (map_to_representation (cadr base))
        (map_base (cadr base))
        )
    
    ;second term
    (if (symbol? (caddr base))
        (map_to_representation (caddr base))
        (map_base (caddr base))
        )
    ) 
  )

(define map_to_representation
  (lambda (shape)
    ;if shape is not on mapping list then add it.
    (if (not(member shape mapping))
        (set! mapping (cons shape mapping))
        )
    )
  )


;we want to make a new list and replace the terms with the mapping.
;so the list has 3 elements
;take an empty list 
;add the predicate
;add the terms (if term is a list recurse
;return the pattern list
(define translate_base
  (lambda (base)
    (let ((pattern '())
          (predicate (car base))
          (term1 (cadr base))
          (term2 (caddr base))
          )
      (if (symbol? term1)
          (set! term1 (get_representation term1))
          (set! term1 (translate_base term1))
          )
      (if (symbol? term2)
          (set! term2 (get_representation term2))
          (set! term2 (translate_base term2))
          )
      ;return translated list
      (list predicate term1 term2)
      ) 
    )
  )

(define get_representation
  (lambda (term)
    (let ((k 0))
        (set! k (- (length (member term (reverse mapping))) 1))
      (list-ref representations k)
    )
    )
  )

(define create_patterns
  (lambda ()
    (set! patternAB (pattern A B))
    (set! patternCD1 (pattern C D1))
    (set! patternCD2 (pattern C D2))
    (set! patternCD3 (pattern C D3))
    (set! patternCD4 (pattern C D4))
    )
  )

(define pattern
  (lambda (x y)
    (set! mapping '())
    (map_base x)
    (display mapping)
    (map_base y)
    (display mapping)
    (newline)
    (list (translate_base x)  (translate_base y))
    )
  )

(define get_analogy
  (lambda ()
    (cond ((equal? patternAB patternCD1) (display_analogy D1))
          ((equal? patternAB patternCD2) (display_analogy D2))
          ((equal? patternAB patternCD3) (display_analogy D3))
          ((equal? patternAB patternCD4) (display_analogy D4))
          (else (display "Sorry, could not solve this analogy"))
          )
    )
  )

(define display_analogy
  (lambda (answer)
    (display "GEOMETRIC ANALOGY")
    (newline)
    (display A) 
    (display " IS TO ")
    (display B)
    (newline)
    (display "AS")
    (newline)
    (display C) 
    (display " IS TO ")
    (display answer)
    )
  )

(create_patterns)
(display patternAB)
(newline)
(display patternCD1)
(newline)
(display patternCD2)
(newline)
(display patternCD3)
(newline)
(display patternCD4)
(newline)

(get_analogy)

;maybe what needs to be done is if there is not direct pattern matches then it looks at a subset of the pattern to see if a match can be found.


