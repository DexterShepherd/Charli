public class Interface extends Chubgraph{
  float params[0];

  fun void setParam(string _which, float _value){
    _value => params[_which];
  }
  fun float getParam(string _which){
    return params[_which];
  }

  fun void noteOn(){} //implement in child

  fun void noteOff(){} //implement in child

  fun string info(){} //implement in child
}
