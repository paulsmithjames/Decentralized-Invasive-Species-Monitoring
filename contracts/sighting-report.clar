;; Sighting Report Contract
;; Tracks locations and spread of invasive species

(define-data-var last-id uint u0)

(define-map sightings
  { id: uint }
  {
    species-id: uint,
    latitude: int,
    longitude: int,
    date: uint,
    reported-by: principal
  }
)

(define-public (report-sighting
    (species-id uint)
    (latitude int)
    (longitude int)
    (date uint)
  )
  (let
    (
      (new-id (+ (var-get last-id) u1))
    )
    (var-set last-id new-id)

    (map-set sightings
      { id: new-id }
      {
        species-id: species-id,
        latitude: latitude,
        longitude: longitude,
        date: date,
        reported-by: tx-sender
      }
    )

    (ok new-id)
  )
)

(define-read-only (get-sighting (id uint))
  (map-get? sightings { id: id })
)

