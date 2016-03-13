//factory class, responsible for creating and destroying objects
public class Factory{
  fun Interface gen(string _synth_type){
    if(_synth_type == ":test_synth"){
      <<<"generating TestSynth">>>;
      return new TestSynth;
    }else if (_synth_type == ":bpf_saw"){
      <<<"generating BPFSaw">>>;
      return new BPFSaw;
    }else{
      <<<"No Synth " + _synth_type + " in library">>>;
      return new Interface;
    }
  }
}


