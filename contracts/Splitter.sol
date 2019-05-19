pragma solidity >=0.4.25 <0.6.0;

contract Splitter {
	mapping (address => uint) public balances;

	event Transfer(address indexed _from, address indexed _to1, address indexed _to2, uint256 _value);

	constructor() public {
		balances[msg.sender] = 10000;
	}

	function sendSplitCoin(address receiver1, address receiver2, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver1] += amount/2;
		balances[receiver2] += amount/2;
		emit Transfer(msg.sender, receiver1, receiver2, amount);
		return true;
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
}
