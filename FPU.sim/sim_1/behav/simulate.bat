@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim main_test_behav -key {Behavioral:sim_1:Functional:main_test} -tclbatch main_test.tcl -view C:/Users/Auora/Documents/FPU/main_test_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
