//==============================================================================
// Project      : Mini SoC Verification Project
//
// File Name    : apb_master_bfm.sv
//
// Description  : APB Master Bus Functional Model.
//                Provides APB reset, write and read tasks.
//
// Author       : Naresh
//
// Created On   : 12-Jun-2026
//
// Dependencies :
//      apb_if.sv
//      params_pkg.sv
//
// Specifications:
//      - APB_IF_SPEC_v1.0
//      - VERIFICATION_ARCHITECTURE_v1.0
//
// Revision History:
//------------------------------------------------------------------------------
// Version    Date          Author        Description
//------------------------------------------------------------------------------
// 1.0        12-Jun-2026   Naresh        Initial version
//==============================================================================

`timescale 1ns/1ps

class apb_master_bfm;

    import params_pkg::*;

    //----------------------------------------------------------------------
    // Virtual Interface Handle
    //----------------------------------------------------------------------

    virtual apb_if.master vif;

    //----------------------------------------------------------------------
    // Constructor
    //----------------------------------------------------------------------

    function new(virtual apb_if.master vif);
        this.vif = vif;
    endfunction

    //----------------------------------------------------------------------
    // APB Bus Initialization
    //----------------------------------------------------------------------

    task init();

        vif.psel    <= 1'b0;
        vif.penable <= 1'b0;
        vif.pwrite  <= 1'b0;

        vif.paddr   <= '0;
        vif.pwdata  <= '0;

    endtask

    //----------------------------------------------------------------------
    // APB Write
    //----------------------------------------------------------------------

    task apb_write
    (
        input logic [31:0] addr,
        input logic [31:0] data
    );

        // SETUP Phase

        @(posedge vif.pclk);

        vif.psel    <= 1'b1;
        vif.penable <= 1'b0;
        vif.pwrite  <= 1'b1;

        vif.paddr   <= addr;
        vif.pwdata  <= data;

        // ACCESS Phase

        @(posedge vif.pclk);

        vif.penable <= 1'b1;

        // Wait for completion

        wait(vif.pready == 1'b1);

        @(posedge vif.pclk);

        // Return to IDLE

        vif.psel    <= 1'b0;
        vif.penable <= 1'b0;
        vif.pwrite  <= 1'b0;

        vif.paddr   <= '0;
        vif.pwdata  <= '0;

    endtask

    //----------------------------------------------------------------------
    // APB Read
    //----------------------------------------------------------------------

    task apb_read
    (
        input  logic [31:0] addr,
        output logic [31:0] data
    );

        // SETUP Phase

        @(posedge vif.pclk);

        vif.psel    <= 1'b1;
        vif.penable <= 1'b0;
        vif.pwrite  <= 1'b0;

        vif.paddr   <= addr;

        // ACCESS Phase

        @(posedge vif.pclk);

        vif.penable <= 1'b1;

        // Wait for completion

        wait(vif.pready == 1'b1);

        data = vif.prdata;

        @(posedge vif.pclk);

        // Return to IDLE

        vif.psel    <= 1'b0;
        vif.penable <= 1'b0;

        vif.paddr   <= '0;

    endtask

endclass : apb_master_bfm

//==============================================================================
// End of File
//==============================================================================
