-- Description:
-- Calculation of invariant mass or transverse mass based on LUTs.

-- Version history:
-- HB 2018-11-26: First design.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.math_pkg.all;

-- used for CONV_STD_LOGIC_VECTOR
use ieee.std_logic_arith.all;

use work.gtl_pkg.all;

entity delta_r is
    generic(
        CONF : dr_conf
    );
    port(
        clk : in std_logic;
        diff_eta : in integer_2dim_array(0 to CONF.N_OBJ_1-1, 0 to CONF.N_OBJ_2-1);
        diff_phi : in integer_2dim_array(0 to CONF.N_OBJ_1-1, 0 to CONF.N_OBJ_2-1);
        dr_squared_o : out std_logic_3dim_array(0 to CONF.N_OBJ_1-1, 0 to CONF.N_OBJ_2-1, (2*CONF.DIFF_WIDTH)-1 downto 0)
    );
end delta_r;

architecture rtl of delta_r is

    signal diff_eta_squared : integer_2dim_array(0 to CONF.N_OBJ_1-1, 0 to CONF.N_OBJ_2-1);
    signal diff_phi_squared : integer_2dim_array(0 to CONF.N_OBJ_1-1, 0 to CONF.N_OBJ_2-1);
    type diff_sq_i_array is array (CONF.N_OBJ_1-1 downto 0, CONF.N_OBJ_2-1 downto 0) of std_logic_vector((2*CONF.DIFF_WIDTH)-1 downto 0);
    signal dr_squared_i : diff_sq_i_array := (others => (others => (others => '0')));
    type delta_r_o_array is array (CONF.N_OBJ_1-1 downto 0, CONF.N_OBJ_2-1 downto 0, (2*CONF.DIFF_WIDTH)-1 downto 0) of std_logic_vector(0 downto 0);
    signal dr_squared : delta_r_o_array := (others => (others => (others => "0")));
    signal dr_squared_r : delta_r_o_array := (others => (others => (others => "0")));
    
-- HB 2017-09-21: used "attribute use_dsp" instead of "use_dsp48" for "dr_squared" - see warning below
-- MP7 builds, synth_1, runme.log => WARNING: [Synth 8-5974] attribute "use_dsp48" has been deprecated, please use "use_dsp" instead
    attribute use_dsp : string;
    attribute use_dsp of diff_eta_squared : signal is "yes";
    attribute use_dsp of diff_phi_squared : signal is "yes";
    attribute use_dsp of dr_squared : signal is "yes";

begin

    l_1: for i in 0 to CONF.N_OBJ_1-1 generate
        l_2: for j in 0 to CONF.N_OBJ_2-1 generate
-- HB 2015-11-26: calculation of ΔR**2 with formular ΔR**2 = (eta1-eta2)**2+(phi1-phi2)**2
            diff_eta_squared(i,j) <= diff_eta(i,j)*diff_eta(i,j);
            diff_phi_squared(i,j) <= diff_phi(i,j)*diff_phi(i,j);
            dr_squared_i(i,j) <= CONV_STD_LOGIC_VECTOR((diff_eta_squared(i,j)+diff_phi_squared(i,j)), 2*CONF.DIFF_WIDTH);
            l_4: for l in 0 to (2*CONF.DIFF_WIDTH)-1 generate
                dr_squared(i,j,l)(0) <= dr_squared_i(i,j)(l);                 
                out_reg_i : entity work.out_reg_mux
                    generic map(1, CONF.OUT_REG) 
                    port map(clk, dr_squared(i,j,l), dr_squared_r(i,j,l)); 
                dr_squared_o(i,j,l) <= dr_squared_r(i,j,l)(0);
            end generate l_4;
        end generate l_2;
    end generate l_1;
        
end architecture rtl;
