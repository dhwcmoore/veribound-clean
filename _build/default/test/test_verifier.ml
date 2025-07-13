open Verifier

let () =
  let test_file = "results/veribound_output_20250713_0220.json" in
  let (_ok, msg) = verify_seal_from_file test_file in
  Printf.printf "Verification result for %s:\n%s\n" test_file msg
