type result_entry = {
  category : string;
  lower : float;
  upper : float;
  verdict : string;
}

val compute_seal : string -> string
val verify_file : string -> bool
