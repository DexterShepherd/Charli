const assert = require('assert');
const Chirp = require('../chirp');


describe('Chirp', function() {
  describe('#processIncludes', function() {
    it('should append to the end of the base code', async function() {
      const correct = await Chirp.loadFile('./test/include/passing_global.cp')
      const processed = await Chirp.processFile('./test/include/base_global.cp')
      assert.equal( correct, processed, )
    }) 
    it('should append within the included scope', async function() {
      const correct = await Chirp.loadFile('./test/include/passing_scoped.cp')
      const processed = await Chirp.processFile('./test/include/base_scoped.cp')
      assert.equal( correct, processed, )
    })
  })
})
