open Verifier

let () =
  print_endline "Running Demonstration 2: Extreme edge case verification...";
  let file = "results/demonstration_2.json" in
  match verify_audit_file file with
  | Ok () -> print_endline "✅ demonstration_2.json passed verification."
  | Error msg -> Printf.printf "❌ demonstration_2.json failed: %s\n" msg
