open Verifier

let () =
  print_endline "Running Demonstration 1: Verifying typical financial service audit cases...";

  let (result, message) =
    verify_seal_from_file "data/test_sealed_valid.json"
  in

  if result then
    Printf.printf "✅ Passed: %s\n" message
  else
    Printf.printf "❌ Failed: %s\n" message
