const assert = require('assert');
const Chirp = require('../chirp');

describe('Chirp', function() {
  describe('#run', function() {
    it('should return a runnable chuck command', async function() {
      const command = await Chirp.run('test/run/base.ck')
      assert.equal(
        command,
        "chuck test/run/one.ck test/run/three.ck test/run/two.ck test/run/base.ck")
    })
  })
})
