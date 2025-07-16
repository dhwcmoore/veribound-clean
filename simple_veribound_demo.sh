#!/bin/bash

# Simple veribound Demo - Press ENTER to advance

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Simple wait function
wait_for_enter() {
    echo -e "${YELLOW}Press ENTER to continue...${NC}"
    read
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
wait_for_enter

# ============================================================================
# STEP 1: Basic Verification
# ============================================================================
show_step "1" "Core Mathematical Verification"
echo -e "${CYAN}Demonstrating veribound's core verification engine:${NC}"
echo -e "• Mathematical proof generation"
echo -e "• Formal verification with cryptographic sealing"
echo -e "• Irrational signatures for tamper detection"
echo
wait_for_enter

run_demo "./demo_now"
wait_for_enter

# ============================================================================
# STEP 2: Multi-Domain Applications
# ============================================================================
show_step "2" "Multi-Domain Safety Applications"
echo -e "${CYAN}veribound handles multiple safety-critical domains:${NC}"
echo
wait_for_enter

show_file "results/veribound_output_20250713_0220.json"
wait_for_enter

echo -e "${CYAN}Formatted view:${NC}"
run_demo "python -m json.tool < results/veribound_output_20250713_0220.json"
wait_for_enter

# ============================================================================
# STEP 3: Nuclear Safety Credibility
# ============================