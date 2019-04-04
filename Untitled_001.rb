# Untitled 001
#
# by Mossieur Propre - 04/04/2019
#
# 001, a lot more to come. Still looking for a title
#
# Created with Sonic Pi
#

use_bpm 50

live_loop :metronome do
  sleep 0.5
end

live_loop :beat, sync: :metronome do
  #stop
  with_fx :lpf, cutoff: 105, amp: 0.8 do
    sample :drum_bass_soft, lpf: 100
    sample :drum_cymbal_closed, amp: 0.5
    sleep 0.25
    sample :drum_cymbal_closed, amp: 0.5
    sleep 0.25
    sample :drum_snare_soft, lpf: 100
    sample :drum_cymbal_closed, amp: 0.5
    sleep 0.25
    sample :drum_cymbal_closed, amp: 0.5
    sleep 0.25
  end
end

bass_notes = (scale :d2, :minor_pentatonic , num_octaves: 2).shuffle

live_loop :melody, sync: :metronome do
  #stop
  with_fx :distortion, distort: 0.8 do
    use_synth :saw
    play bass_notes.tick, amp: 0.1, release: 0.3, cutoff: 50
  end
  sleep 0.25
end

live_loop :bass, sync: :metronome do
  #stop
  use_synth :fm
  with_fx :bitcrusher, bits: 50, mix: 0.5 do
    play_pattern_timed [:d2, :c2, :f2], [4, 1, 2], release: 3
  end
end

melody2_notes = (scale :d4, :minor_pentatonic , num_octaves: 2)

live_loop :melody2, sync: :metronome do
  #stop
  with_fx :hpf, cutoff: 70 do
    use_synth :blade
    play_pattern_timed melody2_notes, 0.125, attack: 0.5, release: 0.3, cutoff: 50, amp: 1, phase: 20, pan: rrand(-1, 1)
  end
end

break_notes = [:d4, :f4, :c4, :f4]

live_loop :break, sync: :metronome do
  #stop
  use_synth :saw
  with_fx :lpf, cutoff: 70 do
    with_fx :distortion, distort: 0.9, amp: 0.3 do
      play_pattern_timed break_notes, 0.125, attack: 0, release: 0.1, amp: 0.1
    end
  end
end







