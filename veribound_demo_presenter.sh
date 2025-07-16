#!/bin/bash

# veribound Interactive Demo Presenter
# Press SPACE to advance through each demo step

# Colors for better presentation
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Function to wait for spacebar
wait_for_space() {
    echo -e "${YELLOW}Press SPACE to continue...${NC}"
    while true; do
        read -n 1 -s key
        if [[ $key == " " ]]; then
            break
        fi
    done
    echo
}

# Function to show step header
show_step() {
    clear
    echo -e "${BOLD}${BLUE}============================================${NC}"
    echo -e "${BOLD}${BLUE}  VERIBOUND DEMONSTRATION - STEP $1${NC}"
    echo -e "${BOLD}${BLUE}============================================${NC}"
    echo -e "${CYAN}$2${NC}"
    echo
}

# Function to run command and show output
run_demo() {
    echo -e "${YELLOW}Running: $1${NC}"
    echo -e "${GREEN}----------------------------------------${NC}"
    eval "$1"
    echo -e "${GREEN}----------------------------------------${NC}"
    echo
}

# Function to show file contents
show_file() {
    echo -e "${YELLOW}Content of $1:${NC}"
    echo -e "${GREEN}----------------------------------------${NC}"
    if [[ -f "$1" ]]; then
        cat "$1"
    else
        echo -e "${RED}File not found: $1${NC}"
    fi
    echo -e "${GREEN}----------------------------------------${NC}"
    echo
}

# Start the demo
clear
echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${BLUE}║                                                                              ║${NC}"
echo -e "${BOLD}${BLUE}║                         VERIBOUND DEMONSTRATION                              ║${NC}"
echo -e "${BOLD}${BLUE}║                   Mathematical Verification for Finance                      ║${NC}"
echo -e "${BOLD}${BLUE}║                                                                              ║${NC}"
echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "${CYAN}This interactive demo will showcase veribound's capabilities${NC}"
echo -e "${CYAN}for financial services and regulatory compliance.${NC}"
echo
echo -e "${YELLOW}Each step will wait for you to press SPACE before continuing.${NC}"
echo
wait_for_space

# ============================================================================
# STEP 1: Core Verification Demo
# ============================================================================
show_step "1/8" "Core Mathematical Verification"
echo -e "This demonstrates veribound's fundamental verification capabilities:"
echo -e "• Mathematical proof generation"
echo -e "• Formal verification with Rocq"
echo -e "• Cryptographic sealing"
echo
wait_for_space

run_demo "./demo_now"
wait_for_space

# ============================================================================
# STEP 2: Multi-Domain Safety Verification
# ============================================================================
show_step "2/8" "Multi-Domain Safety Verification"
echo -e "veribound already handles multiple safety-critical domains:"
echo -e "• EPA environmental compliance"
echo -e "• FDA safety verification"
echo -e "• Nuclear reactor protection"
echo
wait_for_space

show_file "results/veribound_output_20250713_0220.json"
wait_for_space

echo -e "${CYAN}Parsing JSON for better readability:${NC}"
run_demo "cat results/veribound_output_20250713_0220.json | python -m json.tool"
wait_for_space

# ============================================================================
# STEP 3: Nuclear Safety Credibility
# ============================================================================
show_step "3/8" "Nuclear Safety Application"
echo -e "If it's safe enough for nuclear reactors, it's safe enough for banking:"
echo -e "• Critical safety classifications"
echo -e "• Multiple validation levels"
echo -e "• Cryptographic integrity"
echo
wait_for_space

show_file "results/fixed_results.json"
wait_for_space

# ============================================================================
# STEP 4: Create Basel III Demo Files
# ============================================================================
show_step "4/8" "Basel III Configuration Setup"
echo -e "Creating Basel III capital adequacy domain configuration:"
echo -e "• Tier 1 capital ratio boundaries"
echo -e "• Regulatory action requirements"
echo -e "• Federal Reserve compliance"
echo
wait_for_space

echo -e "${YELLOW}Creating Basel III domain configuration...${NC}"
mkdir -p domains

cat > domains/basel_iii_capital_adequacy.yaml << 'EOF'
domain: basel_iii_capital_adequacy
boundaries:
  - category: "Below_Minimum_CRITICAL"
    lower: 0.0
    upper: 4.5
    action: "immediate_correction_required"
  - category: "Conservation_Buffer_WATCH"
    lower: 4.5
    upper: 6.0
    action: "enhanced_monitoring"
  - category: "Adequate_SAFE"
    lower: 6.0
    upper: 8.0
    action: "normal_operations"
  - category: "Well_Capitalized_EXCELLENT"
    lower: 8.0
    upper: 100.0
    action: "normal_operations"
verification_level: 3
regulator: "Federal_Reserve"
EOF

cat > basel_iii_capital_adequacy.json << 'EOF'
{
  "input": "6.2",
  "domain": "domains/basel_iii_capital_adequacy.yaml",
  "classification_test": "tier1_capital_ratio",
  "bank_identifier": "DEMO_BANK_001",
  "current_ratio": 6.2,
  "stress_multiplier": 1.5,
  "regulatory_threshold": "tier1_minimum",
  "timestamp": "2025-07-15T10:00Z"
}
EOF

echo -e "${GREEN}✓ Basel III domain configuration created${NC}"
echo -e "${GREEN}✓ Test case with 6.2% Tier 1 capital ratio (Adequate)${NC}"
echo
wait_for_space

# ============================================================================
# STEP 5: Financial Services Demo
# ============================================================================
show_step "5/8" "Basel III Financial Services Demo"
echo -e "Running Basel III capital adequacy classification:"
echo -e "• Bank with 6.2% Tier 1 capital ratio"
echo -e "• Should classify as 'Adequate_SAFE'"
echo -e "• Requires normal operations monitoring"
echo
wait_for_space

run_demo "./demo_financial basel_iii_capital_adequacy.json"
wait_for_space

# ============================================================================
# STEP 6: Tamper Detection
# ============================================================================
show_step "6/8" "Cryptographic Tamper Detection"
echo -e "Demonstrating tamper-proof audit trails:"
echo -e "• Cryptographic seal hashes"
echo -e "• Immediate tamper detection"
echo -e "• Regulatory audit compliance"
echo
wait_for_space

echo -e "${CYAN}Original vs Tampered Results:${NC}"
echo -e "${YELLOW}ORIGINAL SEAL HASH:${NC}"
grep seal_hash results/veribound_output_20250713_0220.json
echo
echo -e "${YELLOW}TAMPERED SEAL HASH:${NC}"
grep seal_hash results/veribound_output_tampered.json
echo
wait_for_space

echo -e "${CYAN}Full Comparison:${NC}"
run_demo "diff results/veribound_output_untampered_copy.json results/veribound_output_tampered.json"
wait_for_space

# ============================================================================
# STEP 7: Edge Case Testing
# ============================================================================
show_step "7/8" "Edge Case and Boundary Testing"
echo -e "Testing boundary conditions and edge cases:"
echo -e "• Values near classification boundaries"
echo -e "• Precision handling"
echo -e "• Comprehensive logging"
echo
wait_for_space

echo -e "${CYAN}Testing with different input values:${NC}"
run_demo "./_build/default/src/verifier/verifier.exe veribound-clean_demo/input_valid.json"
echo
run_demo "./_build/default/src/verifier/verifier.exe veribound-clean_demo/input_edge_case.json"
echo
run_demo "./_build/default/src/verifier/verifier.exe veribound-clean_demo/input_tampered.json"
echo
wait_for_space

if [[ -f "input_edge_case_verification_log.json" ]]; then
    show_file "input_edge_case_verification_log.json"
    wait_for_space
fi

# ============================================================================
# STEP 8: Summary and Value Proposition
# ============================================================================
show_step "8/8" "Value Proposition Summary"
echo -e "${BOLD}${GREEN}veribound for Financial Services:${NC}"
echo
echo -e "🏦 ${CYAN}Regulatory Compliance:${NC}"
echo -e "   • Mathematical proof satisfies any examiner"
echo -e "   • Basel III, Dodd-Frank, CCAR compliance"
echo -e "   • Tamper-proof audit trails"
echo
echo -e "💰 ${CYAN}Risk Elimination:${NC}"
echo -e "   • Average regulatory fine: \$50M+"
echo -e "   • veribound eliminates classification error risk"
echo -e "   • Proven in nuclear safety applications"
echo
echo -e "⚡ ${CYAN}Production Ready:${NC}"
echo -e "   • Scales to 25,000+ subjects"
echo -e "   • Multiple output formats (JSON, HTML, PNG)"
echo -e "   • Cryptographic integrity verification"
echo
echo -e "🎯 ${CYAN}Market Opportunity:${NC}"
echo -e "   • Every major bank needs Basel III compliance"
echo -e "   • Risk management systems require mathematical certainty"
echo -e "   • Regulatory technology market: \$100B+"
echo
echo -e "${BOLD}${BLUE}If it's mathematically impossible to have classification gaps,${NC}"
echo -e "${BOLD}${BLUE}you can't get fined for having them.${NC}"
echo
wait_for_space

echo -e "${BOLD}${GREEN}Demo Complete!${NC}"
echo -e "${CYAN}Thank you for watching the veribound demonstration.${NC}"
echo -e "${CYAN}Questions?${NC}"
echo