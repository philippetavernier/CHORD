# Welcome to Sonic Pi v2.10

string1= :F
chords = [(chord string1, :major), (chord :F, :sus4), (chord :A, :minor), (chord :G, "m7")].ring

x=0

c = chords[0] # take the first chord of the ring and save it to a variable
# this is going to be used in all the live_loops. It will be ticked by the :bass loop

use_bpm 130

live_loop :melody do
  use_synth :blade
  r = [0.25, 0.25, 0.5, 1].choose
  #play c.choose, attack: 0, release: r
  #play_pattern c, attack:0, release: r
  play_pattern_timed c , [0.25, 0,5]
  sleep r
end

live_loop :keys do
  use_synth :blade
  play c
  sleep 1
end

live_loop :bass do
  use_synth :fm
  use_octave -2
  3.times do
    play c[0] # play the first note of the chord
    sleep 1
  end
  play c[2] # play the third note of the chord
  sleep 0.5
  play c[1] # # play the second note of the chord
  sleep 0.5
  c = chords.tick
  print "########################"
  print c
  
end

live_loop :rhythm do
  sample :drum_heavy_kick, amp: 1
  sleep 1
  sample :elec_plip, rate: [0.5, 2, 1, 4].choose * [1, 2, 3, 10].choose, amp: 0.6
  sleep 1
end
