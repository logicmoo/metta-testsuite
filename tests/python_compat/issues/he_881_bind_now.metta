
(import! &self py_ops)


!(bind! now (py-atom datetime.datetime.now))
(= (A) (now))
(= (B) (now))
!(- (A) (B))


