# Wobble test
#
# by Mossieur Propre - 05/04/2019
#
# This is a test about using an independant wobble effect on the bass.
# The cutoff frequencies are modulated in a triangle wave form, and are
# net reseted when the loop restarts.
#
# Featuring a so bitcrushed synth that it seems to be glitching ;-)
#
# Created with Sonic Pi
#

use_bpm 130

live_loop :metronome do
  sleep 2
end

# Drums
live_loop :drums, sync: :metronome do
  #stop
  sample :drum_heavy_kick, lpf: 90, amp: 1.6
  sleep 1
  with_fx :distortion, distort: 0.5, amp: 0.7 do
    sample :elec_hi_snare, lpf: 100
  end
  sleep 1
end

live_loop :cymbals, sync: :metronome do
  #stop
  hpf = 115
  sample :drum_cymbal_closed, hpf: hpf
  sleep 0.5
  sample :drum_cymbal_closed, hpf: hpf
  sleep 0.5
  sample :drum_cymbal_closed, hpf: hpf
  sleep 0.25
  sample :drum_cymbal_closed, hpf: hpf
  sleep 0.75
end

# The bass thing
actual_cutoff = 0
order = 1

define :bass_wobble do |note, cutoff_min, cutoff_max, step|
  use_synth :dsaw
  if actual_cutoff == 0
    actual_cutoff = cutoff_min
  end
  
  with_fx :wobble, cutoff_min: cutoff_min, cutoff_max: actual_cutoff do
    play note, attack: 0.3, release: 0.3
    
    actual_cutoff = actual_cutoff + (step * order)
    
    if actual_cutoff >= cutoff_max and order == 1
      order = -1
    elsif actual_cutoff <= cutoff_min and order == -1
      order = 1
    end
    
    sleep 0.5
  end
  
end

bass_notes = [:a1, :a1, :a1, :a1, :a1, :a1, :bs1, :bs1, :e2, :e2, :e2, :e2, :f2, :f2, :g2, :g2]
live_loop :test, sync: :metronome do
  #stop
  bass_notes.each do |note|
    bass_wobble note, 70, 125, 5
  end
end

live_loop :synth1, sync: :metronome do
  #stop
  use_synth :zawa
  play_chord chord(:b4, :minor), attack: 1, pan: rrand(-1, 1), amp: 0.4, cutoff: 90
  sleep 2
end

synth2_notes = [:a3, :e4]
live_loop :synth2, sync: :metronome do
  #stop
  use_synth :saw
  with_fx :flanger, amp: 0.4 do
    with_fx :bitcrusher, sample_rate: 1000, bits: 4 do
      synth2_notes.each do |note|
        8.times do
          play note, lpf: 90
          sleep 0.25
        end
      end
    end
  end
end








