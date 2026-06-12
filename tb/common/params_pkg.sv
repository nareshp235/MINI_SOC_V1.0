//==============================================================================
// Project      : Mini SoC Verification Project
//
// File Name    : params_pkg.sv
//
// Description  : Global project package containing:
//                - Bus widths
//                - Address map
//                - Register offsets
//                - Project constants
//
// Author       : Naresh
//
// Created On   : 12-Jun-2026
//
// Dependencies : None
//
// Specifications:
//      - MINI_SOC_SPEC_v1.0
//      - RAS_v1.0
//
// Revision History:
//------------------------------------------------------------------------------
// Version    Date          Author        Description
//------------------------------------------------------------------------------
// 1.0        12-Jun-2026   Naresh        Initial version
//==============================================================================

`timescale 1ns/1ps

package params_pkg;

    //--------------------------------------------------------------------------
    // Global Bus Parameters
    //--------------------------------------------------------------------------

    parameter int APB_ADDR_WIDTH = 32;
    parameter int APB_DATA_WIDTH = 32;

    parameter int AXI_ADDR_WIDTH = 32;
    parameter int AXI_DATA_WIDTH = 32;

    //--------------------------------------------------------------------------
    // Address Map
    //--------------------------------------------------------------------------

    parameter logic [31:0] GPIO_BASE_ADDR  = 32'h0000_0000;
    parameter logic [31:0] TIMER_BASE_ADDR = 32'h0000_1000;
    parameter logic [31:0] DMA_BASE_ADDR   = 32'h0000_2000;

    //--------------------------------------------------------------------------
    // GPIO Register Offsets
    //--------------------------------------------------------------------------

    parameter logic [31:0] GPIO_CTRL_OFFSET     = 32'h0000;
    parameter logic [31:0] GPIO_DIR_OFFSET      = 32'h0004;
    parameter logic [31:0] GPIO_DATA_OUT_OFFSET = 32'h0008;
    parameter logic [31:0] GPIO_DATA_IN_OFFSET  = 32'h000C;
    parameter logic [31:0] GPIO_STATUS_OFFSET   = 32'h0010;

    //--------------------------------------------------------------------------
    // TIMER Register Offsets
    //--------------------------------------------------------------------------

    parameter logic [31:0] TIMER_CTRL_OFFSET   = 32'h0000;
    parameter logic [31:0] TIMER_LOAD_OFFSET   = 32'h0004;
    parameter logic [31:0] TIMER_COUNT_OFFSET  = 32'h0008;
    parameter logic [31:0] TIMER_STATUS_OFFSET = 32'h000C;

    //--------------------------------------------------------------------------
    // DMA Register Offsets
    //--------------------------------------------------------------------------

    parameter logic [31:0] DMA_CTRL_OFFSET     = 32'h0000;
    parameter logic [31:0] DMA_SRC_OFFSET      = 32'h0004;
    parameter logic [31:0] DMA_DST_OFFSET      = 32'h0008;
    parameter logic [31:0] DMA_SIZE_OFFSET     = 32'h000C;
    parameter logic [31:0] DMA_STATUS_OFFSET   = 32'h0010;

endpackage : params_pkg

//==============================================================================
// End of File
//==============================================================================
