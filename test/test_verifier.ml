(* test/test_verifier.ml *)

let () =
  let filename =
    if Array.length Sys.argv > 1 then Sys.argv.(1)
    else (
      prerr_endline "❌ Error: Please provide a JSON file to verify.";
      exit 1
    )
  in
  let (ok, msg) = Verifier.verify_seal_from_file filename in
  Printf.printf "Verification result for %s:\n%s\n" filename msg
