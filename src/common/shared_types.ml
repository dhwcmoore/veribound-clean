(* Shared Types - Common types across engines *)

(* Configuration types that work across engines *)
type raw_boundary = {
  lower_str: string; (* "5.6" or "5" - parsed by each engine *)
  upper_str: string;
  category: string;
}

type raw_domain = {
  name: string;
  unit_name: string;  (* Fixed: was 'unit' which is reserved *)
  description: string option;
  boundaries: raw_boundary list;
  global_bounds_str: string * string;
}

(* Common boundary and domain types for engines *)
type boundary = {
  lower: float;
  upper: float;
  category: string;
}

type domain = {
  name : string;
  unit_name : string;
  description : string;
  boundaries : boundary list;
  global_bounds : float * float;
}

let test_domain = {
  name = "Test AQI";
  unit_name = "AQI";
  description = "Air Quality Index test domain";
  boundaries = [
    { lower = 0.0; upper = 50.0; category = "Good" };
    { lower = 51.0; upper = 100.0; category = "Moderate" };
  ];
  global_bounds = (0.0, 100.0);
}

(* Output types for unified CLI *)
type classification_result = {
  input_value: string;
  category: string; 
  confidence: [`High | `Medium | `Low];
  boundary_distance: float;
  engine_used: string;
  precision_info: string;
  timestamp: float;
}

type output_format = [`Text | `JSON | `Detailed]

(* Error types for consistent error handling *)
type veribound_error = 
  | ParseError of string
  | ClassificationError of string 
  | EngineError of string * string (* engine_name, error_msg *)
  | ConfigError of string

(* Safe parsing function *)
let safe_parse_value (s : string) : float =
  try float_of_string (String.trim s)
  with Failure _ -> failwith ("Cannot parse float value: " ^ s)
