public class Util{
  [0, 2, 4, 5, 7, 9, 11] @=> int major_base[];
  [0, 2, 3, 5, 7, 8, 10] @=> int minor_base[];
  [":A", ":A^", ":B", ":C", ":C^", ":D",
   ":D^", ":E", ":F", ":F^", ":G", ":G^"] @=> string major_degrees[];
  [":a", ":a^", ":b", ":c", ":c^", ":d",
   ":d^", ":e", ":f", ":f^", ":g", ":g^"] @=> string minor_degrees[];

  fun int[] scale(string _type, int _transpose, int _num_octaves){
    int temp[0];
    if(_num_octaves == 0){
      temp << 0;
      <<<"cannot create scale for 0 octaves">>>;
      return temp;
    }
    for(int i; i < 12; i++){
      if(_type == major_degrees[i]){
        for(int j; j < _num_octaves; j++){
          for(int k; k < 7; k++){
            temp << (major_base[k] + i)%12 + (j * 12) + _transpose;
          }
        }
        return temp;
      }else if(_type == minor_degrees[i]){
        for(int j; j < _num_octaves; j++){
          for(int k; k < 7; k++){
            temp << (minor_base[i] + k)%12 + (j * 12) + _transpose;
          }
        }
        return temp;
      }
    }
    temp << 0;
    <<<"cannot create scale for : " + _type >>>;
    return temp;
  }

  fun int[] scale(string _type, int _transpose){
    int temp[0];
    for(int i; i < 12; i++){
      if(_type == major_degrees[i]){
        for(int k; k < 7; k++){
          temp << major_base[i] + k + _transpose;
        }
        printA(temp);
        return temp;
      }
      else if(_type == minor_degrees[i]){
        for(int k; k < 7; k++){
          temp << minor_base[i] + k + _transpose;
        }
        printA(temp);
        return temp;
      }else{
        temp << 0;
        <<<"cannot create scale for : " + _type >>>;
        return temp;
      }
    }
  }

  fun void printA(int a[]){
    for(int i; i < a.cap() -1; i++){
      <<<a[i]>>>;
    }
  }

  fun void printA(string a[]){
    for(int i; i < a.cap() -1; i++){
      <<<a[i]>>>;
    }
  }

  fun void printA(float a[]){
    for(int i; i < a.cap() -1; i++){
      <<<a[i]>>>;
    }
  }
}
