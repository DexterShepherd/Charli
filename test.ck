Util u;
Factory f;

Interface @ saw[5];

u.scale(":C", 48, 3) @=> int s[];

for(int i; i < 3; i++){
  f.gen(":bpf_saw") @=> saw[i];
}

for(int j; j < 5; j++){
  for(int i; i < 3; i++){
    saw[i].setParam(":gain", 0.2);
    saw[i].setParam(":freq", Std.mtof(s[Math.random2(0, s.size() - 1)]));
  }

  for(int i; i < 3; i++){
    saw[i].noteOn();
  }

  1::second => now;

  for(int i; i < 3; i++){
    saw[i].noteOff();
  }

  2::second => now;
}
