//samplering engine loosely inspired by Mutable Instruments Clouds Eurorack module

8 => int num_samplers;

SndBuf s[num_samplers];
Gain master => dac;

0 => int voice_counter;
0 => int cycles;

for(int i; i < num_samplers; i++){
 s[i] => dac;
 0 => s[i].gain;
}

float params[0];

0.0     => params[":position"]; //FLOAT 0 - 1 where in the buffer are we playing sounds
10000.0  => params[":buffer_size"]; //FLOAT size of buffer in ms
500.0   => params[":size"]; //FLOAT  grain size: in ms 
1.0     => params[":rate"]; //FLOAT pitch : as a ratio (1 = original)
2.0     => params[":in_gain"]; //FLOAT sndbuf gain
10.0    => params[":density"]; //INT - random. + constant (-100 - 100)
0.0     => params[":texture"]; //FLOAT envelope
50.0   => params[":clock"]; //FLOAT clock speed
0.0     => params[":freeze"]; // BOOL stops input audio, gran happens on last few seconds of audio in mem
1.0     => params[":play"]; //BOOL play the main sampler

setFile(me.dir() + "samples/cs80.wav");

for(int i; i < num_samplers; i++){
 1 => s[i].play;
}

0 => s[num_samplers - 1].gain;
s[0].samples()/2 => s[num_samplers - 1].pos;



while(true){
  if(params[":density"] > 0){
    if(cycles % (params[":density"]$int)){
      spork~ trigger();
    }
  }else{
    if(Math.random2f(0, 100) < Math.fabs(params[":density"])){
      spork~ trigger();
    }
  }
  params[":clock"]::ms => now;
  cycles++;
}

fun void setFile(string _file){
  for(int i; i < num_samplers; i++){
    _file => s[i].read;
  }
}

fun void setRate(float _rate){
  for(int i; i < num_samplers; i++){
    _rate => s[i].rate;
  }
}

fun void setGain(float _gain){
  for(int i; i < num_samplers; i++){
    _gain => s[i].gain;
  }
}


fun void trigger(){
  <<<"triggering">>>;
  s[num_samplers - 1].pos() - ms2sample(Math.random2(0, (params[":buffer_size"]$int))) => s[voice_counter].pos;
  params[":in_gain"] => s[voice_counter].gain;
  params[":size"]::ms => now;
  0 => s[voice_counter].gain;
  (voice_counter + 1) % (num_samplers - 1) => voice_counter; //use last sampler as streaming playback
}

fun int ms2sample(int t){
  samp/second => float sr;
  return ((t/1000)*sr $ int);
}

fun int ms2sample(float t){
  samp/second => float sr;
  return (t$int/1000)*sr $ int;
}

