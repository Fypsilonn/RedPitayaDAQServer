using RedPitayaDAQServer
using PyPlot

# obtain the URL of the RedPitaya
include("config.jl")

rp = RedPitayaCluster([URLs[1]])

dec = 64
modulus = 4800
base_frequency = 125000000
periods_per_step = 5
samples_per_period = div(modulus, dec)
periods_per_frame = 50 # about 0.5 s frame length
frame_period = dec*samples_per_period*periods_per_frame / base_frequency
slow_dac_periods_per_frame = div(50, periods_per_step)

decimation(rp, dec)
samplesPerPeriod(rp, samples_per_period)
periodsPerFrame(rp, periods_per_frame)
passPDMToFastDAC(master(rp), true)

modeDAC(rp, "STANDARD")
frequencyDAC(rp,1,1, base_frequency / modulus)

freq = frequencyDAC(rp,1,1)
println(" frequency = $(freq)")
signalTypeDAC(rp, 1 , "SINE")
amplitudeDAC(rp, 1, 1, 0.2)
phaseDAC(rp, 1, 1, 0.0 ) # Phase has to be given in between 0 and 1

ramWriterMode(rp, "TRIGGERED")
triggerMode(rp, "EXTERNAL")

# Sequence
# Global Settings
slowDACStepsPerFrame(rp, slow_dac_periods_per_frame) # This sets PDMClockDivider, but it can also be set directly and with slowDACStepsPerSequence
numSlowDACChan(master(rp), 1)
# Per Sequence settings
lut = collect(range(0,0.7,length=slow_dac_periods_per_frame))
seq = ArbitrarySequence(lut, nothing, slow_dac_periods_per_frame, 2, 0.0, 0.0)
appendSequence(master(rp), seq)
success = prepareSequence(master(rp))

masterTrigger(rp, false)
startADC(rp)
masterTrigger(rp, true)

sleep(0.1)

uCurrentFrame = readFrames(rp, 0, 5)
stopADC(rp)
masterTrigger(rp, false)


fig = figure(1)
clf()
plot(vec(uCurrentFrame[:,1,:,:]))
plot(vec(uCurrentFrame[:,2,:,:]))
legend(("Rx1"))
fig