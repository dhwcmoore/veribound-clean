open Irrational_seal

let () =
  let sample_json_string = {|{"results": [{"category": "test", "lower": 1.0, "upper": 2.0, "verdict": "pass"}]}|} in
  let seal = compute_seal sample_json_string in
  Printf.printf "✅ Seal: %s\n" seal
