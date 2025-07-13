(* veribound_hash_seal.ml - Working implementation with digestif *)

open Digestif.SHA256

type classification_result = {
  category : string;
  lower : float;
  upper : float;
  verdict : string;
}

type sealed_output = {
  results : classification_result list;
  seal_hash : string;
  irrational_signature : float;
}

let string_of_result (r : classification_result) : string =
  Printf.sprintf "{category: %s, range: %.4f–%.4f, verdict: %s}"
    r.category r.lower r.upper r.verdict

let hash_result (results : classification_result list) : string =
  let combined = String.concat ";" (List.map string_of_result results) in
  digest_string combined |> to_hex

let irrational_from_hash (hash : string) : float =
  let len = min (String.length hash) 12 in
  if len = 0 then 0.0 else
  let hex_part = String.sub hash 0 len in
  let int_value = Int64.of_string_opt ("0x" ^ hex_part) |> Option.value ~default:1L in
  Int64.to_float int_value /. Int64.to_float 0xFFFFFFFFFFFFL

let generate_sealed_output (results : classification_result list) : sealed_output =
  let seal_hash = hash_result results in
  let irrational_signature = irrational_from_hash seal_hash in
  { results; seal_hash; irrational_signature }

let string_of_sealed_output (s : sealed_output) : string =
  Printf.sprintf "Seal: %s\nSignature: %.16f\nResults:\n%s"
    s.seal_hash
    s.irrational_signature
    (String.concat "\n" (List.map string_of_result s.results))

let json_of_sealed_output (s : sealed_output) : string =
  let result_to_json r =
    Printf.sprintf
      {|{"category":"%s","lower":%.4f,"upper":%.4f,"verdict":"%s"}|}
      r.category r.lower r.upper r.verdict
  in
  let results_json = "[" ^ (String.concat "," (List.map result_to_json s.results)) ^ "]" in
  Printf.sprintf
    {|{"seal_hash":"%s","irrational_signature":%.16f,"results":%s}|}
    s.seal_hash s.irrational_signature results_json
open Unix

let save_sealed_output_to_file ?(dir = "results") (s : sealed_output) : unit =
  (* Ensure the output directory exists *)
  if not (Sys.file_exists dir) then begin
    Printf.printf "📁 Creating directory: %s\n%!" dir;
    Unix.mkdir dir 0o755
  end;

  (* Format timestamp *)
  let tm = Unix.localtime (Unix.time ()) in
  let timestamp =
    Printf.sprintf "%04d%02d%02d_%02d%02d"
      (tm.tm_year + 1900) (tm.tm_mon + 1) tm.tm_mday tm.tm_hour tm.tm_min
  in

  (* Create filename *)
  let filename = Printf.sprintf "%s/veribound_output_%s.json" dir timestamp in

  (* Convert to JSON and save *)
  let json = json_of_sealed_output s in
  let oc = open_out filename in
  Printf.fprintf oc "%s\n" json;
  close_out oc;

  Printf.printf "✅ Exported sealed output to: %s\n%!" filename
let generate_test_sealed_output () : sealed_output =
  let test_results = [
    {
      category = "EPA_TEST";
      lower = 0.25;
      upper = 0.75;
      verdict = "COMPLIANT";
    };
    {
      category = "FDA_TEST";
      lower = 0.80;
      upper = 1.00;
      verdict = "SAFE";
    }
  ] in
  generate_sealed_output test_results
