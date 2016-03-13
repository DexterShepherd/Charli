Factory f;

Interface @ sin;

f.gen(":test_synth") @=> sin;

sin.setParam(":gain", 0.5);

1::second => now;

sin.setParam(":freq", 500);

1::second => now;
