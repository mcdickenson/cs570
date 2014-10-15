(define (problem family-1)
  (:domain family-domain)
  (:objects p1 p2 p3)
  (:init (female p1) (male p2) (not-yet-born p3)) 
  (:goal (and (is-child-of p3 p1) (female p3))))

