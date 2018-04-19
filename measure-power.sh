#!/bin/bash
# Original Code: https://forum.odroid.com/viewtopic.php?f=61&t=2060
# I customized the code for Odroid-XU3 with INA231 sensors

# enable the sensors
echo 1 > /sys/bus/i2c/drivers/INA231/0-0045/enable
echo 1 > /sys/bus/i2c/drivers/INA231/0-0040/enable
echo 1 > /sys/bus/i2c/drivers/INA231/0-0041/enable
echo 1 > /sys/bus/i2c/drivers/INA231/0-0044/enable

# settle two seconds to the sensors get fully enabled and have the first reading
sleep 2

# Main infinite loop
while true; do

# ----------- CPU DATA ----------- #

# Node Configuration for CPU Frequency
CPU0_FREQ=$((`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`/1000))" Mhz"
CPU1_FREQ=$((`cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq`/1000))" Mhz"
CPU2_FREQ=$((`cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq`/1000))" Mhz"
CPU3_FREQ=$((`cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq`/1000))" Mhz"

# CPU Governor
echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
CPU_GOVERNOR=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
echo "governor: $CPU_GOVERNOR"

# Now lets get CPU Power Comsumption
# Letter Values are:
# V = Volts
# A = Amps
# W = Watts

# A7 Nodes
A7_V=`cat /sys/bus/i2c/drivers/INA231/0-0045/sensor_V`"V"
A7_A=`cat /sys/bus/i2c/drivers/INA231/0-0045/sensor_A`"A"
A7_W=`cat /sys/bus/i2c/drivers/INA231/0-0045/sensor_W`"W"
A7_WW=`cat /sys/bus/i2c/drivers/INA231/0-0045/sensor_W`

# A15 Nodes
A15_V=`cat /sys/bus/i2c/drivers/INA231/0-0040/sensor_V`"V"
A15_A=`cat /sys/bus/i2c/drivers/INA231/0-0040/sensor_A`"A"
A15_W=`cat /sys/bus/i2c/drivers/INA231/0-0040/sensor_W`"W"
A15_WW=`cat /sys/bus/i2c/drivers/INA231/0-0040/sensor_W`

# --------- MEMORY DATA ----------- # 
MEM_V=`cat /sys/bus/i2c/drivers/INA231/0-0041/sensor_V`"V"
MEM_A=`cat /sys/bus/i2c/drivers/INA231/0-0041/sensor_A`"A"
MEM_W=`cat /sys/bus/i2c/drivers/INA231/0-0041/sensor_W`"W"
MEM_WW=`cat /sys/bus/i2c/drivers/INA231/0-0041/sensor_W`

# ---------- GPU DATA ------------- # 
GPU_V=`cat /sys/bus/i2c/drivers/INA231/0-0044/sensor_V`"V"
GPU_A=`cat /sys/bus/i2c/drivers/INA231/0-0044/sensor_A`"A"
GPU_W=`cat /sys/bus/i2c/drivers/INA231/0-0044/sensor_W`"W"
GPU_WW=`cat /sys/bus/i2c/drivers/INA231/0-0044/sensor_W`

# ---------- DRAW Screen ----------- #

echo "$A15_WW $A7_WW $MEM_WW $GPU_WW"

sleep 3
done
