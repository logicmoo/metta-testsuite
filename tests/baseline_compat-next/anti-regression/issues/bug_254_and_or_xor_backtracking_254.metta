; OR tests
!(assertEqualToResult (or (superpose (True False)) (superpose (True False))) (True True True False))
!(assertEqualToResult (or True (superpose (True False))) (True True))
!(assertEqualToResult (or True True) (True))
!(assertEqualToResult (or (superpose (True False)) (superpose (False False))) (False False True True))
!(assertEqualToResult (or (superpose (False False)) (superpose (True False))) (False True False True))
!(assertEqualToResult (or (superpose (False False)) (superpose (False False))) (False False False False))
!(assertEqualToResult (or False (superpose (True False))) (True False))
!(assertEqualToResult (or (superpose (True False True)) False) (True False True))

; XOR tests
!(assertEqualToResult (xor True False) (True))
!(assertEqualToResult (xor True True) (False))
!(assertEqualToResult (xor False False) (False))
!(assertEqualToResult (xor (superpose (True False True)) (superpose (True True False))) (True False False False True True True False False))

; NOT tests
!(assertEqualToResult (not True) (False))
!(assertEqualToResult (not False) (True))
!(assertEqualToResult (not (superpose (True False True False))) (False True False True))

; AND tests
!(assertEqualToResult (and True True) (True))
!(assertEqualToResult (and True False) (False))
!(assertEqualToResult (and False False) (False))
!(assertEqualToResult (and (superpose (True False True)) (superpose (True True False))) (False True True False False False False True True))

