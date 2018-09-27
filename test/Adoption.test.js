const Adoption = artifacts.require('../contracts/Adoption');

contract('Beethoven', accounts => {
    let creator = accounts[0];
    let contract;
    const initContracts = async () => {
		contract = await Adoption.new(
			{
				from: creator
			}
        );
    }

    describe('adopt', () => {
        before(initContracts);
        it("should adopt pet", async () => {
            let tx = await contract.adopt(0);
            assert.equal(tx.logs.length , 2, 'wrong num of events');
            assert.isTrue(tx.logs[0].event === 'Adoption', 'wrong event Name');
        })
    });
});
