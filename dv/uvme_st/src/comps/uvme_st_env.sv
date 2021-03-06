// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVME_ST_ENV_SV__
`define __UVME_ST_ENV_SV__


/**
 * Top-level component that encapsulates, builds and connects all other Moore.io UVM Extension Library environment
 * components.
 */
class uvme_st_env_c extends uvml_env_c;
   
   // Objects
   uvme_st_cfg_c    cfg  ; ///< 
   uvme_st_cntxt_c  cntxt; ///< 
   
   // Agents
   uvma_st_agent_c  tx_agent; ///< 
   uvma_st_agent_c  rx_agent; ///< 
   
   // Components
   uvme_st_cov_model_c                cov_model ; ///< 
   uvme_st_prd_c                      predictor ; ///< 
   uvme_st_sb_c                       sb        ; ///< 
   uvme_st_vsqr_c                     vsequencer; ///< 
   uvml_delay_c #(uvma_st_mon_trn_c)  delay     ; ///< 
   
   
   `uvm_component_utils_begin(uvme_st_env_c)
      `uvm_field_object(cfg  , UVM_DEFAULT)
      `uvm_field_object(cntxt, UVM_DEFAULT)
   `uvm_component_utils_end
   
   
   /**
    * Default constructor.
    */
   extern function new(string name="uvme_st_env", uvm_component parent=null);
   
   /**
    * 1. Ensures cfg & cntxt handles are not null
    * 2. Retrieves cntxt.clk_vif from UVM configuration database via retrieve_clk_vif()
    * 3. Assigns cfg and cntxt handles via assign_cfg() & assign_cntxt()
    * 4. Builds all components via create_<x>()
    */
   extern virtual function void build_phase(uvm_phase phase);
   
   /**
    * 1. Connects agents to predictor via connect_predictor()
    * 2. Connects predictor & agents to scoreboard via connect_scoreboard()
    * 3. Assembles virtual sequencer handles via assemble_vsequencer()
    * 4. Connects agents to coverage model via connect_coverage_model()
    */
   extern virtual function void connect_phase(uvm_phase phase);
   
   /**
    * Assigns configuration handles to components using UVM Configuration Database.
    */
   extern function void assign_cfg();
   
   /**
    * Assigns context handles to components using UVM Configuration Database.
    */
   extern function void assign_cntxt();
   
   /**
    * Creates agent components.
    */
   extern function void create_agents();
   
   /**
    * Creates additional (non-agent) environment components (and objects).
    */
   extern function void create_env_components();
   
   /**
    * Creates environment's virtual sequencer.
    */
   extern function void create_vsequencer();
   
   /**
    * Creates environment's coverage model.
    */
   extern function void create_cov_model();
   
   /**
    * Connects agents to predictor.
    */
   extern function void connect_predictor();
   
   /**
    * Connects scoreboards components to agents/predictor.
    */
   extern function void connect_scoreboard();
   
   /**
    * Assembles virtual sequencer from agent sequencers.
    */
   extern function void assemble_vsequencer();
   
   /**
    * Connects environment coverage model to agents/scoreboards/predictor.
    */
   extern function void connect_coverage_model();
   
endclass : uvme_st_env_c


function uvme_st_env_c::new(string name="uvme_st_env", uvm_component parent=null);
   
   super.new(name, parent);
   
endfunction : new


function void uvme_st_env_c::build_phase(uvm_phase phase);
   
   super.build_phase(phase);
   
   void'(uvm_config_db#(uvme_st_cfg_c)::get(this, "", "cfg", cfg));
   if (!cfg) begin
      `uvm_fatal("CFG", "Configuration handle is null")
   end
   else begin
      `uvm_info("CFG", $sformatf("Found configuration handle:\n%s", cfg.sprint()), UVM_DEBUG)
   end
   
   if (cfg.enabled) begin
      void'(uvm_config_db#(uvme_st_cntxt_c)::get(this, "", "cntxt", cntxt));
      if (!cntxt) begin
         `uvm_info("CNTXT", "Context handle is null; creating.", UVM_DEBUG)
         cntxt = uvme_st_cntxt_c::type_id::create("cntxt");
      end
      
      assign_cfg           ();
      assign_cntxt         ();
      create_agents        ();
      create_env_components();
      
      if (cfg.is_active) begin
         create_vsequencer();
      end
      
      if (cfg.cov_model_enabled) begin
         create_cov_model();
      end
   end
   
endfunction : build_phase


function void uvme_st_env_c::connect_phase(uvm_phase phase);
   
   super.connect_phase(phase);
   
   if (cfg.enabled) begin
      if (cfg.scoreboarding_enabled) begin
         connect_predictor ();
         connect_scoreboard();
      end
      
      if (cfg.is_active) begin
         assemble_vsequencer();
      end
      
      if (cfg.cov_model_enabled) begin
         connect_coverage_model();
      end
   end
   
endfunction: connect_phase


function void uvme_st_env_c::assign_cfg();
   
   uvm_config_db#(uvme_st_cfg_c)::set(this, "*"       , "cfg", cfg       );
   uvm_config_db#(uvma_st_cfg_c)::set(this, "tx_agent", "cfg", cfg.tx_cfg);
   uvm_config_db#(uvma_st_cfg_c)::set(this, "rx_agent", "cfg", cfg.rx_cfg);
   
endfunction: assign_cfg


function void uvme_st_env_c::assign_cntxt();
   
   uvm_config_db#(uvme_st_cntxt_c)::set(this, "*"       , "cntxt", cntxt         );
   uvm_config_db#(uvma_st_cntxt_c)::set(this, "tx_agent", "cntxt", cntxt.tx_cntxt);
   uvm_config_db#(uvma_st_cntxt_c)::set(this, "rx_agent", "cntxt", cntxt.rx_cntxt);
   
endfunction: assign_cntxt


function void uvme_st_env_c::create_agents();
   
   tx_agent = uvma_st_agent_c::type_id::create("tx_agent", this);
   rx_agent = uvma_st_agent_c::type_id::create("rx_agent", this);
   
endfunction: create_agents


function void uvme_st_env_c::create_env_components();
   
   if (cfg.scoreboarding_enabled) begin
      predictor = uvme_st_prd_c                    ::type_id::create("predictor", this);
      sb        = uvme_st_sb_c                     ::type_id::create("sb"       , this);
      delay     = uvml_delay_c #(uvma_st_mon_trn_c)::type_id::create("delay"    , this);
   end
   
endfunction: create_env_components


function void uvme_st_env_c::create_vsequencer();
   
   vsequencer = uvme_st_vsqr_c::type_id::create("vsequencer", this);
   
endfunction: create_vsequencer


function void uvme_st_env_c::create_cov_model();
   
   cov_model = uvme_st_cov_model_c::type_id::create("cov_model", this);
   
endfunction: create_cov_model


function void uvme_st_env_c::connect_predictor();
   
   // Connect agent -> predictor
   tx_agent.mon_ap.connect(predictor.in_export);
   
endfunction: connect_predictor


function void uvme_st_env_c::connect_scoreboard();
   
   // Connect agent -> scoreboard
   delay.set_duration(100);
   delay.out_ap   .connect(sb   .act_export);
   rx_agent.mon_ap.connect(delay.in_export );
   
   // Connect predictor -> scoreboard
   predictor.out_ap.connect(sb.exp_export);
   
endfunction: connect_scoreboard


function void uvme_st_env_c::assemble_vsequencer();
   
   vsequencer.tx_sequencer = tx_agent.sequencer;
   
endfunction: assemble_vsequencer


function void uvme_st_env_c::connect_coverage_model();
   
   tx_agent.drv_ap.connect(cov_model.tx_seq_item_export);
   tx_agent.mon_ap.connect(cov_model.tx_mon_trn_export );
   rx_agent.mon_ap.connect(cov_model.rx_mon_trn_export );
   
endfunction: connect_coverage_model


`endif // __UVME_ST_ENV_SV__
