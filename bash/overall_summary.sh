#!/bin/bash

# This script gets a summary of status data of the CPU (And maybe memory, disk and network too).

# 1. CPU
# 1.1 CPU General Info
col_seperator=':'
vendor_name=`cat /proc/cpuinfo | grep 'vendor' | cut -d: -f2 | sed 's/^ *//'` 
model_name=`cat /proc/cpuinfo | grep 'model name' | cut -d: -f2 | sed 's/^ *//'`
addr_size=`cat /proc/cpuinfo | grep 'address sizes' | cut -d: -f2 | sed 's/^ *//'`
arch=`lscpu | grep 'Architecture' | cut -d: -f2 | sed 's/^ *//'`
modes=`lscpu | grep 'CPU op-mode' | cut -d: -f2 | sed 's/^ *//'`
byte_order=`lscpu | grep 'Byte Order' | cut -d: -f2 | sed 's/^ *//'`
threads_per_core=`lscpu | grep 'Thread(s) per core' | cut -d: -f2 | sed 's/^ *//'`
cores_per_socket=`lscpu | grep 'Core(s) per socket' | cut -d: -f2 | sed 's/^ *//'` 
n_sockets=`lscpu | grep 'Socket(s)' | cut -d: -f2 | sed 's/^ *//'`


echo "###### General Information ######"
printf "%20s %2s $vendor_name\n" "Vendor" $col_seperator
printf "%20s %2s $addr_size\n" "Address Sizes" $col_seperator
printf "%20s %2s $arch\n" "Architecture" $col_seperator
printf "%20s %2s $modes\n" "CPU Op-Mode(s)" $col_seperator
printf "%20s %2s $byte_order\n" "Byte Order" $col_seperator
printf "%20s %2s $threads_per_core\n" "Threads Per Core" $col_seperator
printf "%20s %2s $cores_per_socket\n" "Core(s) Per Socket" $col_seperator
printf "%20s %2s $n_sockets\n" "Socket(s)" $col_seperator

# This isn't done yet. Lots of TODOs... 