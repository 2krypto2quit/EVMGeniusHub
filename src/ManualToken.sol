//SPDX-LICENSE-IDENTIFIER: MIT

pragma solidity ^0.8.19;

interface tokenRecipient {
    
    function receiveApproval(
        address _from, 
        uint256 _value, 
        address _token, 
        bytes calldata 
        _extraData
        ) external;
}

        contract ManualToken {
            
            string public name;
            string public symbol;
            uint8 public decimals = 18;
            uint256 public totalSupply;

            mapping(address => uint256) public balanceOf;
            mapping(address => mapping(address => uint256)) public allowance;

            event Transfer(address indexed from, address indexed to, uint256 value);
            event Approval(address indexed _owner, address indexed _spender, uint256 value);
            event Burn(address indexed from, uint256 value);

            constructor( uint256 initalSupply, string memory tokenName, string memory tokenSymbol) {
                totalSupply = initalSupply * 10 ** uint256(decimals);
                balanceOf[msg.sender] = totalSupply;
                name = tokenName;
                symbol = tokenSymbol;
            }

            /** Internal transfer, only can be called by this contract */

            function transfer(address _from, address _to, uint256 _value) internal{
                
                require(_to != address(0x0));
                require(balanceOf[_from] >= _value);
                require(balanceOf[_to] + _value >= balanceOf[_to]);
                uint256 previousBalances = balanceOf[_from] + balanceOf[_to];
                balanceOf[_from] -= _value;
                balanceOf[_to] += _value;

                emit Transfer(_from, _to, _value);
                assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
            }

     
        function transfer(address to, uint256 value) public returns (bool success) {
            transfer(msg.sender, to, value);
            return true;
        }

        function transferFrom(address from, address to, uint256 value) public returns (bool success) {
            require(value <= allowance[from][msg.sender]);
            allowance[from][msg.sender] -= value;
            transfer(from, to, value);
            return true;
        }

        function approve(address spender, uint256 value) public returns (bool succcess) {
            
            allowance[msg.sender][spender] = value;

            emit Approval(msg.sender, spender, value);
            
            return true;

        }

        function approveAndCall(address spender, uint256 value, bytes memory extraData) public returns (bool success) {
           
            tokenRecipient _spender = tokenRecipient(spender);

            if(approve(spender, value)) {
                _spender.receiveApproval(msg.sender, value, address(this), extraData);
                return true;
            }
        }

        // Destroy tokens
        function burn(uint256 value) public returns (bool success) {

            require(balanceOf[msg.sender] >= value);

            balanceOf[msg.sender] -= value;

            totalSupply -= value;

            emit Burn(msg.sender, value);

            return true;
        }

        // Destroy tokens from other account
        function burnFrom(address from, uint256 value) public returns (bool success) {
            
            require(balanceOf[from] >= value);
            
            require(value <= allowance[from][msg.sender]);
        
            balanceOf[from] -= value;

            allowance[from][msg.sender] -= value;

            totalSupply -= value;   

            emit Burn(from, value);

            return true;            

        }
    }
