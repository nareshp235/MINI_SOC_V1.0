//==============================================================================
// Project      : Mini SoC Verification Project
//
// File Name    : gpio_apb.sv
//
// Description  : APB based GPIO peripheral.
//                Implements control, configuration,
//                status and interrupt registers.
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

module gpio_apb
(
    apb_if.slave apb,

    input  logic [7:0] gpio_in,
    output logic [7:0] gpio_out,

    output logic       gpio_irq
);

    import params_pkg::*;

    //--------------------------------------------------------------------------
    // Registers
    //--------------------------------------------------------------------------

    logic [31:0] gpio_ctrl_reg;
    logic [31:0] gpio_dir_reg;
    logic [31:0] gpio_data_out_reg;
    logic [31:0] gpio_status_reg;

    logic [7:0]  gpio_in_d;

    //--------------------------------------------------------------------------
    // APB Ready
    //--------------------------------------------------------------------------

    assign apb.pready = 1'b1;

    //--------------------------------------------------------------------------
    // GPIO Output Logic
    //--------------------------------------------------------------------------

    assign gpio_out = gpio_data_out_reg[7:0];

    //--------------------------------------------------------------------------
    // Interrupt Generation
    //--------------------------------------------------------------------------

    assign gpio_irq =
            gpio_ctrl_reg[1] &&
            gpio_status_reg[0];

    //--------------------------------------------------------------------------
    // Register Write Logic
    //--------------------------------------------------------------------------

    always_ff @(posedge apb.pclk)
    begin

        if (!apb.presetn)
        begin
            gpio_ctrl_reg     <= 32'h0;
            gpio_dir_reg      <= 32'h0;
            gpio_data_out_reg <= 32'h0;
            gpio_status_reg   <= 32'h0;

            gpio_in_d         <= 8'h00;
        end
        else
        begin

            //------------------------------------------------------------------
            // Save Previous GPIO Input
            //------------------------------------------------------------------

            gpio_in_d <= gpio_in;

            //------------------------------------------------------------------
            // Interrupt Detection
            //------------------------------------------------------------------

            if (gpio_in != gpio_in_d)
                gpio_status_reg[0] <= 1'b1;

            //------------------------------------------------------------------
            // APB Write
            //------------------------------------------------------------------

            if ( apb.psel     &&
                 apb.penable  &&
                 apb.pwrite )
            begin

                case (apb.paddr)

                    GPIO_CTRL_OFFSET :
                        gpio_ctrl_reg <= apb.pwdata;

                    GPIO_DIR_OFFSET :
                        gpio_dir_reg <= apb.pwdata;

                    GPIO_DATA_OUT_OFFSET :
                        gpio_data_out_reg <= apb.pwdata;

                    GPIO_STATUS_OFFSET :
                    begin
                        // RW1C

                        if (apb.pwdata[0])
                            gpio_status_reg[0] <= 1'b0;
                    end

                    default :
                    begin
                        // Do nothing
                    end

                endcase

            end

        end

    end

    //--------------------------------------------------------------------------
    // Read Logic
    //--------------------------------------------------------------------------

    always_comb
    begin

        apb.prdata  = 32'h0;
        apb.pslverr = 1'b0;

        if (apb.psel)
        begin

            case (apb.paddr)

                GPIO_CTRL_OFFSET :
                    apb.prdata = gpio_ctrl_reg;

                GPIO_DIR_OFFSET :
                    apb.prdata = gpio_dir_reg;

                GPIO_DATA_OUT_OFFSET :
                    apb.prdata = gpio_data_out_reg;

                GPIO_DATA_IN_OFFSET :
                    apb.prdata = {24'h0, gpio_in};

                GPIO_STATUS_OFFSET :
                    apb.prdata = gpio_status_reg;

                default :
                begin
                    apb.prdata  = 32'h0;
                    apb.pslverr = 1'b1;
                end

            endcase

        end

    end

endmodule : gpio_apb

//==============================================================================
// End of File
//==============================================================================
