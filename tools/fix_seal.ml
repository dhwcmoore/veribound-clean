(* fix_seal.ml: Recompute seal_hash based on results field *)


open Yojson.Basic.Util

let compute_sha256 text =
  Digestif.SHA256.(to_hex (digest_string text))

let () =
  let input_file = Sys.argv.(1) in
  let json = Yojson.Basic.from_file input_file in
  let results = json |> member "results" in
  let results_string = Yojson.Basic.to_string results in
  let new_hash = compute_sha256 results_string in
  let corrected_json =
    `Assoc [
      "seal_hash", `String new_hash;
      "irrational_signature", json |> member "irrational_signature";
      "results", results
    ]
  in
  print_endline (Yojson.Basic.pretty_to_string corrected_json)
