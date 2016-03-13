public class Interface{
  float params[0];
  fun void setParam(string _which, float _value){
    _value => params[_which];
  }
  fun float getParam(string _which){
    return params[_which];
  }
}
