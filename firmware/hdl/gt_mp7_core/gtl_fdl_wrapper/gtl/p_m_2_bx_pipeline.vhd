--------------------------------------------------------------------------------
-- Synthesizer : ISE 13.2
-- Platform    : Linux Ubuntu 10.04
-- Targets     : Synthese
--------------------------------------------------------------------------------
-- This work is held in copyright as an unpublished work by HEPHY (Institute
-- of High Energy Physics) All rights reserved.  This work may not be used
-- except by authorized licensees of HEPHY. This work is the
-- confidential information of HEPHY.
--------------------------------------------------------------------------------
-- $HeadURL: svn://heros.hephy.at/GlobalTriggerUpgrade/firmware/gt_mp7/branches/hb_algo_2_buffer/src/gt_mp7_core/gtl_fdl_wrapper/gtl/p_m_2_bx_pipeline.vhd $
-- $Date: 2015-04-30 10:46:28 +0200 (Don, 30 Apr 2015) $
-- $Author: bergauer $
-- $Revision: 3878 $
--------------------------------------------------------------------------------

-- Version-history:
-- HB 2016-09-16: inserted new esums.

library ieee;
use ieee.std_logic_1164.all;

use work.gtl_pkg.all;

entity p_m_2_bx_pipeline is
	port(
        clk		     : in std_logic;
        muon_data    : in objects_array(0 to nr_muon_objects-1);
        muon_bx_p2  : out objects_array(0 to nr_muon_objects-1);
        muon_bx_p1  : out objects_array(0 to nr_muon_objects-1);
        muon_bx_0    : out objects_array(0 to nr_muon_objects-1);
        muon_bx_m1  : out objects_array(0 to nr_muon_objects-1);
        muon_bx_m2  : out objects_array(0 to nr_muon_objects-1);
        eg_data      : in objects_array(0 to nr_eg_objects-1);
        eg_bx_p2    : out objects_array(0 to nr_eg_objects-1);
        eg_bx_p1    : out objects_array(0 to nr_eg_objects-1);
        eg_bx_0      : out objects_array(0 to nr_eg_objects-1);
        eg_bx_m1    : out objects_array(0 to nr_eg_objects-1);
        eg_bx_m2    : out objects_array(0 to nr_eg_objects-1);
        jet_data     : in objects_array(0 to nr_jet_objects-1);
        jet_bx_p2   : out objects_array(0 to nr_jet_objects-1);
        jet_bx_p1   : out objects_array(0 to nr_jet_objects-1);
        jet_bx_0     : out objects_array(0 to nr_jet_objects-1);
        jet_bx_m1   : out objects_array(0 to nr_jet_objects-1);
        jet_bx_m2   : out objects_array(0 to nr_jet_objects-1);
        tau_data     : in objects_array(0 to nr_tau_objects-1);
        tau_bx_p2   : out objects_array(0 to nr_tau_objects-1);
        tau_bx_p1   : out objects_array(0 to nr_tau_objects-1);
        tau_bx_0     : out objects_array(0 to nr_tau_objects-1);
        tau_bx_m1   : out objects_array(0 to nr_tau_objects-1);
        tau_bx_m2   : out objects_array(0 to nr_tau_objects-1);
        ett_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        ett_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        ett_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        ett_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        ett_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        ett_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        ht_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        ht_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        ht_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        ht_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        ht_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        ht_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        etm_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        etm_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        etm_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        etm_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        etm_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        etm_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        htm_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        htm_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        htm_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        htm_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        htm_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        htm_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
-- ****************************************************************************************
-- HB 2016-04-18: updates for "min bias trigger" objects (quantities) for Low-pileup-run May 2016
        mbhfpt1_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt1_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt1_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt1_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt1_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt1_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt1_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt1_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt1_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt1_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt1_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt1_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt0_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt0_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt0_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt0_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt0_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfpt0_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt0_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt0_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt0_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt0_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt0_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        mbhfmt0_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
-- HB 2016-06-07: inserted new esums quantities (ETTEM and ETMHF).
        ettem_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        ettem_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        ettem_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        ettem_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        ettem_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        ettem_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        etmhf_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        etmhf_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        etmhf_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        etmhf_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        etmhf_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        etmhf_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
-- HB 2016-09-16: inserted HTMHF and TOWERCNT
        htmhf_data     : in std_logic_vector(max_esums_bits-1 downto 0);
        htmhf_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        htmhf_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        htmhf_bx_0     : out std_logic_vector(max_esums_bits-1 downto 0);
        htmhf_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        htmhf_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        towercount_data     : in std_logic_vector(MAX_TOWERCOUNT_BITS-1 downto 0);
        towercount_bx_p2   : out std_logic_vector(MAX_TOWERCOUNT_BITS-1 downto 0);
        towercount_bx_p1   : out std_logic_vector(MAX_TOWERCOUNT_BITS-1 downto 0);
        towercount_bx_0     : out std_logic_vector(MAX_TOWERCOUNT_BITS-1 downto 0);
        towercount_bx_m1   : out std_logic_vector(MAX_TOWERCOUNT_BITS-1 downto 0);
        towercount_bx_m2   : out std_logic_vector(MAX_TOWERCOUNT_BITS-1 downto 0);
-- HB 2018-08-06: inserted "Asymmetry" and "Centrality"
        asym0_data    : in std_logic_vector(max_esums_bits-1 downto 0);
        asym0_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym0_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym0_bx_0    : out std_logic_vector(max_esums_bits-1 downto 0);
        asym0_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym0_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym1_data    : in std_logic_vector(max_esums_bits-1 downto 0);
        asym1_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym1_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym1_bx_0    : out std_logic_vector(max_esums_bits-1 downto 0);
        asym1_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym1_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym2_data    : in std_logic_vector(max_esums_bits-1 downto 0);
        asym2_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym2_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym2_bx_0    : out std_logic_vector(max_esums_bits-1 downto 0);
        asym2_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym2_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym3_data    : in std_logic_vector(max_esums_bits-1 downto 0);
        asym3_bx_p2   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym3_bx_p1   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym3_bx_0    : out std_logic_vector(max_esums_bits-1 downto 0);
        asym3_bx_m1   : out std_logic_vector(max_esums_bits-1 downto 0);
        asym3_bx_m2   : out std_logic_vector(max_esums_bits-1 downto 0);
        cent_data    : in std_logic_vector(NR_CENTRALITY_BITS-1 downto 0);
        cent_bx_p2   : out std_logic_vector(NR_CENTRALITY_BITS-1 downto 0);
        cent_bx_p1   : out std_logic_vector(NR_CENTRALITY_BITS-1 downto 0);
        cent_bx_0    : out std_logic_vector(NR_CENTRALITY_BITS-1 downto 0);
        cent_bx_m1   : out std_logic_vector(NR_CENTRALITY_BITS-1 downto 0);
        cent_bx_m2   : out std_logic_vector(NR_CENTRALITY_BITS-1 downto 0);
-- ****************************************************************************************
        ext_cond_data     : in std_logic_vector(nr_external_conditions-1 downto 0);
        ext_cond_bx_p2   : out std_logic_vector(nr_external_conditions-1 downto 0);
        ext_cond_bx_p1   : out std_logic_vector(nr_external_conditions-1 downto 0);
        ext_cond_bx_0     : out std_logic_vector(nr_external_conditions-1 downto 0);
        ext_cond_bx_m1   : out std_logic_vector(nr_external_conditions-1 downto 0);
        ext_cond_bx_m2   : out std_logic_vector(nr_external_conditions-1 downto 0)
    );
end p_m_2_bx_pipeline;

architecture rtl of p_m_2_bx_pipeline is

    signal eg_bx_p1_tmp, eg_bx_0_tmp, eg_bx_m1_tmp, eg_bx_m2_tmp : objects_array(0 to nr_eg_objects-1) := (others => (others => '0'));
    signal jet_bx_p1_tmp, jet_bx_0_tmp, jet_bx_m1_tmp, jet_bx_m2_tmp : objects_array(0 to nr_jet_objects-1) := (others => (others => '0'));
    signal tau_bx_p1_tmp, tau_bx_0_tmp, tau_bx_m1_tmp, tau_bx_m2_tmp : objects_array(0 to nr_tau_objects-1) := (others => (others => '0'));
    signal muon_bx_p1_tmp, muon_bx_0_tmp, muon_bx_m1_tmp, muon_bx_m2_tmp : objects_array(0 to nr_muon_objects-1) := (others => (others => '0'));
    signal ett_bx_p1_tmp, ett_bx_0_tmp, ett_bx_m1_tmp, ett_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal ht_bx_p1_tmp, ht_bx_0_tmp, ht_bx_m1_tmp, ht_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal etm_bx_p1_tmp, etm_bx_0_tmp, etm_bx_m1_tmp, etm_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal htm_bx_p1_tmp, htm_bx_0_tmp, htm_bx_m1_tmp, htm_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
-- ****************************************************************************************
-- HB 2016-04-18: updates for "min bias trigger" objects (quantities) for Low-pileup-run May 2016
    signal mbhfpt1_bx_p1_tmp, mbhfpt1_bx_0_tmp, mbhfpt1_bx_m1_tmp, mbhfpt1_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal mbhfmt1_bx_p1_tmp, mbhfmt1_bx_0_tmp, mbhfmt1_bx_m1_tmp, mbhfmt1_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal mbhfpt0_bx_p1_tmp, mbhfpt0_bx_0_tmp, mbhfpt0_bx_m1_tmp, mbhfpt0_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal mbhfmt0_bx_p1_tmp, mbhfmt0_bx_0_tmp, mbhfmt0_bx_m1_tmp, mbhfmt0_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
-- HB 2016-06-07: inserted new esums quantities (ETTEM and ETMHF).
    signal ettem_bx_p1_tmp, ettem_bx_0_tmp, ettem_bx_m1_tmp, ettem_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal etmhf_bx_p1_tmp, etmhf_bx_0_tmp, etmhf_bx_m1_tmp, etmhf_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
-- HB 2016-09-16: inserted HTMHF and TOWERCNT
    signal htmhf_bx_p1_tmp, htmhf_bx_0_tmp, htmhf_bx_m1_tmp, htmhf_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal towercount_bx_p1_tmp, towercount_bx_0_tmp, towercount_bx_m1_tmp, towercount_bx_m2_tmp : std_logic_vector(MAX_TOWERCOUNT_BITS-1 downto 0) := (others => '0');
-- HB 2018-08-06: inserted "Asymmetry" and "Centrality"
    signal asym0_bx_p1_tmp, asym0_bx_0_tmp, asym0_bx_m1_tmp, asym0_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal asym1_bx_p1_tmp, asym1_bx_0_tmp, asym1_bx_m1_tmp, asym1_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal asym2_bx_p1_tmp, asym2_bx_0_tmp, asym2_bx_m1_tmp, asym2_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal asym3_bx_p1_tmp, asym3_bx_0_tmp, asym3_bx_m1_tmp, asym3_bx_m2_tmp : std_logic_vector(max_esums_bits-1 downto 0) := (others => '0');
    signal cent_bx_p1_tmp, cent_bx_0_tmp, cent_bx_m1_tmp, cent_bx_m2_tmp : std_logic_vector(NR_CENTRALITY_BITS-1 downto 0) := (others => '0');
-- ****************************************************************************************
    signal ext_cond_bx_p1_tmp, ext_cond_bx_0_tmp, ext_cond_bx_m1_tmp, ext_cond_bx_m2_tmp : std_logic_vector(nr_external_conditions-1 downto 0) := (others => '0');

begin

process(clk, eg_data, jet_data, tau_data, muon_data, ett_data, ht_data, etm_data, htm_data, ettem_data, etmhf_data, htmhf_data, towercount_data, ext_cond_data,
    asym0_data, asym1_data, asym2_data, asym3_data, cent_data)
    begin
    if (clk'event and clk = '1') then
        muon_bx_p1_tmp <= muon_data;
        muon_bx_0_tmp <= muon_bx_p1_tmp;
        muon_bx_m1_tmp <= muon_bx_0_tmp;
        muon_bx_m2_tmp <= muon_bx_m1_tmp;

        eg_bx_p1_tmp <= eg_data;
        eg_bx_0_tmp <= eg_bx_p1_tmp;
        eg_bx_m1_tmp <= eg_bx_0_tmp;
        eg_bx_m2_tmp <= eg_bx_m1_tmp;

        jet_bx_p1_tmp <= jet_data;
        jet_bx_0_tmp <= jet_bx_p1_tmp;
        jet_bx_m1_tmp <= jet_bx_0_tmp;
        jet_bx_m2_tmp <= jet_bx_m1_tmp;

        tau_bx_p1_tmp <= tau_data;
        tau_bx_0_tmp <= tau_bx_p1_tmp;
        tau_bx_m1_tmp <= tau_bx_0_tmp;
        tau_bx_m2_tmp <= tau_bx_m1_tmp;

        ett_bx_p1_tmp <= ett_data;
        ett_bx_0_tmp <= ett_bx_p1_tmp;
        ett_bx_m1_tmp <= ett_bx_0_tmp;
        ett_bx_m2_tmp <= ett_bx_m1_tmp;

        ht_bx_p1_tmp <= ht_data;
        ht_bx_0_tmp <= ht_bx_p1_tmp;
        ht_bx_m1_tmp <= ht_bx_0_tmp;
        ht_bx_m2_tmp <= ht_bx_m1_tmp;

        etm_bx_p1_tmp <= etm_data;
        etm_bx_0_tmp <= etm_bx_p1_tmp;
        etm_bx_m1_tmp <= etm_bx_0_tmp;
        etm_bx_m2_tmp <= etm_bx_m1_tmp;

        htm_bx_p1_tmp <= htm_data;
        htm_bx_0_tmp <= htm_bx_p1_tmp;
        htm_bx_m1_tmp <= htm_bx_0_tmp;
        htm_bx_m2_tmp <= htm_bx_m1_tmp;

        mbhfpt1_bx_p1_tmp <= mbhfpt1_data;
        mbhfpt1_bx_0_tmp <= mbhfpt1_bx_p1_tmp;
        mbhfpt1_bx_m1_tmp <= mbhfpt1_bx_0_tmp;
        mbhfpt1_bx_m2_tmp <= mbhfpt1_bx_m1_tmp;

        mbhfmt1_bx_p1_tmp <= mbhfmt1_data;
        mbhfmt1_bx_0_tmp <= mbhfmt1_bx_p1_tmp;
        mbhfmt1_bx_m1_tmp <= mbhfmt1_bx_0_tmp;
        mbhfmt1_bx_m2_tmp <= mbhfmt1_bx_m1_tmp;

        mbhfpt0_bx_p1_tmp <= mbhfpt0_data;
        mbhfpt0_bx_0_tmp <= mbhfpt0_bx_p1_tmp;
        mbhfpt0_bx_m1_tmp <= mbhfpt0_bx_0_tmp;
        mbhfpt0_bx_m2_tmp <= mbhfpt0_bx_m1_tmp;

        mbhfmt0_bx_p1_tmp <= mbhfmt0_data;
        mbhfmt0_bx_0_tmp <= mbhfmt0_bx_p1_tmp;
        mbhfmt0_bx_m1_tmp <= mbhfmt0_bx_0_tmp;
        mbhfmt0_bx_m2_tmp <= mbhfmt0_bx_m1_tmp;

        ettem_bx_p1_tmp <= ettem_data;
        ettem_bx_0_tmp <= ettem_bx_p1_tmp;
        ettem_bx_m1_tmp <= ettem_bx_0_tmp;
        ettem_bx_m2_tmp <= ettem_bx_m1_tmp;

        etmhf_bx_p1_tmp <= etmhf_data;
        etmhf_bx_0_tmp <= etmhf_bx_p1_tmp;
        etmhf_bx_m1_tmp <= etmhf_bx_0_tmp;
        etmhf_bx_m2_tmp <= etmhf_bx_m1_tmp;

        htmhf_bx_p1_tmp <= htmhf_data;
        htmhf_bx_0_tmp <= htmhf_bx_p1_tmp;
        htmhf_bx_m1_tmp <= htmhf_bx_0_tmp;
        htmhf_bx_m2_tmp <= htmhf_bx_m1_tmp;

        towercount_bx_p1_tmp <= towercount_data;
        towercount_bx_0_tmp <= towercount_bx_p1_tmp;
        towercount_bx_m1_tmp <= towercount_bx_0_tmp;
        towercount_bx_m2_tmp <= towercount_bx_m1_tmp;

        ext_cond_bx_p1_tmp <= ext_cond_data;
        ext_cond_bx_0_tmp <= ext_cond_bx_p1_tmp;
        ext_cond_bx_m1_tmp <= ext_cond_bx_0_tmp;
        ext_cond_bx_m2_tmp <= ext_cond_bx_m1_tmp;

        asym0_bx_p1_tmp <= asym0_data;
        asym0_bx_0_tmp <= asym0_bx_p1_tmp;
        asym0_bx_m1_tmp <= asym0_bx_0_tmp;
        asym0_bx_m2_tmp <= asym0_bx_m1_tmp;

        asym1_bx_p1_tmp <= asym1_data;
        asym1_bx_0_tmp <= asym1_bx_p1_tmp;
        asym1_bx_m1_tmp <= asym1_bx_0_tmp;
        asym1_bx_m2_tmp <= asym1_bx_m1_tmp;

        asym2_bx_p1_tmp <= asym2_data;
        asym2_bx_0_tmp <= asym2_bx_p1_tmp;
        asym2_bx_m1_tmp <= asym2_bx_0_tmp;
        asym2_bx_m2_tmp <= asym2_bx_m1_tmp;

        asym3_bx_p1_tmp <= asym3_data;
        asym3_bx_0_tmp <= asym3_bx_p1_tmp;
        asym3_bx_m1_tmp <= asym3_bx_0_tmp;
        asym3_bx_m2_tmp <= asym3_bx_m1_tmp;

        cent_bx_p1_tmp <= cent_data;
        cent_bx_0_tmp <= cent_bx_p1_tmp;
        cent_bx_m1_tmp <= cent_bx_0_tmp;
        cent_bx_m2_tmp <= cent_bx_m1_tmp;

    end if;
end process;

    muon_bx_p2 <= muon_data;
    muon_bx_p1 <= muon_bx_p1_tmp;
    muon_bx_0 <= muon_bx_0_tmp;
    muon_bx_m1 <= muon_bx_m1_tmp;
    muon_bx_m2 <= muon_bx_m2_tmp;

    eg_bx_p2 <= eg_data;
    eg_bx_p1 <= eg_bx_p1_tmp;
    eg_bx_0 <= eg_bx_0_tmp;
    eg_bx_m1 <= eg_bx_m1_tmp;
    eg_bx_m2 <= eg_bx_m2_tmp;

    jet_bx_p2 <= jet_data;
    jet_bx_p1 <= jet_bx_p1_tmp;
    jet_bx_0 <= jet_bx_0_tmp;
    jet_bx_m1 <= jet_bx_m1_tmp;
    jet_bx_m2 <= jet_bx_m2_tmp;

    tau_bx_p2 <= tau_data;
    tau_bx_p1 <= tau_bx_p1_tmp;
    tau_bx_0 <= tau_bx_0_tmp;
    tau_bx_m1 <= tau_bx_m1_tmp;
    tau_bx_m2 <= tau_bx_m2_tmp;

    ett_bx_p2 <= ett_data;
    ett_bx_p1 <= ett_bx_p1_tmp;
    ett_bx_0 <= ett_bx_0_tmp;
    ett_bx_m1 <= ett_bx_m1_tmp;
    ett_bx_m2 <= ett_bx_m2_tmp;

    ht_bx_p2 <= ht_data;
    ht_bx_p1 <= ht_bx_p1_tmp;
    ht_bx_0 <= ht_bx_0_tmp;
    ht_bx_m1 <= ht_bx_m1_tmp;
    ht_bx_m2 <= ht_bx_m2_tmp;

    etm_bx_p2 <= etm_data;
    etm_bx_p1 <= etm_bx_p1_tmp;
    etm_bx_0 <= etm_bx_0_tmp;
    etm_bx_m1 <= etm_bx_m1_tmp;
    etm_bx_m2 <= etm_bx_m2_tmp;

    htm_bx_p2 <= htm_data;
    htm_bx_p1 <= htm_bx_p1_tmp;
    htm_bx_0 <= htm_bx_0_tmp;
    htm_bx_m1 <= htm_bx_m1_tmp;
    htm_bx_m2 <= htm_bx_m2_tmp;

    mbhfpt1_bx_p2 <= mbhfpt1_data;
    mbhfpt1_bx_p1 <= mbhfpt1_bx_p1_tmp;
    mbhfpt1_bx_0 <= mbhfpt1_bx_0_tmp;
    mbhfpt1_bx_m1 <= mbhfpt1_bx_m1_tmp;
    mbhfpt1_bx_m2 <= mbhfpt1_bx_m2_tmp;

    mbhfmt1_bx_p2 <= mbhfmt1_data;
    mbhfmt1_bx_p1 <= mbhfmt1_bx_p1_tmp;
    mbhfmt1_bx_0 <= mbhfmt1_bx_0_tmp;
    mbhfmt1_bx_m1 <= mbhfmt1_bx_m1_tmp;
    mbhfmt1_bx_m2 <= mbhfmt1_bx_m2_tmp;

    mbhfpt0_bx_p2 <= mbhfpt0_data;
    mbhfpt0_bx_p1 <= mbhfpt0_bx_p1_tmp;
    mbhfpt0_bx_0 <= mbhfpt0_bx_0_tmp;
    mbhfpt0_bx_m1 <= mbhfpt0_bx_m1_tmp;
    mbhfpt0_bx_m2 <= mbhfpt0_bx_m2_tmp;

    mbhfmt0_bx_p2 <= mbhfmt0_data;
    mbhfmt0_bx_p1 <= mbhfmt0_bx_p1_tmp;
    mbhfmt0_bx_0 <= mbhfmt0_bx_0_tmp;
    mbhfmt0_bx_m1 <= mbhfmt0_bx_m1_tmp;
    mbhfmt0_bx_m2 <= mbhfmt0_bx_m2_tmp;

    ettem_bx_p2 <= ettem_data;
    ettem_bx_p1 <= ettem_bx_p1_tmp;
    ettem_bx_0 <= ettem_bx_0_tmp;
    ettem_bx_m1 <= ettem_bx_m1_tmp;
    ettem_bx_m2 <= ettem_bx_m2_tmp;

    etmhf_bx_p2 <= etmhf_data;
    etmhf_bx_p1 <= etmhf_bx_p1_tmp;
    etmhf_bx_0 <= etmhf_bx_0_tmp;
    etmhf_bx_m1 <= etmhf_bx_m1_tmp;
    etmhf_bx_m2 <= etmhf_bx_m2_tmp;

    htmhf_bx_p2 <= htmhf_data;
    htmhf_bx_p1 <= htmhf_bx_p1_tmp;
    htmhf_bx_0 <= htmhf_bx_0_tmp;
    htmhf_bx_m1 <= htmhf_bx_m1_tmp;
    htmhf_bx_m2 <= htmhf_bx_m2_tmp;

    towercount_bx_p2 <= towercount_data;
    towercount_bx_p1 <= towercount_bx_p1_tmp;
    towercount_bx_0 <= towercount_bx_0_tmp;
    towercount_bx_m1 <= towercount_bx_m1_tmp;
    towercount_bx_m2 <= towercount_bx_m2_tmp;

    ext_cond_bx_p2 <= ext_cond_data;
    ext_cond_bx_p1 <= ext_cond_bx_p1_tmp;
    ext_cond_bx_0 <= ext_cond_bx_0_tmp;
    ext_cond_bx_m1 <= ext_cond_bx_m1_tmp;
    ext_cond_bx_m2 <= ext_cond_bx_m2_tmp;

    asym0_bx_p2 <= asym0_data;
    asym0_bx_p1 <= asym0_bx_p1_tmp;
    asym0_bx_0 <= asym0_bx_0_tmp;
    asym0_bx_m1 <= asym0_bx_m1_tmp;
    asym0_bx_m2 <= asym0_bx_m2_tmp;

    asym1_bx_p2 <= asym1_data;
    asym1_bx_p1 <= asym1_bx_p1_tmp;
    asym1_bx_0 <= asym1_bx_0_tmp;
    asym1_bx_m1 <= asym1_bx_m1_tmp;
    asym1_bx_m2 <= asym1_bx_m2_tmp;

    asym2_bx_p2 <= asym2_data;
    asym2_bx_p1 <= asym2_bx_p1_tmp;
    asym2_bx_0 <= asym2_bx_0_tmp;
    asym2_bx_m1 <= asym2_bx_m1_tmp;
    asym2_bx_m2 <= asym2_bx_m2_tmp;

    asym3_bx_p2 <= asym3_data;
    asym3_bx_p1 <= asym3_bx_p1_tmp;
    asym3_bx_0 <= asym3_bx_0_tmp;
    asym3_bx_m1 <= asym3_bx_m1_tmp;
    asym3_bx_m2 <= asym3_bx_m2_tmp;

    cent_bx_p2 <= cent_data;
    cent_bx_p1 <= cent_bx_p1_tmp;
    cent_bx_0 <= cent_bx_0_tmp;
    cent_bx_m1 <= cent_bx_m1_tmp;
    cent_bx_m2 <= cent_bx_m2_tmp;

end architecture rtl;
