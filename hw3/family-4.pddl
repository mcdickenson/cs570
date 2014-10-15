(define (problem family-3)
  (:domain family-domain)
  (:objects p1 p2 p3 p4 p5)
  (:init (female p1) (male p2) (not-yet-born p3) (not-yet-born p4) (not-yet-born p5))
  (:goal (and (is-granduncle-or-grandaunt-of p3 p3) (male p3))))

