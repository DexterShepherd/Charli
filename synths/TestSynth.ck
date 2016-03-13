public class TestSynth extends Interface{
  //set signal chain
  SinOsc s => dac;
  0 => s.gain;
  //instantiate params with defaults
  0.0 => params[":gain"];
  440.0 => params[":freq"];
  
  //start update loop
  spork ~update();

  fun void update(){
    while(true){
      1::ms => now;
      params[":gain"] => s.gain;
      params[":freq"] => s.freq;
    }
  }
}
