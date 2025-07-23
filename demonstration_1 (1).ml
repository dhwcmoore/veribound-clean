let () =
  print_endline "Running Demonstration 1: Seal Verification Test";

  let (result, message) =
    Verifier.verify_seal_from_file "data/test_sealed_valid.json"
  in

  if result then
    Printf.printf "✅ Passed: %s\n" message
  else
    Printf.printf "❌ Failed: %s\n" message
