function(__cmake_scripts_log MESSAGE)
    set(log_prefix "[cmake-scripts in ${PROJECT_NAME}]")
    message(STATUS "${log_prefix} ${MESSAGE}")
endfunction()
