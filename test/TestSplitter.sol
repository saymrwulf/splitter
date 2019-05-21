pragma solidity >=0.5.0 <0.6.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Splitter.sol";

contract TestSplitter {

    uint public initialBalance = 101 finney;
    address bob = 0x0123456789012345678901234567890123456789;
    address carol = 0x1234567890123456789012345678901234567890;

    function testSplitEqualBobCarol() public {
        Splitter splitter = new Splitter();

        splitter.split.value(100 finney)(bob, carol);

        Assert.equal(address(splitter).balance, 100 finney, "Splitter contract should have the Ether");
        Assert.equal(splitter.balances(bob), 50 finney, "Bob should be owed the exact half");
        Assert.equal(splitter.balances(carol), 50 finney, "Carol should be owed the exact half");
    }

    function testSplitUnequalBobCarol() public {
        Splitter splitter = new Splitter();

        splitter.split.value(200003)(bob, carol);

        Assert.equal(address(splitter).balance, 200003, "Splitter contract should have the Ether");
        Assert.equal(splitter.balances(bob), 100001, "Bob should be owed the smaller half");
        Assert.equal(splitter.balances(carol), 100002, "Carol should be owed the larger half");
    }
}
