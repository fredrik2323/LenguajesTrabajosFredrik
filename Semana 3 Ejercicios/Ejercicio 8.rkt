(define (sub-conjunto? lst1 lst2)
  (cond
    ((null? lst1) #t)                     
    ((member (car lst1) lst2)               
     (sub-conjunto? (cdr lst1) lst2))       
    (else #f)))                           

(displayln (sub-conjunto? '(a v d) '(a b c d e f))) ; #t
(displayln (sub-conjunto? '(a b f) '(a b c d e f))) ; #t
(displayln (sub-conjunto? '(a b d) '(a b c d e f))) ; #f


