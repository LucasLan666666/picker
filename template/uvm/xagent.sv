//==============================================================================//
// File       : {{className}}_xagent.sv
// Author     : automatically generated by picker
// Date       : {{datenow}}
// Description: This is a template generated by picker. use this,you can  achieve 
//              communication between UVM and Python.
// Version    : {{version}}
//==============================================================================//


class {{className}}_xmonitor extends uvm_monitor;
    `uvm_component_utils({{className}}_xmonitor)
    uvm_tlm_b_initiator_socket #()     out;
    byte unsigned                      transport_tr[];
    byte unsigned                      transport_queue[];
    uvm_tlm_gp                         transport_msg;
    uvm_tlm_time                       delay;
    int                                remaining_bits;
    logic[7:0]                         myByte;
    bit                                exist_xmonitor;
    {{className}}                      tr;

    function new(string name, uvm_component parent=null);
        super.new(name,parent);
        if(exist_xmonitor) begin
            uvm_config_db#(bit)::get(this,"","{{className}}_exist_xmonitor",exist_xmonitor);
            out = new("out",this);
        end
        
        transport_msg = new;
        delay = new("del",1e-12);
        myByte = 8'b00000000;
    endfunction

    
    virtual task run_phase(uvm_phase phase);
        while(1) begin
            tr = new("tr");
            sequence_send(tr);
            send_tr(tr);    
        end
    endtask


    virtual task sequence_send({{className}} tr);

    endtask

    task send_tr({{className}} {{className}}item);
        //initial item
        transport_tr = {};
        {% set counter =  0 -%}
        {%for data in variables -%}
        {%if data.nums == 1 -%}
        {% set counter = counter + 1 -%}
        transport_tr = {transport_tr,{{className}}item.{{data.name}}};
        
        {%else -%}
        {%if data.macro == 1 -%}
        remaining_bits = {{data.macro_name}} % 8;
        if(remaining_bits != 0) begin
            myByte = 8'b00000000; 
            for(int i = 0;i<remaining_bits;i++)begin
                myByte[remaining_bits -i-1] = {{className}}item.{{data.name}}[{{data.macro_name}}-1-i];
            end
            transport_tr = {transport_tr,myByte};
        end
        
        for(int i = 0;i < {{data.macro_name}}/8;i++) begin
            transport_tr = {transport_tr,{{className}}item.{{data.name}}[({{data.macro_name}} - 1 - remaining_bits -i*8)-:8]};
        {% set counter = counter + 1 -%}
        end        
        {%else -%}
        remaining_bits = {{data.bit_count}} % 8;
        if(remaining_bits != 0) begin
            myByte = 8'b00000000; 
            for(int i = 0;i<remaining_bits;i++)begin
                myByte[remaining_bits -i-1] = {{className}}item.{{data.name}}[{{data.bit_count}}-1-i];
            end
            transport_tr = {transport_tr,myByte};
        end
        
        for(int i = 0;i < {{data.bit_count}}/8;i++) begin
            transport_tr = {transport_tr,{{className}}item.{{data.name}}[({{data.bit_count}} - 1 - remaining_bits -i*8)-:8]};
        {% set counter = counter + 1 -%}
        end
        {%endif -%}
        {%endif -%}
        {%endfor -%}
        transport_msg.set_data_length(transport_tr.size());
        transport_msg.set_data(transport_tr);
        delay.set_abstime(0,1e-9);
        if(exist_xmonitor) begin
            out.b_transport(transport_msg,delay);
        end

    endtask

    task send_transaction({{className}} {{className}}item, logic is_last);
        transport_tr = {};
        {% set counter =  0 -%}
        {%for data in variables -%}
        {%if data.nums == 1 -%}
        {% set counter = counter + 1 -%}
        transport_tr = {transport_tr,{{className}}item.{{data.name}}};
        
        {%else -%}
        {%if data.macro == 1 -%}
        remaining_bits = {{data.macro_name}} % 8;
        if(remaining_bits != 0) begin
            myByte = 8'b00000000; 
            for(int i = 0;i<remaining_bits;i++)begin
                myByte[remaining_bits -i-1] = {{className}}item.{{data.name}}[{{data.macro_name}}-1-i];
            end
            transport_tr = {transport_tr,myByte};
        end
        
        for(int i = 0;i < {{data.macro_name}}/8;i++) begin
            transport_tr = {transport_tr,{{className}}item.{{data.name}}[({{data.macro_name}} - 1 - remaining_bits -i*8)-:8]};
        {% set counter = counter + 1 -%}
        end        
        {%else -%}
        remaining_bits = {{data.bit_count}} % 8;
        if(remaining_bits != 0) begin
            myByte = 8'b00000000; 
            for(int i = 0;i<remaining_bits;i++)begin
                myByte[remaining_bits -i-1] = {{className}}item.{{data.name}}[{{data.bit_count}}-1-i];
            end
            transport_tr = {transport_tr,myByte};
        end
        
        for(int i = 0;i < {{data.bit_count}}/8;i++) begin
            transport_tr = {transport_tr,{{className}}item.{{data.name}}[({{data.bit_count}} - 1 - remaining_bits -i*8)-:8]};
        {% set counter = counter + 1 -%}
        end
        {%endif -%}
        {%endif -%}
        {%endfor -%}
        send_msg(transport_tr, is_last);

    endtask

    task send_msg(byte unsigned tr[], logic is_last);
        for(int i = 0; i < tr.size(); i++)begin
            transport_queue = {transport_queue,tr[i]};
        end
        if(is_last) begin
            transport_msg.set_data_length(transport_queue.size());
            transport_msg.set_data(transport_queue);
            out.b_transport(transport_msg,delay);
            transport_queue = {};
        end
    endtask

endclass
    
    
class {{className}}_xdriver extends uvm_driver;
    `uvm_component_utils({{className}}_xdriver) 
    uvm_tlm_gp                         transport_msg;
    uvm_tlm_time                       delay;
    byte unsigned                      transport_tr[];
    bit                                exist_xdriver;
    uvm_tlm_b_target_socket #({{className}}_xdriver)        in;
    {{className}} tr;

    function new(string name, uvm_component parent=null);
        super.new(name,parent);
        if(!uvm_config_db#(bit)::get(this,"","{{className}}_exist_xdriver",exist_xdriver)) begin
            `uvm_fatal("CFGERR", "Could not get monitor or driver type")
        end
        if(exist_xdriver) begin
            in = new("in",this);
        end
        
        transport_msg = new("transport_msg");
        delay = new("del",1e-12);
    endfunction
        

    virtual task b_transport(uvm_tlm_gp t,uvm_tlm_time delay);
        tr = new("tr");
        t.get_data(transport_tr);
        {% set counter =  0 -%}
        {%for data in variables -%}
        {%if data.nums == 1 -%}
        tr.{{data.name}} = transport_tr[{{counter}}];
        {% set counter = counter + 1 -%}
        {%else -%}
        tr.{{data.name}} ={ {%for i in range(data.nums) -%}transport_tr[{{counter}}]{%if not loop.is_last -%},{%endif -%}{% set counter = counter + 1 -%} {% endfor -%} };
        {%endif -%}
        {%endfor -%}
        delay.reset();
        sequence_receive(tr);
    endtask

    virtual function sequence_receive({{className}} tr);

    endfunction
endclass


class {{className}}_xagent_config extends uvm_object;
    string                             mon_channel_name;
    string                             drv_channel_name;
    uvm_object_wrapper                 mon_type;
    uvm_object_wrapper                 drv_type;

    function new(string name = "{{className}}_xagent_config");
        super.new(name);
        this.mon_channel_name = "{{className}}";
        this.drv_channel_name = "{{className}}";
    endfunction
endclass


class {{className}}_xagent extends uvm_agent;
    `uvm_component_utils({{className}}_xagent) 
    
    uvm_component                      mon_inst;
    uvm_component                      drv_inst;
    string                             mon_channel;
    string                             drv_channel;
    {{className}}_xagent_config      cfg;
    {{className}}_xmonitor           {{className}}_xmon;
    {{className}}_xdriver            {{className}}_xdrv;

    function new(string name,uvm_component parent = null);
        super.new(name,parent);
        if (!uvm_config_db#({{className}}_xagent_config)::get(this, "", "{{className}}_xagt_cfg", cfg)) begin
            `uvm_fatal("CFGERR", "Could not get xagent_config")
        end 
        else if(cfg.mon_type == null && cfg.drv_type ==null) begin
            `uvm_fatal("CFGERR", "Could not get monitor or driver type")
        end
        if (cfg.mon_type != null) begin
            uvm_config_db#(bit)::set(null,"","{{className}}_exist_xmonitor",1'b1);
        end
        else begin
            uvm_config_db#(bit)::set(null,"","{{className}}_exist_xmonitor",1'b0);
        end

        if (cfg.drv_type != null) begin
            uvm_config_db#(bit)::set(null,"","{{className}}_exist_xdriver",1'b1);
        end 
        else begin
            uvm_config_db#(bit)::set(null,"","{{className}}_exist_xdriver",1'b0);
        end    
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(cfg.mon_type != null) begin
          mon_inst = cfg.mon_type.create_component("{{className}}_sub",this);
          $cast({{className}}_xmon, mon_inst);
        end
        if(cfg.drv_type != null) begin
          drv_inst = cfg.drv_type.create_component("{{className}}_pub",this);
          $cast({{className}}_xdrv,drv_inst);
        end
        
    endfunction


    function void connect();
        mon_channel = $sformatf("%s%s", cfg.mon_channel_name,".sub");
        drv_channel = $sformatf("%s%s", cfg.drv_channel_name,".pub");
        
        if(cfg.mon_type != null) begin
          uvmc_tlm #()::connect({{className}}_xmon.out,mon_channel);
        end

        if(cfg.drv_type != null) begin
          uvmc_tlm #()::connect({{className}}_xdrv.in,drv_channel);        
        end
    endfunction

endclass
