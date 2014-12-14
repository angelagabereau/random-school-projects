;-----------------------------------------------------------
;TEST CASE 1
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


(define shapes '(s1 s2 s3 s4 s5 s6 s7 s8 s9))
(define mappingAB '())
(define mappingCD '())

(define target_model '())

(define patternA '())
(define patternB '())
(define patternC '())
(define patternD '())



(define get_patternAB
  (lambda ()
    (set! mappingAB (map_base A mappingAB))
    (set! patternB (translate_base B mappingAB))
    )
  )
(define get_patternC
  (lambda ()
    (set! mappingCD (map_base C mappingCD))
    )
  )



;takes a list of 3 items
;the first element is the predicate (inside, above, right, etc)
;the 2nd and 3rd are the terms, circle, square, triangle or another list.
;if the terms are shapes it maps them to target
;if the term is a list it call map_base_to_target on the list.
(define map_base
  (lambda (base mapping)
    ;first term
    (if (symbol? (cadr base))
        (set! mapping (map_to_representation (cadr base) mapping))
        (set! mapping (map_base (cadr base) mapping))
        )
    ;second term
    (if (symbol? (caddr base))
        (set! mapping (map_to_representation (caddr base) mapping))
        (set! mapping (map_base (caddr base) mapping))
        )
    mapping
    ) 
  )
;returns mapping list
(define map_to_representation
  (lambda (shape mapping)
    ;add shape to map list.
    (cons shape mapping)
    )
  )

;we want to make a new list and replace the terms with the mapping.
;so the list has 3 elements
;take an empty list 
;add the predicate
;add the terms (if term is a list recurse
;return the pattern list
(define translate_base
  (lambda (base mapping)
    (let ((pattern '())
          (predicate (car base))
          (term1 (cadr base))
          (term2 (caddr base))
          )
      (if (symbol? term1)
          (set! term1 (get_representation term1 mapping))
          (set! term1 (translate_base term1 mapping))
          )
      (if (symbol? term2)
          (set! term2 (get_representation term2 mapping))
          (set! term2 (translate_base term2 mapping))
          )
      ;return translated list
      (list predicate term1 term2)
      ) 
    )
  )
(define test '())
(define remove_term_from_mappingAB
  (lambda (mapping term)
    (let* ((rmapping (reverse mappingAB)))
      (do ((i 0 (+ 1 i)))
        ((= i (length rmapping))
         (set! test '()))
        (if (equal? term (list-ref rmapping i))
            (set! test (cons 0 test))
            (set! test (cons (list-ref rmapping i) test))
            )
        ) 
      (set! mappingAB test)
      (set! test '())
      )
    )
  )

(define get_representation
  (lambda (term mapping)
    (let ((k 0))
      (set! k (- (length (member term (reverse mapping))) 1))
      (remove_term_from_mappingAB mapping term)
      (list-ref shapes k)
      )
    )
  )



(define get_analogy
  (lambda ()
    (cond ((equal? patternD D1) (display_analogy D1 "D1"))
          ((equal? patternD D2) (display_analogy D2 "D2"))
          ((equal? patternD D3) (display_analogy D3 "D3"))
          ;((equal? patternD D4) (display_analogy D4 "D4"))
          (else (display "Sorry, could not solve this analogy"))
          )
    )
  )

(define display_analogy
  (lambda (answer_pattern answer_name)
    (display "GEOMETRIC ANALOGY")
    (newline)
    (display "----------------------------------")
    (newline)
    (newline)
    (display "A") 
    (display " IS TO ")
    (display "B")
    (newline)
    (display "AS")
    (newline)
    (display "C") 
    (display " IS TO ")
    (display answer_name)
    (newline)
    (newline)
    (display A) 
    (display " IS TO ")
    (display B)
    (newline)
    (display "AS")
    (newline)
    (display C) 
    (display " IS TO ")
    (display answer_pattern)
    )
  )

(define constructD
  (lambda (base)
    (let ((pattern '())
          (predicate (car base))
          (term1 (cadr base))
          (term2 (caddr base))
          )
      (if (symbol? term1)
          (set! term1 (get_shape term1))
          (set! term1 (constructD term1))
          )
      (if (symbol? term2)
          (set! term2 (get_shape term2))
          (set! term2 (constructD term2))
          )
      ;return translated list
      (list predicate term1 term2)
      )
    
    )
  )
(define get_shape
  (lambda (term)
    (let ((k 0))
      (set! k (- (length (member term (reverse shapes))) 1))
      (list-ref mappingCD k)
      )
    )
  )

(define geometric_analogy
  (lambda ()
    (get_patternAB)
    (get_patternC)
    (set! patternD (constructD patternB))
    (newline)
    (get_analogy)
    )
  )

(geometric_analogy)