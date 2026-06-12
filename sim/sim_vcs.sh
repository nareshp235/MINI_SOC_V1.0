#!/bin/bash

#===============================================================================
# Mini SoC Verification Project
#
# File Name  : sim_vcs.sh
#
# Description:
#   Compile and run Mini SoC simulations using Synopsys VCS.
#
# Author      : Naresh
# Created On  : 12-Jun-2026
#
#===============================================================================

set -e

echo
echo "=================================================="
echo " Mini SoC Verification - VCS Flow"
echo "=================================================="
echo

ROOT_DIR=$(dirname $(dirname $(realpath $0)))

cd $ROOT_DIR

#------------------------------------------------------------------------------
# Clean Previous Run
#------------------------------------------------------------------------------

echo "[INFO] Cleaning old simulation files..."

rm -rf simv*
rm -rf csrc
rm -rf ucli.key
rm -rf *.log
rm -rf *.vpd
rm -rf DVEfiles

echo

#------------------------------------------------------------------------------
# Compile
#------------------------------------------------------------------------------

echo "[INFO] Compiling design and testbench..."

vcs -full64 \
    -sverilog \
    -debug_access+all \
    -kdb \
    -timescale=1ns/1ps \
    -f sim/run.f \
    -l compile.log

echo

#------------------------------------------------------------------------------
# Run Simulation
#------------------------------------------------------------------------------

echo "[INFO] Running simulation..."

./simv \
    -l sim.log

echo

#------------------------------------------------------------------------------
# Summary
#------------------------------------------------------------------------------

echo "=================================================="
echo " Simulation Completed"
echo "=================================================="

echo
echo "Compile Log : compile.log"
echo "Run Log     : sim.log"
echo
