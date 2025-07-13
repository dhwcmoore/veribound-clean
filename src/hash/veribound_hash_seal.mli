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

val string_of_result : classification_result -> string
val string_of_sealed_output : sealed_output -> string
val json_of_sealed_output : sealed_output -> string
val generate_sealed_output : classification_result list -> sealed_output
val save_sealed_output_to_file : ?dir:string -> sealed_output -> unit
val generate_test_sealed_output : unit -> sealed_output
