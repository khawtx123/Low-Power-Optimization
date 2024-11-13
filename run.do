vopt adc_tester -o tbout -pa_upf rtl_top.upf -pa_genrpt -pa_checks -pa_coverage -pa_enable=highlight+debug
vsim tbout -pa -pa_highlight
add wave -r *
run -all
coverage exclude -scope /adc_tester/dut -pstate PD_TOP.primary DEFAULT_CORRUPT
coverage exclude -scope /adc_tester/dut -ptrans PD_TOP.primary {DEFAULT_NORMAL -> *}
coverage report -pa -details
coverage save -pa pa.ucdb
vcover report pa.ucdb -pa
