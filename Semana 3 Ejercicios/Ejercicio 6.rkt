(define (merge lista1 lista2)
  (cond
    [(empty? lista1) lista2]
    [(empty? lista2) lista1]
    [(< (car lista1) (car lista2))
     (cons (car lista1) (merge (cdr lista1) lista2))]
    [else
     (cons (car lista2) (merge lista1 (cdr lista2)))]))

(merge '(1 2 3 4) '(2 6 7 8))
(merge '(1 2 3 5) '(1 2 3 5))
