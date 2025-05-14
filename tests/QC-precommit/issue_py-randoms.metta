;; Randomly sample an index, to be (almost) sure that every node has a
;; unique ID.
(: random-index (-> Number))
(= (random-index) (random-int &rng 0 1000000))

;; Test random-index
!(pragma! py-random True) ;; already the default unless python=disable
!(set-random-seed &rng 0)
!(random-index)
!(set-random-seed &rng 0)
!(assertEqual (random-index) 731113)


