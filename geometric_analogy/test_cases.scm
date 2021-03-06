;-----------------------------------------------------------
;TEST CASE 1
;representation for figure 7.30 pg 275 Artificial Intelligence, Luger
;inside a square is a triangle, side a triangle is a circle
(define A '(inside square (inside triangle circle)))
(define B '(inside square (inside circle triangle)))
(define C '(inside square (inside square triangle)))

(define D1 '(inside square (inside circle square)))
(define D2 '(inside square (inside triangle circle)))
(define D3 '(inside square (inside triangle square)))
(define D4 '(inside square (right-of square triangle)))
;-----------------------------------------------------------
;TEST CASE 2
(define A '(inside triangle circle))
(define B '(above triangle circle))
(define C '(inside oval square))

(define D1 '(inside circle square))
(define D2 '(above oval square))
(define D3 '(right-of circle square))
(define D4 '(above triangle oval))
;-----------------------------------------------------------
;TEST CASE 3
;from Sabine Bergler
(define A '(inside square (inside circle square)))
(define B '(inside circle (inside square circle)))
(define C '(inside circle (inside square circle)))

(define D1 '(inside square (inside circle square)))
(define D2 '(inside square (inside circle circle)))
(define D3 '(inside circle (inside circle square)))
;-----------------------------------------------------------
;TEST CASE 4
;from Sabine Bergler
(define A '(inside square (inside square (inside square square))))
(define B '(inside square (inside square (inside square circle))))
(define C '(square))

(define D1 triangle)
(define D2 circle)
(define D3 square)
;-----------------------------------------------------------
;TEST CASE 5

(define A '(inside circle (inside triangle triangle)))
(define B '(inside triangle circle))
(define C '(inside square (inside triangle circle)))

(define D1 '(inside triangle square))
(define D2 '(inside square circle))
(define D3 '(inside triangle circle))

;-----------------------------------------------------------
;TEST CASE 6 -TRIAL 1

(define A '(inside square (right-of (inside circle triangle) triangle)))
(define B '(inside square (below triangle triangle)))
(define C '(inside square (right-of (inside square circle) square)))

(define D1 '(inside square (below square square)))
(define D2 '(inside square (below circle triangle)))
(define D3 '(inside square (below circle square)))

;-----------------------------------------------------------
;TEST CASE 6 -TRIAL 2

(define A '(inside square (right-of (inside circle triangle1) triangle)))
(define B '(inside square (below triangle1 triangle)))
(define C '(inside square (right-of (inside square circle) square)))

(define D1 '(inside square (below square square)))
(define D2 '(inside square (below circle triangle)))
(define D3 '(inside square (below circle square)))
;-----------------------------------------------------------
;TEST CASE 6 -TRIAL 3

(define A '(inside square (right-of (inside circle triangle1) triangle)))
(define B '(inside square (below triangle triangle)))
(define C '(inside square (right-of (inside square circle) square)))

(define D1 '(inside square (below square square)))
(define D2 '(inside square (below circle triangle)))
(define D3 '(inside square (below circle square)))
;-----------------------------------------------------------
(define A '(inside square (is_a triangle triangle)))
(define B '(inside square (is_a circle circle)))
(define C '(is_a triangle triangle)

(define D1 '(is_a circle circle))
(define D2 '(is_a triangle triangle))
(define D3 '(inside square (inside triangle square)))
(define D4 '(inside square (right-of square triangle)))