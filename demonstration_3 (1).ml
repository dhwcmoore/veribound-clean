open Verifier

let () =
  print_endline "Running Demonstration 3: Testing known limits of VeriBound...";
  let file = "results/demonstration_3.json" in
  match verify_audit_file file with
  | Ok () -> print_endline "✅ demonstration_3.json passed verification."
  | Error msg -> Printf.printf "❌ demonstration_3.json failed: %s\n" msg
