(* test/working_test_dune.ml *)

open Veribound_ocaml.Veribound_hash_seal

let () =
  Printf.printf "\n🔐 VeriBound Hash Seal Test\n";
  Printf.printf "===========================\n";

  (* Generate a test sealed output *)
  let sealed = generate_test_sealed_output () in

  (* Pretty-print the sealed result *)
  Printf.printf "Generated Sealed Output:\n";
  Printf.printf "Seal: %s\n" sealed.seal_hash;
  Printf.printf "Signature: %.16f\n" sealed.irrational_signature;

  List.iter (fun r ->
    Printf.printf "{category: %s, range: %.4f–%.4f, verdict: %s}\n"
      r.category r.lower r.upper r.verdict
  ) sealed.results;

  Printf.printf "JSON Format:\n%s\n" (json_of_sealed_output sealed);

  (* Save the result to a file (ignore returned filename) *)
  save_sealed_output_to_file sealed;

  Printf.printf "\n🎉 Your hash seal is working!\n"
