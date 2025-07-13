open Veribound_hash_seal


let () =
  let test_file = "results/veribound_output_20250713_0220.json" in
  let content = In_channel.with_open_text test_file In_channel.input_all in
  let correct_seal = Veribound_hash_seal.compute_seal content in
  Printf.printf "File should have seal: %s\n" correct_seal;
  Printf.printf "This would be a VALID file if the seal matched.\n"
