const PetShop = artifacts.require('../contracts/PetShop');

contract('PetShop', accounts => {
    let creator = accounts[0];
    let contract;
    const initContracts = async () => {
		contract = await PetShop.new(1,10,
			{
				from: creator
			}
        );
    }

    describe('purchase', () => {
        before(initContracts);
        it("should purchase pet", async () => {
            let tx = await contract.purchase(0, {from: creator, value: 2000000000000000000});
            console.log(tx);
            assert.equal(tx.logs.length , 1, 'wrong num of events');
            assert.isTrue(tx.logs[0].event === 'Purchase', 'wrong event Name');
        });
    });
});
