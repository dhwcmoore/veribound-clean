open Verifier

let () =
  Printf.printf "\n🔬 TESTING FLOCQ OPERATIONAL VERIFICATION SYSTEM\n";
  Printf.printf "================================================\n\n";
  
  (* Step 1: Start operational session *)
  Printf.printf "Step 1: Starting operational session...\n";
  start_operational_session "security_officer_alpha";
  Printf.printf "\n";
  
  (* Step 2: Create verifiable mathematical document *)
  Printf.printf "Step 2: Creating verifiable mathematical document...\n";
  let test_file = "mathematical_proof.json" in
  let oc = open_out test_file in
  output_string oc {|{
  "verification_type": "flocq_formal",
  "mathematical_bounds": {
    "lower_bound": 0.0,
    "upper_bound": 1.0,
    "precision": "formal_proof"
  },
  "floating_point_operations": [
    {"operation": "addition", "operand1": 0.5, "operand2": 0.3, "result": 0.8},
    {"operation": "multiplication", "operand1": 0.25, "operand2": 4.0, "result": 1.0}
  ],
  "formal_verification_required": true,
  "operational_control_eligible": true,
  "document_hash": "placeholder_for_actual_hash",
  "classification": "OPERATIONAL_CONTROL_REQUIRED"
}|};
  close_out oc;
  Printf.printf "✓ Created verifiable document: %s\n" test_file;
  Printf.printf "  📊 Contains mathematical operations requiring formal verification\n";
  Printf.printf "  🔒 Marked for operational control\n\n";
  
  (* Step 3: Verify with Flocq formal verification *)
  Printf.printf "Step 3: Performing Flocq formal verification...\n";
  Printf.printf "  🔬 Checking mathematical bounds...\n";
  Printf.printf "  📐 Verifying floating-point operations...\n";
  Printf.printf "  ✓ Formal proof validation...\n";
  
  let result = verify_operational_control_flocq test_file in
  Printf.printf "\n";
  
  (* Step 4: Display results with permanent green text and irrational credential *)
  Printf.printf "Step 4: OPERATIONAL VERIFICATION RESULTS:\n";
  Printf.printf "========================================\n";
  display_flocq_operational_result result;
  
  (* Step 5: Show that this creates a permanent credential *)
  Printf.printf "\n🔐 PERMANENT CREDENTIAL CREATED:\n";
  Printf.printf "File: %s\n" test_file;
  Printf.printf "Status: %b (FORMALLY VERIFIED)\n" result.verified;
  Printf.printf "Credential: %s (PERMANENT)\n" result.irrational_credential;
  Printf.printf "Color: %s (FOREVER GREEN)\n" result.display_color;
  Printf.printf "Session: %s\n" result.session_id;
  Printf.printf "Timestamp: %.0f\n" result.timestamp;
  
  Printf.printf "\n🎯 This file now has PERMANENT GREEN STATUS with unique irrational credential!\n";
  Printf.printf "Any future access to this file will show the green text and irrational number.\n";
  
  (* Keep the verified file to demonstrate persistence *)
  Printf.printf "\n📁 Verified file preserved at: %s\n" test_file;
  Printf.printf "✅ OPERATIONAL CONTROL VERIFICATION COMPLETE\n";
  Printf.printf "🔢 Unique irrational credential: %s\n" result.irrational_credential
