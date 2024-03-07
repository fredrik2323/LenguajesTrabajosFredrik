(define ListaProductos        
  '(("arroz" 8 1800)
    ("frijoles" 5 1200)
    ("azucar" 6 1100)
    ("cafe" 2 2800)
    ("leche" 9 1200)
    ("pan" 4 1600)
    ("huevos" 10 1300)))

(define (agregarProducto Lista nombre cantidad precio)
  (cond ((null? Lista)
         (list (list nombre cantidad precio)))
        ((equal? nombre (caar Lista))
         (cons (list
                (caar Lista)
                (+ (cadr (car Lista)) cantidad)
                precio)
               (cdr Lista)))
        (else
         (cons (car Lista)
               (agregarProducto
                (cdr Lista)
                nombre
                cantidad
                precio)))))

(define (venderProducto Lista nombre cantidad)
  (cond ((null? Lista)
         (display "No existe ese producto a vender")
         '())
        ((equal? nombre (caar Lista))
         (if (>= (cadr (car Lista)) cantidad)
             (cons (list
                    (caar Lista)
                    (- (cadr (car Lista)) cantidad)
                    (caddr (car Lista)))
                   (cdr Lista))
             (begin
               (display "Cantidad insuficiente para vender")
               Lista)))
        (else
         (cons (car Lista)
               (venderProducto (cdr Lista) nombre cantidad)))))

(define (existenciasMinimas Lista cantidad)
  (filter (lambda (x) (<= (cadr x) cantidad))
          Lista))

;; Calcula el impuesto en la factura 
(define (calcular-impuesto-total factura umbral)
  (let ((productos-con-impuesto (filter (lambda (producto)
                                          (>= (caddr producto) umbral))
                                        factura)))
    (display "Productos con impuesto en esta factura: ")
    (display productos-con-impuesto) ; Despliega los productos con impuesto
    (newline)
    (* 0.13 (apply + (map caddr productos-con-impuesto)))))

;;calcula sin el impuesto en la respectiva factura
(define (calcular-monto-total-sin-impuesto factura)
  (apply + (map caddr factura)))

(define factura1 (list (list "arroz" 2 2000)
                       (list "frijoles" 1 1200)
                       (list "cafe" 3 2800)))

(define factura2 (list (list "azucar" 2 1100)
                       (list "leche" 9 1200)
                       (list "pan" 4 1600)
                       (list "huevos" 10 1300)))


;; Casos de prueba
(display "Caso  1:\n")
(display "Impuesto total: ")
(display (calcular-impuesto-total factura1 1500))
(newline)
(display "Monto total sin impuesto: ")
(display (calcular-monto-total-sin-impuesto factura1))
(newline)

(display "\nCaso 2:\n")
(display "Impuesto total: ")
(display (calcular-impuesto-total factura2 1000))
(newline)
(display "Monto total sin impuesto: ")
(display (calcular-monto-total-sin-impuesto factura2))
(newline)

(display "\nCaso  3 (producto sin impuesto):\n")
(display "Impuesto total: ")
(display (calcular-impuesto-total factura1 2500))
(newline)

(display "Monto total sin impuesto: ")
(display (calcular-monto-total-sin-impuesto factura1))
