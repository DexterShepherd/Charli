//factory class, responsible for creating and destroying objects
public class Factory{
  fun Interface gen(string _synth_type){
    if(_synth_type == ":test_synth"){
      <<<"generating TestSynth">>>;
      return new TestSynth;
    }
  }
}


