const assert = require('assert');
const Charli = require('../charli');

describe('Charli', function() {
  describe('#processRequires', function() {
    it('should return all required paths', async function() {
      const input = await Charli.loadFile('test/require/require.ck')
      assert.deepEqual( 
        await Charli.processRequires(input, 'test/require/require.ck'),
        [ 'test/require/class-1.ck', 
          'test/require/class-2.ck',
          'test/require/class-3.ck' ]
      )
    })
  })
})
