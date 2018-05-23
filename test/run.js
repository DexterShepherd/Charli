const assert = require('assert');
const Chirp = require('../chirp');

describe('Chirp', function() {
  describe('#run', function() {
    it('should run chuck', async function() {
      const code = await Chirp.run('./test/run/run.ck', false)
      assert.equal(code, 0)
    })
  })
})
