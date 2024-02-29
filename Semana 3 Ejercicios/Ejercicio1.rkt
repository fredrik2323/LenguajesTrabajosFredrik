(define (calcular-monto Cap I N)
  (define (calcular-monto-aux Cap I N)
    (if (= N 0)
        Cap
        (calcular-monto-aux (+ Cap (* Cap I)) I (- N 1))))
  (format "~a      ~a      ~a    ~a" Cap I N (calcular-monto-aux Cap I N)))


(displayln "Capital  Interés  Años  Resultado")
(displayln "-----------------------------------")
(displayln (calcular-monto 2000 0.10 0))
(displayln (calcular-monto 2000 0.10 1))
(displayln (calcular-monto 2000 0.10 2))
(displayln (calcular-monto 2000 0.10 3))

