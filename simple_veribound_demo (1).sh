#!/bin/bash

# Simple veribound Demo - Press Y to advance

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Simple wait function
wait_for_continue() {
    while true; do
        echo -e "${YELLOW}Continue to next step? (y/n): ${NC}"
        read -n 1 response
        echo
        if [[ $response == "y" || $response == "Y" ]]; then
            break
        elif [[ $response == "n" || $response == "N" ]]; then
            echo -e "${RED}Demo stopped by user.${NC}"
            exit 0
        else
            echo -e "${RED}Please press 'y' to continue or 'n' to quit.${NC}"
        fi
    done
    echo
}

# Clear and show step
show_step() {
    clear
    echo -e "${BOLD}${BLUE}========================================${NC}"
    echo -e "${BOLD}${BLUE}  STEP $1: $2${NC}"
    echo -e "${BOLD}${BLUE}========================================${NC}"
    echo
}

# Run command with nice formatting
run_demo() {
    echo -e "${YELLOW}► $1${NC}"
    echo -e "${GREEN}----------------------------------------${NC}"
    eval "$1"
    echo -e "${GREEN}----------------------------------------${NC}"
    echo
}

# Show file contents
show_file() {
    echo -e "${YELLOW}► Contents of $1:${NC}"
    echo -e "${GREEN}----------------------------------------${NC}"
    if [[ -f "$1" ]]; then
        cat "$1"
    else
        echo -e "${RED}File not found: $1${NC}"
    fi
    echo -e "${GREEN}----------------------------------------${NC}"
    echo
}

# START DEMO
clear
echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${BLUE}║                                                          ║${NC}"
echo -e "${BOLD}${BLUE}║                  VERIBOUND DEMO                          ║${NC}"
echo -e "${BOLD}${BLUE}║            Mathematical Verification for Finance         ║${NC}"
echo -e "${BOLD}${BLUE}║                                                          ║${NC}"
echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "${CYAN}Interactive demo of veribound's financial services capabilities${NC}"
echo
wait_for_continue

# ============================================================================
# STEP 1: Basic Verification
# ============================================================================
show_step "1" "Core Mathematical Verification"
echo -e "${CYAN}Demonstrating veribound's core verification engine:${NC}"
echo -e "• Mathematical proof generation"
echo -e "• Formal verification with cryptographic sealing"
echo -e "• Irrational signatures for tamper detection"
echo
wait_for_continue

run_demo "./demo_now"
wait_for_continue

# ============================================================================
# STEP 2: Multi-Domain Applications
# ============================================================================
show_step "2" "Multi-Domain Safety Applications"
echo -e "${CYAN}veribound handles multiple safety-critical domains:${NC}"
echo
wait_for_continue

show_file "results/veribound_output_20250713_0220.json"
wait_for_continue

echo -e "${CYAN}Formatted view:${NC}"
run_demo "python -m json.tool < results/veribound_output_20250713_0220.json"
wait_for_continue

# ============================================================================
# STEP 3: Nuclear Safety Credibility
# ============================================================================
show_step "3" "Nuclear Safety Track Record"
echo -e "${CYAN}Nuclear reactor protection system results:${NC}"
echo -e "${YELLOW}If it's safe for nuclear reactors, it's safe for banking!${NC}"
echo
wait_for_continue

run_demo "head -15 results/fixed_results.json"
wait_for_continue

# ============================================================================
# STEP 4: Basel III Setup
# ============================================================================
show_step "4" "Basel III Configuration"
echo -e "${CYAN}Creating Basel III domain configuration for demo...${NC}"
echo
wait_for_continue

echo -e "${YELLOW}Creating domain configuration...${NC}"
mkdir -p domains

cat > basel_iii_test.json << 'EOF'
{
  "exposure": 6200000,
  "capital_buffer": 10000000,
  "risk_model_version": "basel_iii_v1.0",
  "timestamp": "2025-07-15T10:00Z",
  "tier1_ratio": 6.2
}
EOF

echo -e "${GREEN}✓ Basel III test case created (6.2% Tier 1 ratio)${NC}"
wait_for_continue

# ============================================================================
# STEP 5: Financial Demo
# ============================================================================
show_step "5" "Basel III Financial Classification"
echo -e "${CYAN}Testing Basel III capital adequacy classification:${NC}"
echo -e "• 6.2% Tier 1 capital ratio"
echo -e "• Should classify as 'Adequate' (above 6.0% threshold)"
echo
wait_for_continue

run_demo "./demo_financial basel_iii_test.json"
wait_for_continue

# ============================================================================
# STEP 6: Tamper Detection
# ============================================================================
show_step "6" "Cryptographic Tamper Detection"
echo -e "${CYAN}Demonstrating tamper-proof verification:${NC}"
echo
wait_for_continue

echo -e "${YELLOW}Original vs Tampered seal hashes:${NC}"
echo -e "${GREEN}ORIGINAL:${NC}"
grep seal_hash results/veribound_output_20250713_0220.json
echo -e "${RED}TAMPERED:${NC}"
grep seal_hash results/veribound_output_tampered.json
echo
wait_for_continue

echo -e "${CYAN}Full difference analysis:${NC}"
run_demo "diff results/veribound_output_untampered_copy.json results/veribound_output_tampered.json"
wait_for_continue

# ============================================================================
# STEP 7: Edge Case Testing
# ============================================================================
show_step "7" "Edge Case and Boundary Testing"
echo -e "${CYAN}Testing with various input scenarios:${NC}"
echo
wait_for_continue

echo -e "${YELLOW}Valid input test:${NC}"
show_file "veribound-clean_demo/input_valid.json"
run_demo "./_build/default/src/verifier/verifier.exe veribound-clean_demo/input_valid.json"
wait_for_continue

echo -e "${YELLOW}Edge case test:${NC}"
show_file "veribound-clean_demo/input_edge_case.json"
run_demo "./_build/default/src/verifier/verifier.exe veribound-clean_demo/input_edge_case.json"
wait_for_continue

echo -e "${YELLOW}Tampered input test:${NC}"
show_file "veribound-clean_demo/input_tampered.json"
run_demo "./_build/default/src/verifier/verifier.exe veribound-clean_demo/input_tampered.json"
wait_for_continue

# ============================================================================
# STEP 8: Value Proposition
# ============================================================================
show_step "8" "Financial Services Value Proposition"
echo -e "${BOLD}${GREEN}veribound for Financial Services:${NC}"
echo
echo -e "🏦 ${CYAN}Regulatory Compliance${NC}"
echo -e "   • Mathematical proof beats any audit"
echo -e "   • Basel III, Dodd-Frank, CCAR ready"
echo -e "   • Tamper-proof documentation"
echo
echo -e "💰 ${CYAN}Risk & Cost Savings${NC}"
echo -e "   • Average regulatory fine: \$50M+"
echo -e "   • Eliminates classification error risk"
echo -e "   • Proven in nuclear safety applications"
echo
echo -e "⚡ ${CYAN}Production Ready${NC}"
echo -e "   • Handles 25,000+ records"
echo -e "   • Multiple output formats"
echo -e "   • Cryptographic integrity"
echo
echo -e "${BOLD}${BLUE}Bottom Line: If classification gaps are mathematically${NC}"
echo -e "${BOLD}${BLUE}impossible, you can't get fined for having them.${NC}"
echo
wait_for_continue

echo -e "${BOLD}${GREEN}🎉 DEMO COMPLETE!${NC}"
echo -e "${CYAN}Ready for questions?${NC}"
echo