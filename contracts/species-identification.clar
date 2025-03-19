;; Species Identification Contract
;; Records details of invasive plants and animals

(define-data-var last-id uint u0)

(define-map species
  { id: uint }
  {
    name: (string-utf8 100),
    type: (string-utf8 20),
    risk-level: uint,
    registered-by: principal
  }
)

(define-public (register-species
    (name (string-utf8 100))
    (type (string-utf8 20))
    (risk-level uint)
  )
  (let
    (
      (new-id (+ (var-get last-id) u1))
    )
    (var-set last-id new-id)

    (map-set species
      { id: new-id }
      {
        name: name,
        type: type,
        risk-level: risk-level,
        registered-by: tx-sender
      }
    )

    (ok new-id)
  )
)

(define-read-only (get-species (id uint))
  (map-get? species { id: id })
)

