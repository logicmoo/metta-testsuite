;; Initialize a gensym counter with a given prefix
(= (init-gensym $prefix)
  (add-atom &self (gensym-counter $prefix 0)))  ;; Start the counter at 0

;; Generate a unique name using the gensym counter
(= (gensym $prefix)
    ;; Retrieve the current counter value
    (unify &self (gensym-counter $prefix $n)
      (sequential
        ;; Increment the counter
        (remove-atom &self (gensym-counter $prefix $n))
        (let $new-n (+ $n 1)
          (add-atom &self (gensym-counter $prefix $new-n))
          ;; Return the unique name
          (format-args "{}{}" ($prefix $n))))
      ;; If the prefix is not initialized, throw an error
      (Error $prefix "Gensym counter not initialized")))

;; Create a new hashmap with a unique name
(= (make-hashmap)
  (let $hm (gensym "hashmap_")
    (add-atom &self (: $hm hashmap))
     $hm))  ;; Return the unique hashmap name

!(init-gensym "hashmap_")

;; Add or update a key-value pair in the hashmap
(= (put-in-hashmap $hm $key $value)
  (if (== () (collapse (match &self (: $hm hashmap) t)))
      (Error $hm "Hashmap does not exist")
      (sequential
        (remove-atom &self (hashmap-entry $hm $key $_))  ;; Remove existing entry for the key
        (add-atom &self  (hashmap-entry $hm $key $value)))))  ;; Add the new key-value pair

;; Retrieve a value by key from the hashmap
(= (get-from-hashmap $hm $key)
  (if (== () (collapse (match &self (: $hm hashmap) t)))
      (Error $hm "Hashmap does not exist")
      (let
        (unify &self
          (hashmap-entry $hm $key $value)
          $value
          (Error ($hm $key) "Key not found")))))

;; Remove a key-value pair from the hashmap
(= (remove-from-hashmap $hm $key)
  (if (== () (collapse (match &self (: $hm hashmap) t)))
      (Error $hm "Hashmap does not exist")
      (remove-atom &self (hashmap-entry $hm $key $_))))

;; Delete an entire hashmap and all its entries
(= (delete-hashmap $hm)
  (sequential
    (remove-atom &self (: $hm hashmap))  ;; Remove the hashmap instance
	(remove-atom &self (superpose (collapse  
	  (match &self (hashmap-entry $hm $key $value) (hashmap-entry $hm $key $value)))))  ;; Remove all key-value pairs

;; List all key-value pairs in a hashmap
(= (list-hashmap-entries $hm)
  (if (== () (collapse (match &self (: $hm hashmap) t)))
      (Error $hm "Hashmap does not exist")
      (collapse (match &self (hashmap-entry $hm $key $value) (:kv $key $value)))))

;; Example Usage
!(sequential
 (let $hm (make-hashmap)  ;; Create a new hashmap
  (sequential 
	(put-in-hashmap $hm name Douglas)  ;; Add a key-value pair
	(put-in-hashmap $hm age 42)  ;; Add another pair
	(get-from-hashmap $hm name)  ;; Retrieve a value
	(list-hashmap-entries $hm)  ;; List all key-value pairs
	(remove-from-hashmap $hm name)  ;; Remove a specific key
	(delete-hashmap $hm))))  ;; Delete the entire hashmap

(= (make-symbol $str) (parse $str))



;; Benchmarking script for hashmap implementation

;; Function to generate a large number of string keys
(= (generate-string-keys $prefix $count)
  (sequential
    (map-range 0 $count (lambda $i
      (format-args "{}{}" ($prefix $i))))))

;; Function to generate a large number of symbol keys
(= (generate-symbol-keys $prefix $count)
  (sequential
    (map-range 0 $count (lambda $i
      (make-symbol (format-args "{}{}" ($prefix $i)))))))
  (sequential
    (map-range 0 $count (lambda $i
      (gensym $prefix)))))

;; Function to generate a large number of compound keys
(= (generate-compound-keys $symbol $prefix $count)
  (sequential
    (map-range 0 $count (lambda $i
      ($symbol (make-symbol (format-args "{}{}" ($prefix $i))))))))
  (sequential
    (map-range 0 $count (lambda $i
      ($symbol (format-args "{}{}" ($prefix $i)))))))

;; Map Range function implementation
(= (map-range $start $end $fn)
  (if (>= $start $end)
      ()  ;; Return empty list if start is greater than or equal to end
      (sequential
        ($fn $start)  ;; Apply function to the current value
        (map-range (+ $start 1) $end $fn))))  ;; Recur with incremented start

;; Benchmark hashmap operations for given keys
(= (benchmark-hashmap $hm $keys)
  (sequential
    ;; Add keys to the hashmap
    (map-range 0 (length $keys) (lambda $i
      (let $key (nth $i $keys)
        (put-in-hashmap $hm $key (format-args "value{}" ($i))))))

    ;; Retrieve all keys from the hashmap
    (map-range 0 (length $keys) (lambda $i
      (let $key (nth $i $keys)
        (get-from-hashmap $hm $key))))

    ;; Remove all keys from the hashmap
    (map-range 0 (length $keys) (lambda $i
      (let $key (nth $i $keys)
        (remove-from-hashmap $hm $key))))))

;; Run benchmarks for different key types
(= (run-benchmarks $count)
  (sequential
    ;; Initialize hashmap
    (let $hm (make-hashmap)
      ;; Test with string keys
      (let $string-keys (generate-string-keys "str_" $count)
        (benchmark-hashmap $hm $string-keys))

      ;; Test with symbol keys
      (let $symbol-keys (generate-symbol-keys "sym_" $count)
        (benchmark-hashmap $hm $symbol-keys))

      ;; Test with compound keys
      (let $compound-keys (generate-compound-keys 'comp_key "comp_" $count)
        (benchmark-hashmap $hm $compound-keys)))))

;; Run the script with a large number of keys for benchmarking
!(run-benchmarks 10000)

