(* src/verifier/verifier_exec.ml *)

open Yojson.Basic.Util
open Veribound_hash_seal
open Verifier
open Irrational_seal

let verify_seal_from_file (filename : string) : (bool * string) =
  let json = Yojson.Basic.from_file filename in
  let seal_hash = json |> member "seal_hash" |> to_string in
  let signature = json |> member "irrational_signature" |> to_float in
  let results_json = json |> member "results" |> to_list in

  let results : result_entry list = List.map (fun item ->
    {
      category = item |> member "category" |> to_string;
      lower = item |> member "lower" |> to_float;
      upper = item |> member "upper" |> to_float;
      verdict = item |> member "verdict" |> to_string;
    }
  ) results_json in

  let summary = Printf.sprintf
    "Seal: %s\nSignature: %.16f\nEntries: %d"
    seal_hash signature (List.length results)
  in

  let is_valid = Veribound_hash_seal.verify_file filename in
  (is_valid, summary ^ "\nVerification: " ^ (if is_valid then "✅ VALID" else "❌ TAMPERED"))

let () =
  print_endline "✅ verifier_exec ran!";
  (* Optionally test a file here *)
  (* let (ok, report) = verify_seal_from_file "some_file.json" in
     print_endline report *)
