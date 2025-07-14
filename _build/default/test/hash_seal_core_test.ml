open Veribound_hash_seal

let () =
  let sample_json = `Assoc [("key", `String "value")] in
  let seal = compute_seal sample_json in
  Printf.printf "✅ Seal: %s\n" seal
