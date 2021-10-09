#! /usr/bin/python3 
########################################################################################################################
## Copyright 2021 Datum Technology Corporation
########################################################################################################################
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
## Licensed under the Solderpad Hardware License v 2.1 (the "License"); you may not use this file except in compliance
## with the License, or, at your option, the Apache License version 2.0.  You may obtain a copy of the License at
##                                        https://solderpad.org/licenses/SHL-2.1/
## Unless required by applicable law or agreed to in writing, any work distributed under the License is distributed on
## an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the
## specific language governing permissions and limitations under the License.
########################################################################################################################


"""Design Verification \'Makefile\'.

Usage:
  dvm all  <target>  [-t <test_name>]  [-s <seed>]  [-g | --gui]  [-w | --waves]  [-q | --noclean]  [-c | --cov]
  dvm cmp  <target>
  dvm elab <target>  [-d | --debug]
  dvm cpel <target>
  dvm sim  <target>  [-t <test_name>]  [-s <seed>]  [-g | --gui]  [-w | --waves]  [-c | --cov]
  dvm clean
  dvm results  <target> <filename>
  dvm (-h | --help)
  dvm --version

Options:
  -h --help     Show this screen.
  --version     Show version.
   
Examples:
  dvm clean                          # Deletes all simulation artifacts and results
  
  dvm cmp  uvmt_my_ip                # Only compile test bench for uvmt_my_ip
  dvm elab uvmt_my_ip                # Only elaborate test bench for uvmt_my_ip
  dvm cpel uvmt_my_ip                # Compile and elaborate test bench for uvmt_my_ip
  dvm sim  uvmt_my_ip -t smoke -s 1  # Only simulates test 'uvmt_my_ip_smoke_test_c' for top-level module 'uvmt_my_ip_tb'
  
  dvm all uvmt_my_ip -t smoke -s 1   # Compiles, elaborates and simulates test 'uvmt_my_ip_smoke_test_c' for bench 'uvmt_my_ip'
"""



from docopt     import docopt
import os
import subprocess
import shutil
import yaml
from datetime import datetime
from yaml.loader import SafeLoader
import xml.etree.cElementTree as ET
import re


dbg             = False
sim_debug       = True#False
sim_gui         = False
sim_waves       = True
sim_cov         = False

pwd               = os.getcwd()
temp_path         = pwd + '/temp'
vivado_path       = os.getenv("VIVADO", '/tools/vivado/2021.1/Vivado/2021.1/bin/')
uvm_dpi_so        = "uvm_dpi"
project_dir       = pwd + "/.."
rtl_path          = project_dir + "/rtl"
rtl_libs_path     = rtl_path + "/.imports"
dv_path           = project_dir + "/dv"
dv_imports_path   = dv_path + "/.imports"
history_file_path = pwd + "/history.yaml"
uvm_warning_regex = "UVM_WARNING\s+(.+)\((\d+)\)\s+\@\s+(\d+\.\d+\s+ns)\:\s+(\w+)\s+\[(\w+)\](.+)"
uvm_error_regex   = "UVM_ERROR\s+(.+)\((\d+)\)\s+\@\s+(\d+\.\d+\s+ns)\:\s+(\w+)\s+\[(\w+)\](.+)"
uvm_fatal_regex   = "UVM_FATAL\s+(.+)\((\d+)\)\s+\@\s+(\d+\.\d+\s+ns)\:\s+(\w+)\s+\[(\w+)\](.+)"


def do_dispatch(args):
    global sim_debug
    global sim_gui
    global sim_waves
    global sim_cov
    glb_args = args
    
    if (dbg):
        print("Call to do_dispatch()")
    
    if not args['<seed>']:
        args['<seed>'] = 1
    
    if args['results']:
        args['clean'] = False
        args['cmp'  ] = False
        args['elab' ] = False
        args['sim'  ] = False
    
    if args['all']:
        args['cmp'  ] = True
        args['elab' ] = True
        args['sim'  ] = True
        if (args['-q'] or args['--noclean']):
            args['clean'] = False
        else:
            args['clean'] = True
    
    if args['cpel']:
        args['clean'] = True
        args['cmp'  ] = True
        args['elab' ] = True
        args['sim'  ] = False
    
    if (args['-w'] or args['--waves']):
        sim_waves = True
        sim_debug = True
    else:
        sim_waves = False
    
    if (args['-c'] or args['--cov']):
        sim_cov = True
    else:
        sim_cov= False
    
    if (args['-g'] or args['--gui']):
        sim_debug = True
        sim_gui   = True
    else:
        sim_gui   = False
    
    if args['clean']:
        do_clean()
    if args['cmp']:
        out_path = pwd + "/out"
        if not os.path.exists(out_path):
            os.mkdir(out_path)
        do_cmp_rtl(args['<target>'])
        do_cmp_dv (dv_path + "/" + args['<target>'] + "/src/" + args['<target>'] + "_pkg.flist.xsim", args['<target>'])
    if args['elab']:
        #do_elab_rtl(args['<target>'])
        do_elab(args['<target>'], args['<target>'] + "_tb")
    if args['sim']:
        do_sim(args['<target>'], args['<test_name>'], args['<seed>'], [])
    if args['results']:
        do_parse_results(args['<target>'], args['<filename>'])


def set_env_var(name, value):
    if (dbg):
        print("Setting env var '" + name + "' to value '" + value + "'")
    os.environ[name] = value


def do_clean():
    if (dbg):
        print("Call to do_clean()")
    print("\033[1;31m********")
    print("Cleaning")
    print("********\033[0m")
    if os.path.exists("./xsim.dir"):
        shutil.rmtree("./xsim.dir")
    if os.path.exists("./out"):
        shutil.rmtree("./out")
    if os.path.exists(history_file_path):
        os.remove(history_file_path)
    create_history_log()


def do_cmp_rtl(target_design):
    if (dbg):
        print("Call to do_cmp_rtl(target_design='" + target_design + "'")
    


def do_cmp_dv(filelist_path, lib_name):
    if (dbg):
        print("Call to do_cmp_dv(filelist_path='" + filelist_path + "', lib_name='" + lib_name + "')")
    print("\033[0;36m************")
    print("Compiling DV")
    print("************\033[0m")
    if not os.path.exists(pwd + "/results"):
        os.mkdir(pwd + "/results")
    compilation_log_path = pwd + "/results/" + lib_name + ".cmp.log"
    add_cmp_to_history_log(lib_name, compilation_log_path)
    run_xsim_bin("xvlog", "--incr -sv -f " + filelist_path + " -L uvm --work " + lib_name + "=./out/" + lib_name + " --log " + compilation_log_path)


def do_elab(lib_name, design_unit):
    
    debug_str = ""

    if (dbg):
        print("Call to do_elab(lib_name='" + lib_name + "', design_unit='" + design_unit + "')")
    print("\033[0;36m***********")
    print("Elaborating")
    print("***********\033[0m")
    
    if (sim_debug):
        debug_str = " --debug all "
    else:
        debug_str = " --debug typical "
    
    if (sim_cov):
        cov_str = " -cov_db_name " + design_unit + " -cov_db_dir " + pwd + "/results/cov"
    else: 
        cov_str = " -ignore_coverage "

    elaboration_log_path = pwd + "/results/" + lib_name + ".elab.log"
    add_elab_to_history_log(lib_name, elaboration_log_path)
    run_xsim_bin("xelab", lib_name + "." + design_unit + cov_str + debug_str + " --incr -relax --O0 -v 0 -s " + design_unit + " -timescale 1ns/1ps -L " + lib_name + "=./out/" + lib_name + " --log " + elaboration_log_path)
    


def do_sim(lib_name, name, seed, plus_args):
    snapshot = args['<target>'] + "_tb"
    test_name = lib_name + "_" + name + "_test"
    waves_str = ""
    gui_str   = ""
    runall_str   = ""
    
    tests_results_path = pwd + "/results/" + test_name + "_" + str(seed)
    
    orig_plus_args = plus_args
    plus_args.append("SIM_DIR_RESULTS="                 + pwd + "/results")
    plus_args.append("UVM_TESTNAME="                    + test_name + "_c")
    plus_args.append("UVML_FILE_BASE_DIR_SIM="          + pwd)
    plus_args.append("UVML_FILE_BASE_DIR_TB="           + dv_path  + "/" + snapshot + "/src")
    plus_args.append("UVML_FILE_BASE_DIR_TESTS="        + dv_path  + "/" + snapshot + "/src/tests")
    plus_args.append("UVML_FILE_BASE_DIR_TEST_RESULTS=" + tests_results_path)
    plus_args.append("UVML_FILE_BASE_DIR_DV="           + dv_path)
    plus_args.append("UVML_FILE_BASE_DIR_RTL="          + rtl_path)

    act_args = ""
    for arg in plus_args:
        act_args = act_args + " -testplusarg \"" + arg + "\""
    
    if not os.path.exists(tests_results_path):
        os.mkdir(tests_results_path)
    if not os.path.exists(tests_results_path + "/trn_log"):
        os.mkdir(tests_results_path + "/trn_log")
    
    if (dbg):
        print("Call to do_sim(snapshot='" + snapshot + "', test_name='" + test_name + "', seed='" + str(seed) + "', args='" + act_args + "')")
    
    print("\033[0;32m**********")
    print("Simulating")
    print("**********\033[0m")
    
    if (sim_waves):
        if not os.path.exists(tests_results_path + "/waves_cfg.tcl"):
            f = open(tests_results_path + "/waves_cfg.tcl", "w")
            f.write("log_wave -recursive *")
            f.write("\n")
            f.write("run -all")
            f.write("\n")
            f.write("quit")
            f.close()
        waves_str = " --wdb " + tests_results_path + "/waves.wdb --tclbatch " + tests_results_path + "/waves_cfg.tcl"
    else:
        waves_str = ""
    
    if (sim_cov):
        cov_str = ""
    else: 
        cov_str = ""
    
    if (sim_gui):
        gui_str = " --gui "
        runall_str = ""
    else:
        gui_str = ""
        if (sim_waves):
            runall_str = ""
        else:
            runall_str = " --runall --onerror quit"
    
    if (sim_cov):
        cov_str = " -cov_db_name " + name + "_" + seed + " -cov_db_dir " + tests_results_path + "/cov"
    else: 
        cov_str = " -ignore_coverage "
    
    add_sim_to_history_log(lib_name, name, seed, orig_plus_args, tests_results_path)
    now = datetime.now()
    run_xsim_bin("xsim", snapshot + gui_str + waves_str + cov_str + runall_str + " " + act_args + " --stats --log " + tests_results_path + "/sim.log")
    update_sim_timestamp_in_history_log(lib_name, now, tests_results_path)
    print("************************************************************************************************************************")
    print("* View simulation results")
    print("************************************************************************************************************************")
    print("emacs " + tests_results_path + "/sim.log &")
    print(vivado_path + "/xsim -gui -view " + tests_results_path + "/waves_cfg.tcl &")
    print("************************************************************************************************************************")


def add_elab_to_history_log(snapshot, elaboration_log_path):
    now = datetime.now()
    timestamp = now.strftime("%Y/%m/%d-%H:%M:%S")
    if not os.path.exists(history_file_path):
        create_history_log()
    with open(history_file_path,'r') as yamlfile:
        cur_yaml = yaml.load(yamlfile, Loader=SafeLoader) # Note the safe_load
        if not snapshot in cur_yaml:
            cur_yaml[snapshot] = {}
        cur_yaml[snapshot]['elaboration_timestamp'] = timestamp
        cur_yaml[snapshot]['elaboration_log_path'] = elaboration_log_path
    if cur_yaml:
        with open(history_file_path,'w') as yamlfile:
            yaml.dump(cur_yaml, yamlfile) # Also note the safe_dump


def add_cmp_to_history_log(snapshot, compilation_log_path):
    now = datetime.now()
    timestamp = now.strftime("%Y/%m/%d-%H:%M:%S")
    if not os.path.exists(history_file_path):
        create_history_log()
    with open(history_file_path,'r') as yamlfile:
        cur_yaml = yaml.load(yamlfile, Loader=SafeLoader) # Note the safe_load
        if not snapshot in cur_yaml:
            cur_yaml[snapshot] = {}
        cur_yaml[snapshot]['compilation_timestamp'] = timestamp
        cur_yaml[snapshot]['compilation_log_path'] = compilation_log_path
        if cur_yaml:
            with open(history_file_path,'w') as yamlfile:
                yaml.dump(cur_yaml, yamlfile) # Also note the safe_dump


def add_sim_to_history_log(snapshot, test_name, seed, args, results_path):
    now = datetime.now()
    timestamp = now.strftime("%Y/%m/%d-%H:%M:%S")
    
    if not os.path.exists(history_file_path):
        f = open(history_file_path, "w+")
        f.write("---")
        f.close()
    with open(history_file_path,'r') as yamlfile:
        cur_yaml = yaml.load(yamlfile, Loader=SafeLoader) # Note the safe_load
        if not cur_yaml:
            print("Failed to open history log file")
            return
        else:
            if not snapshot in cur_yaml:
                cur_yaml[snapshot] = {}
            if not 'simulations' in cur_yaml[snapshot]:
                cur_yaml[snapshot]['simulations'] = {}
            cur_yaml[snapshot]['simulations'][results_path] = {}
            cur_yaml[snapshot]['simulations'][results_path]['test_name'] = test_name
            cur_yaml[snapshot]['simulations'][results_path]['seed'] = seed
            cur_yaml[snapshot]['simulations'][results_path]['args'] = args
            cur_yaml[snapshot]['simulations'][results_path]['results'] = results_path
            cur_yaml[snapshot]['simulations'][results_path]['start'] = timestamp
            with open(history_file_path,'w') as yamlfile:
                yaml.dump(cur_yaml, yamlfile) # Also note the safe_dump


def update_sim_timestamp_in_history_log(snapshot, orig_timestamp, tests_results_path):
    now = datetime.now()
    duration = now - orig_timestamp
    timestamp = now.strftime("%Y/%m/%d-%H:%M:%S")
    if not os.path.exists(history_file_path):
        print("No history log file!")
    with open(history_file_path,'r') as yamlfile:
        cur_yaml = yaml.load(yamlfile, Loader=SafeLoader) # Note the safe_load
        if not cur_yaml:
            print("Failed to open history log file")
            return
        else:
            cur_yaml[snapshot]['simulations'][tests_results_path]['end'] = timestamp
            cur_yaml[snapshot]['simulations'][tests_results_path]['duration'] = duration.seconds
            with open(history_file_path,'w') as yamlfile:
                yaml.dump(cur_yaml, yamlfile) # Also note the safe_dump


def create_history_log():
    if not os.path.exists(history_file_path):
        with open(history_file_path,'w') as yamlfile:
            yaml.dump({}, yamlfile)


def do_parse_results(snapshot, filename):
    test_count = 0
    failure_count = 0
    total_duration = 0
    now = datetime.now()
    timestamp = now.strftime("%Y/%m/%d-%H:%M:%S")
    testsuites = ET.Element("testsuites")
    testsuites.set('id', snapshot + "_" + timestamp)
    testsuites.set('name', snapshot)
    testsuite = ET.SubElement(testsuites, "testsuite")
    testsuite.set('id', snapshot + "_" + timestamp)
    testsuite.set('name', "functional")
    print("Parsing results ...")
    if not os.path.exists(history_file_path):
        sys.exit("No history log file")
    else:
        with open(history_file_path,'r') as yamlfile:
            cur_yaml = yaml.load(yamlfile, Loader=SafeLoader)
            if cur_yaml:
                for sim in cur_yaml[snapshot]['simulations']:
                    sim_log_path = sim + "/sim.log"
                    duration = int(cur_yaml[snapshot]['simulations'][sim]['duration'])
                    total_duration = total_duration + duration
                    testcase = ET.SubElement(testsuite, "testcase")
                    testcase.set('id', snapshot + "." + cur_yaml[snapshot]['simulations'][sim]['test_name'])
                    testcase.set('name', cur_yaml[snapshot]['simulations'][sim]['test_name'])
                    testcase.set('args', cur_yaml[snapshot]['simulations'][sim]['args'])
                    testcase.set('seed', str(cur_yaml[snapshot]['simulations'][sim]['seed']))
                    testcase.set('time', str(duration))
                    passed = sim_parse_sim_results(sim_log_path, testcase)
                    if passed == "failed" or passed == "inconclusive":
                        failure_count = failure_count + 1
                        
                    test_count = test_count + 1
                    
        testsuites.set('tests', str(test_count))
        testsuites.set('failures', str(failure_count))
        testsuites.set('time', str(total_duration))
        testsuite.set('tests', str(test_count))
        testsuite.set('failures', str(failure_count))
        testsuites.set('time', str(total_duration))
        tree = ET.ElementTree(testsuites)
        tree.write(filename)


def sim_parse_sim_results(sim_log_path, testcase):
    test_result = "passed"
    if not os.path.exists(history_file_path):
        print("No sim log file " + sim_log_path)
        test_result = "inconclusive"
    else:
        for i, line in enumerate(open(sim_log_path)):
            matches = re.search(uvm_error_regex, line)
            if matches:
                failure = ET.SubElement(testcase, "failure")
                failure.set("message", line)
                failure.set("type", "ERROR")
                test_result = "failed"
            matches = re.search(uvm_fatal_regex, line)
            if matches:
                failure = ET.SubElement(testcase, "failure")
                failure.set("message", line)
                failure.set("type", "FATAL")
                test_result = "failed"
    
    return test_result


def copy_tree(src, dst, symlinks=False, ignore=None):
    for item in os.listdir(src):
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if os.path.isdir(s):
            shutil.copytree(s, d, symlinks, ignore)
        else:
            shutil.copy2(s, d)


def run_xsim_bin(name, args):
    bin_path = vivado_path + name
    if (dbg):
        print("Call to run_xsim_bin(name='" + name + "', args='"  + args + "')")
        print("System call is " + bin_path + " " + args)
    subprocess.call(bin_path + " " + args, shell=True)


if __name__ == '__main__':
    args = docopt(__doc__, version='DVMake 0.1')
    if (dbg):
        print(args)
    do_dispatch(args)

