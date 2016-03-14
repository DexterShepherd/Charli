public class BPFSaw extends Interface{

  fun string info(){
    "A single BlitSaw running through a bandpass filter.
    :freq       - Osc frequency
    :gain       - Final gain stage
    :filt_freq  - Bandpass filter frequency
    :q          - Bandpass filter quality
    :atk        - ADSR Attack time
    :sus        - ADSR Sustain level
    :rel        - ADSR Release time" => string _info;
    <<<_info>>>;
    return _info;
  }

  BlitSaw sig => BPF bpf => ADSR env => Gain master => outlet;
  0 => master.gain;
  
  500.0   => params[":freq"];
  0.0     => params[":gain"];
  2000.0  => params[":filt_freq"];
  1.0     => params[":q"];
  2.0     => params[":atk"];
  1.0     => params[":sus"];
  2.0     => params[":rel"];


  spork ~update();

  fun void noteOn(){
    env.keyOn();
  }

  fun void noteOff(){
    env.keyOff();
  }
  
  fun void update(){
    while(true){
      params[":freq"]         => sig.freq;
      params[":gain"]         => master.gain;
      params[":filt_freq"]    => bpf.freq;
      params[":q"]            => bpf.Q;
      params[":atk"]::second  => env.attackTime;
      params[":sus"]          => env.sustainLevel;
      params[":rel"]::second  => env.releaseTime;
      1::ms => now;
    }
  }
}

