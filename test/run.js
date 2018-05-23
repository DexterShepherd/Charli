const assert = require('assert');
const Charli = require('../charli');

describe('Charli', function() {
  describe('#run', function() {
    it('should run chuck', async function() {
      const code = await Charli.run('./test/run/run.ck', false)
      assert.equal(code, 0)
    })
  })
})
