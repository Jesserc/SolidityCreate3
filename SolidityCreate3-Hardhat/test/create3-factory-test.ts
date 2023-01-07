import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";

const ContractFactoryABI = require("../out/Create3Factory.sol/ContractFactory.json");

describe("Create3 factory contract test", function () {
  /*  before(async function () {
    let Create3Factory = await ethers.getContractFactory("Create3Factory");
    let create3Factory = await Create3Factory.deploy();
    await create3Factory.deployed();
  });
 */
  async function deployFactoryContract() {
    let Create3Factory = await ethers.getContractFactory("Create3Factory");
    let create3Factory = await Create3Factory.deploy();
    await create3Factory.deployed();

    return { create3Factory };
  }

  describe("Deployment", function () {
    it("Should deploy a new child contract with create 3", async function () {
      const { create3Factory } = await loadFixture(deployFactoryContract);
      const createdChild = await create3Factory.deployChild("Jesserc", {
        value: ethers.utils.parseEther("2"),
      });
      await expect(await (await createdChild.wait()).status).to.be.equal(1);
    });
  });

  describe("Get deployed child contract", () => {
    it("Should get previously deployed child contract", async function () {
      const { create3Factory } = await loadFixture(deployFactoryContract);
      //0xA43Ed310e28CCA7Ea3b890EdfF825934B9319B78
      const getChild = await create3Factory.getDeployed("Jesserc");

      // console.log("Deployed child contract with salt 'Jesserc' " + getChild);
      await expect(await getChild.toString()).to.be.equal(
        "0x157209244D9cC951f1DeFe19792af00CdaFe9049"
      );
    });
  });

  describe("Verify deployed child ", () => {
    it("Should verify that a child contract was deployed from it, given a salt and an address", async function () {
      const { create3Factory } = await loadFixture(deployFactoryContract);
      const createdChild = await create3Factory.deployChild("Jesserc", {
        value: ethers.utils.parseEther("2"),
      });

      const getChild = await create3Factory.getDeployed("Jesserc");
      const success = await create3Factory.verifyDeployed("Jesserc", getChild);
      // console.log(success);
      await expect(success.status).to.be.equal(true);
      await expect(success.childSalt.toString()).to.be.equal(
        "0xf9755126fc063f2efa34b154637fbc7fc7c598bb68ab1b00b0c5113588c6ac64"
      );
    });
  });
});
