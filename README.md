Ideas for project structure and preprocessing for the ChucK programming language




Allows for requiring files via comments

For the file Main.ck
```
// require('./Sampler.ck')

Sampler s => dac;

```

`node ./node_modules/charli Main.ck` will run the command `chuck Sampler.ck Main.ck` to make quick prototyping easier with multiple files.


Use at your own risk, I'm really only developing this for my own convenience.
