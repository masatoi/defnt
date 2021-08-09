(defsystem "defnt"
  :class :package-inferred-system
  :depends-on ("defnt/main")
  :in-order-to ((test-op (test-op "defnt/test"))))

(defsystem "defnt/test"
  :class :package-inferred-system
  :depends-on ("rove" "defnt/test")
  :perform (test-op (o c) (symbol-call :rove '#:run c)))
