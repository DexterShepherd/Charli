//experiments with the factory pattern for ChucK performance

Machine.add(me.dir() + "interface.ck");

me.dir() + "synths/" => string _path;
Machine.add(_path + "TestSynth.ck"); //test synth

Machine.add(me.dir() + "factory.ck");

