const assert = require('assert');
const Chirp = require('../chirp');

describe('Chirp', function() {
  describe('#processRequires', function() {
    it('should return all required paths', async function() {
      const input = await Chirp.loadFile('test/require/require.ck')
      assert.deepEqual( 
        await Chirp.processRequires(input, 'test/require/require.ck'),
        [ 'test/require/class-1.ck', 
          'test/require/class-2.ck',
          'test/require/class-3.ck' ]
      )
    })
  })
})
