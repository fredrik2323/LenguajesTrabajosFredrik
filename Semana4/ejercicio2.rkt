(define (substring-present? cadena subcadena)
  (not (equal? #f (regexp-match? (regexp (string-append ".*" subcadena ".*")) cadena))))

(define (sub_cadenas subcadena lista)
  (filter (lambda (cadena) (substring-present? cadena subcadena))
          lista))


(displayln (sub_cadenas "el" '("el estacionamiento " " el marcador" "esta en el super")))

(displayln (sub_cadenas "la" '("la persona " "papas " "come en la mesa")))

(displayln (sub_cadenas "lo" '(" ayer" "lo adivine" "hola" "lo supe")))