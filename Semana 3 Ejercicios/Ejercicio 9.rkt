(define (eliminar_elemento E L)
  (define (eliminar x)
    (if (equal? x E)
        '()
        (cons x '())))
  (apply append (map eliminar L)))

(displayln (eliminar_elemento 5 '(1 2 3 4 5))) 
(displayln (eliminar_elemento 2 '(1 2 3 4 5))) 


