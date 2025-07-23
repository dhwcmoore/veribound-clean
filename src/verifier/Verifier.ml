open Yojson.Basic.Util

let verify_seal_from_file filename =
  try
    let json = Yojson.Basic.from_file filename in

    (* Extract expected seal hash and results *)
    let embedded_hash = json |> member "seal_hash" |> to_string in
    let irrational_signature = json |> member "irrational_signature" |> to_float in

    (* Get the 'results' field as a JSON string and hash it *)
    let results_json = json |> member "results" in
    let results_text = Yojson.Basic.to_string results_json in
    let computed_hash = Digestif.SHA256.digest_string results_text |> Digestif.SHA256.to_hex in

    if embedded_hash = computed_hash then
      (true, Printf.sprintf "✅ Verified successfully.\nHash: %s\nIrrational signature: %.16f"
        embedded_hash irrational_signature)
    else
      (false, Printf.sprintf "❌ Failed: Seal mismatch.\nExpected: %s\nComputed: %s\nIrrational signature: %.16f"
        embedded_hash computed_hash irrational_signature)
  with
  | Yojson.Json_error _ ->
      (false, "Error reading or parsing JSON input.")
  | _ ->
      (false, "Unexpected verification failure.")
