(define build-record
  (lambda (state parent depth weight)
    (list state parent depth weight)
    )
  )
  (define get-state
  (lambda (record)
    (list-ref record 0)
    )
  )
(define get-parent
  (lambda (record)
    (list-ref record 1)
    )
  )
(define get-depth
  (lambda (record)
    (list-ref record 2)
    )
  )
(define get-weight
  (lambda (record)
    (list-ref record 3)
    )
  )
  (define swap ; swap the element in list ls1 (which wil be 'B) with the element1
  (lambda (state t1 t2)
    (define new-tile -1) 
    (do ((k (- (length state) 1) (- k 1))
         (new-state '() (cons new-tile new-state))
         )
      ((= -1 k) 
        new-state
       )
      (set! new-tile (cond ((equal? (list-ref state k) t1) t2)
                              ((equal? (list-ref state k) t2) t1)
                              (else (list-ref state k))
                              )
            )
      )
    )
  )
  (define up ;moves tile b up one place in 8 puzzel.  Only works when only 1 b tile exists in 8 puzzel
  (lambda (state)
    (display state)
    (let ((b-subset (member 'B state)) ;b-subset is the sublist of state, of which B is (car b-subset)
          (blank-pos -1)
          )
      (display b-subset)
      (cond ((not b-subset) '()) ; if b-subset is false return empty list.
             ((< 6 (length b-subset)) '()) ; if the blank is in the top row return empty list.
             (else (set! blank-pos
                         (- 9 (length b-subset))); blank-pos is set to 9 miuns the length of b-subset
                   (swap state 'B (list-ref state (- blank-pos 3))) ;subtract 3 from blank-pos b/c a move up is equal to moving element 3 places back in list.
                   )
             )
            )
      )
    )