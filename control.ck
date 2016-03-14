public class Control{
  Factory factory;
  fun ugen playChords(string _synth, float _gain, int _chords[][], dur _atk, dur _rel, int _loops){
    int num_synths;
    Gain master;
    0 => int temp_max;
    for(int i; i < _chords.size() -1; i++){
      if(_chords[i].size() > temp_max){
        _chords[i].size() => num_synths;
      }
    }
    <<<temp_max>>>;
    Interface @ synths[num_synths]; //set up array of null synths
    for(int i; i < num_synths; i++){
      factory.gen(_synth) @=> synths[i];
      synths[i] => master;
    }
    if(_loops != -1){
      for(int count; count < _loops; count++){
        for(int i; i < _chords.size() - 1; i++){
          for(int j; j < _chords[i].size() - 1; j++){
            synths[j].setParam(":freq", Std.mtof(_chords[i][j]));
            synths[j].setParam(":gain", _gain);
          }
          for(int j; j < _chords[i].size() - 1; j++){
            synths[j].noteOn();
          }
          _atk => now;
          for(int j; j < _chords[i].size() - 1; j++){
            synths[j].noteOff();
          }
          _rel => now;
        }
      }
      Interface @ cleanup[num_synths]; //GC
      cleanup @=> synths;
      me.exit();
    }else{
      while(true){
        for(int i; i < _chords.size() - 1; i++){
          for(int j; j < _chords[i].size() - 1; j++){
            synths[j].setParam(":freq", Std.mtof(_chords[i][j]));
            synths[j].setParam(":gain", _gain);
          }
          for(int j; j < _chords[i].size() - 1; j++){
            synths[j].noteOn();
            _atk => now;
            synths[j].noteOff();
            _rel => now;
          }
        }
      }
    }
  }
}
