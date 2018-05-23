const assert = require('assert');
const Chirp = require('../chirp');

describe('Chirp', function() {
  describe('#run', function() {
    it('should return a runnable chuck command', async function() {
      const command = await Chirp.generateChuckCommand('test/generate-chuck-command/base.ck')
      assert.equal(
        command,
        "chuck test/generate-chuck-command/one.ck test/generate-chuck-command/three.ck test/generate-chuck-command/two.ck test/generate-chuck-command/base.ck")
    })
  })
})
