Util u;
Factory f;

Interface @ saw[5];

u.scale(":c", 32, 4) @=> int s[];

<<<s.size()>>>;

for(int i; i < 5; i++){
  f.gen(":bpf_saw") @=> saw[i];
  saw[i].setParam(":freq", Std.mtof(s[Math.random2(0, s.size() - 1)]));
}

for(int i; i < 5; i++){
  saw[i].setParam(":gain", 0.2);
  saw[i].noteOn();
  saw[i].noteOff();
}

for(int i; i < 5; i++){
  saw[i].noteOn();
}

1::second => now;

for(int i; i < 5; i++){
  saw[i].noteOff();
}

2::second => now;
