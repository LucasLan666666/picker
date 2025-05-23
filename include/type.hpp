#pragma once
#include <bits/stdc++.h>

namespace picker {


enum class SignalAccessType : int {
    DPI = 0,
    MEM_DIRECT = 1,
};

typedef struct main_opts {
    bool version;
    bool show_default_template_path;
    bool show_xcom_lib_location_cpp;
    bool show_xcom_lib_location_java;
    bool show_xcom_lib_location_scala;
    bool show_xcom_lib_location_golang;
    bool show_xcom_lib_location_python;
    bool show_xcom_lib_location_lua;
    bool check;
} main_opts;

typedef struct export_opts {
    std::vector<std::string> file;
    std::vector<std::string> filelists;
    std::string sim;
    std::string language;
    std::string source_dir;
    std::string target_dir;
    std::vector<std::string> source_module_name_list;
    std::string target_module_name;
    std::string internal;
    bool checkpoints;
    bool vpi;
    std::string frequency;
    std::string wave_file_name;
    bool coverage;
    std::string vflag;
    std::string cflag;
    bool verbose;
    bool example;
    bool autobuild;
    bool cp_lib;
    SignalAccessType rw_type;
    std::vector<std::string> transaction;
    std::string rname;
} export_opts;

typedef struct pack_opts {
    std::vector<std::string> files;
    std::vector<std::string> rename;
    bool example;
    bool force;
} pack_opts;

typedef struct sv_signal_define {
    std::string logic_pin;
    std::string logic_pin_type;
    int logic_pin_hb;
    int logic_pin_lb;
} sv_signal_define;

typedef struct sv_module_define {
    std::string module_name;
    int module_nums;
    std::vector<sv_signal_define> pins;
} sv_module_define;

typedef struct uvm_parameter {
    std::string name;
    int byte_count;
    int bit_count;
    int is_marcro;
    std::string macro_name;
    std::string current_index;
} uvm_parameter;

typedef struct uvm_transaction_define {
    std::string name;
    std::string filepath;
    std::string transaction_name;
    std::string version;
    std::string data_now;
    std::vector<uvm_parameter> parameters;

} uvm_transaction_define;
} // namespace picker
