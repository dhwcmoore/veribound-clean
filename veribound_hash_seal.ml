let compute_seal (json : Yojson.Safe.t) : string =
  let raw = Yojson.Safe.to_string json in
  Digestif.SHA256.digest_string raw |> Digestif.SHA256.to_hex
