Util u;
Control c;


spork ~c.playChords(  ":bpf_saw",
                      0.3,
                      [[22,35,54,63,64,76],
                      [45,52,54,59,61,64],
                      [28,40,47,56,59,63],
                      [42,52,57,57,61,75]],
                      1::second,
                      2::second,
                      4);

while(1){
  1::second => now;
}
