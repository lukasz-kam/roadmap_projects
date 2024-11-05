#!/bin/bash
#
# Script prints performance data about server to STDOUT

print_cpu_usage() {
  top -n 1 | grep -m1 '%CPU' | awk '{printf("Total CPU usage: %s%s\n"), $2, "%"}' FS=" "
}

print_memory_usage() {
  printf "%10s %15s %15s %15s %15s\n" " " "free [MB]" "free [%]" "used [MB]" "used [%]"
  free -m | awk 'FNR == 2 {printf("Memory: %16.fMB %15.f %13.fMB %15.f\n", \
                $7, ($7/$2 * 100.0), $3, ($3/$2 * 100.0))}'
}

print_disk_usage() {
  printf "%10s %15s %15s %15s %15s\n" " " "free [MB]" "free [%]" "used [MB]" "used [%]"
  df -h | grep '/dev/sda' | awk '{printf("%s: %15s %15s %15s %15s\n", $1, $4, \
                                  100-$5, $3, 0 + $5)}'
}

print_top_cpu_processes() {
  printf "Top 5 processes by CPU usage:\n"
  top -b -n 1 | awk 'NR == 7 {print $0}'
  top -b -n 1 | awk 'NR>7 {print $0}' | sort -k9 -nr | head -n 5
}

print_top_mem_processes() {
  printf "Top 5 processes by MEMORY usage:\n"
  top -b -n 1 | awk 'NR == 7 {print $0}'
  top -b -n 1 | awk 'NR>7 {print $0}' | sort -k10 -nr | head -n 5
}

print_additional_info() {
  os_version=$(awk 'NR == 1 {print $2}' FS='=' </etc/os-release)
  printf "OS version: %s\n" "${os_version}"
  printf '\n'
  printf "System uptime: %s\n" "$(uptime)"
  printf '\n'
  printf "Logged in users:\n%s\n" "$(who)"
  printf '\n'
  printf "Failed login attempts:\n%s\n" "$(grep "authentication failure" </var/log/auth.log || echo "None")"
}

main() {
  print_cpu_usage
  printf '\n'
  print_memory_usage
  printf '\n'
  print_disk_usage
  printf '\n'
  print_top_cpu_processes
  printf '\n'
  print_top_mem_processes
  printf '\n'
  print_additional_info
}

main