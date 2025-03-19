;; Treatment Verification Contract
;; Monitors eradication and control efforts

(define-data-var last-id uint u0)

(define-map treatments
  { id: uint }
  {
    sighting-id: uint,
    method: (string-utf8 100),
    date: uint,
    success-rate: uint,
    performed-by: principal
  }
)

(define-public (record-treatment
    (sighting-id uint)
    (method (string-utf8 100))
    (date uint)
    (success-rate uint)
  )
  (let
    (
      (new-id (+ (var-get last-id) u1))
    )
    (var-set last-id new-id)

    (map-set treatments
      { id: new-id }
      {
        sighting-id: sighting-id,
        method: method,
        date: date,
        success-rate: success-rate,
        performed-by: tx-sender
      }
    )

    (ok new-id)
  )
)

(define-read-only (get-treatment (id uint))
  (map-get? treatments { id: id })
)

