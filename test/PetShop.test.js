const PetShop = artifacts.require("./contracts/PetShop.sol");

contract("PetShop", accounts => {
  let creator = accounts[0];
  let alice = accounts[1];
  let contract;
  const initContracts = async () => {
    contract = await PetShop.new(1, 10, {
      from: creator
    });
  };

  describe("purchase", () => {
    before(initContracts);
    it("should purchase pet", async () => {
      let tx = await contract.purchase(0, {
        from: alice,
        value: 2000000000000000000
      });
    //   console.log(tx.logs[0]);
      assert.equal(tx.logs.length, 1, "wrong num of events");
      assert.isTrue(tx.logs[0].event === "Purchase", "wrong event Name");
      assert.equal(tx.logs[0].event, "Purchase", "wrong num of events");

      assert.equal(tx.logs[0].args.buyer.valueOf(), alice, "wrong buyer");
    });

    it("should not purchase a pet not in shopt", async () => {
      try {
        let tx = await contract.purchase(20, {
          from: creator,
          value: 2000000000000000000
        });
      } catch (err) {
            // console.log(err.message);
            assert.equal(err.message, 'VM Exception while processing transaction: revert', 'not reverted');
      }
    });
  });

  describe("sell", () => {
    before(initContracts);
    it("sell the pet", async () => {
      await contract.purchase(1, { from: creator, value: 1000000000000000000 });
      let tx = await contract.sell(1, 1, { from: creator });
      assert.equal(tx.logs.length, 1, "wrong num of events");
      assert.isTrue(tx.logs[0].event === "Sell", "wrong event Name");
      assert.equal(tx.logs[0].args.petId.valueOf(), 1, "wrong Id");
      assert.equal(tx.logs[0].args.quantity.valueOf(), 1, "wrong newQuantity");
      assert.equal(
        tx.logs[0].args.seller.valueOf(),
        creator,
        "wrong newQuantity"
      );
    });
  });

  describe("addOnePet", () => {
    before(initContracts);
    it("adds One Pet", async () => {
      let tx = await contract.addOnePet(16, 10, 1000000000000000000, "SG");
      let pet = await contract.pets.call(16);
    //   console.log(pet);
    //   console.log(tx.logs[0]);
      assert.equal(pet[0].valueOf(), 16, "wrong Id");
      assert.equal(pet[1].valueOf(), 10, "wrong newQuantity");
      assert.equal(pet[2].valueOf(), 1000000000000000000, "wrong price");
      assert.equal(pet[3].valueOf(), 'SG', "wrong location");
    });
  });
});
