//==============================================================================
// Project      : Mini SoC Verification Project
//
// File Name    : apb_if.sv
//
// Description  : APB3 interface definition used by APB masters,
//                APB slaves, monitors and assertions.
//
// Author       : Naresh
//
// Created On   : 12-Jun-2026
//
// Dependencies : None
//
// Specifications:
//      - APB_IF_SPEC_v1.0
//      - MINI_SOC_SPEC_v1.0
//
// Revision History:
//------------------------------------------------------------------------------
// Version    Date          Author        Description
//------------------------------------------------------------------------------
// 1.0        12-Jun-2026   Naresh        Initial version
//==============================================================================

`timescale 1ns/1ps

interface apb_if
#(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)
(
    input logic pclk,
    input logic presetn
);

    //--------------------------------------------------------------------------
    // APB Control Signals
    //--------------------------------------------------------------------------

    logic                     psel;
    logic                     penable;
    logic                     pwrite;

    //--------------------------------------------------------------------------
    // APB Address/Data Signals
    //--------------------------------------------------------------------------

    logic [ADDR_WIDTH-1:0]    paddr;
    logic [DATA_WIDTH-1:0]    pwdata;

    logic [DATA_WIDTH-1:0]    prdata;

    //--------------------------------------------------------------------------
    // APB Response Signals
    //--------------------------------------------------------------------------

    logic                     pready;
    logic                     pslverr;

    //--------------------------------------------------------------------------
    // Master Modport
    //--------------------------------------------------------------------------

    modport master
    (
        input  pclk,
        input  presetn,

        output psel,
        output penable,
        output pwrite,

        output paddr,
        output pwdata,

        input  prdata,
        input  pready,
        input  pslverr
    );

    //--------------------------------------------------------------------------
    // Slave Modport
    //--------------------------------------------------------------------------

    modport slave
    (
        input  pclk,
        input  presetn,

        input  psel,
        input  penable,
        input  pwrite,

        input  paddr,
        input  pwdata,

        output prdata,
        output pready,
        output pslverr
    );

    //--------------------------------------------------------------------------
    // Monitor Modport
    //--------------------------------------------------------------------------

    modport monitor
    (
        input pclk,
        input presetn,

        input psel,
        input penable,
        input pwrite,

        input paddr,
        input pwdata,

        input prdata,
        input pready,
        input pslverr
    );

endinterface : apb_if

//==============================================================================
// End of File
//==============================================================================
