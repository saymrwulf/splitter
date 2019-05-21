pragma solidity >=0.4.25 <0.6.0;

contract Splitter {
    event LogSplit(address indexed sender, address indexed bob, address indexed carol, uint amount);
    event LogWithdrawn(address indexed who, uint amount);

	mapping (address => uint) public balances;

	constructor() public {
		balances[msg.sender] = 10000;
	}

    function split(address bob, address carol) payable public {

        require(bob != address(0));
        require(carol != address(0));

        uint half = msg.value / 2;
        require(half > 0);
        balances[bob] += half;
        balances[carol] += msg.value - half;
        // We do not log the balance, only the change.
        emit LogSplit(msg.sender, bob, carol, msg.value);
    }
}
