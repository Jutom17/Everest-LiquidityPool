// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract FakeToken {
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // Track how many tokens are owned by each address.
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping(address => uint256)) public allowance;

    string public _name;
    string public _symbol;
    address public _owner;
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (uint256(10) ** decimals);


    // Assign all tokens to the contract's creator.
    constructor(address owner_, string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        _owner = owner_;
        _mint(_owner, totalSupply);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }
    
    function _mint(address account, uint256 amount) internal virtual {
        require(msg.sender == _owner, "[Token] Only owner can perform this");
        require(account != address(0), "[Token] mint to the zero address"); 
        balanceOf[msg.sender] += amount;
        emit Transfer(address(0), msg.sender, amount); 
    }

    function transfer(address to, uint256 value) public returns (bool success) {
        require(balanceOf[msg.sender] >= value, "Not enough funds");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool success) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true; 
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool success){
        require(value <= balanceOf[from]);
        require(value <= allowance[from][msg.sender]);

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

}
