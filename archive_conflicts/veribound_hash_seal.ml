open Yojson.Basic.Util


type result_entry = {
  category : string;
  lower : float;
  upper : float;
  verdict : string;
}

let compute_seal json_content =
  let json = Yojson.Basic.from_string json_content in
  let results_json = json |> member "results" |> to_list in
  let results_text = Yojson.Basic.pretty_to_string (`List results_json) in
  let hash = Digestif.SHA256.digest_string results_text in
  Digestif.SHA256.to_hex hash

let verify_file filename =
  let content = In_channel.with_open_text filename In_channel.input_all in
  let json = Yojson.Basic.from_string content in
  let stored_seal = json |> member "seal_hash" |> to_string in
  let computed_seal = compute_seal content in
  let result = String.equal computed_seal stored_seal in
  Printf.printf "🔍 Checking seal integrity...\n";
  Printf.printf "Expected: %s\n" stored_seal;
  Printf.printf "Computed: %s\n" computed_seal;
  Printf.printf "Status:   %s\n" (if result then "✅ VALID" else "❌ TAMPERED");
  result
