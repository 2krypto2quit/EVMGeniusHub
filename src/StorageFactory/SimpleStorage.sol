// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

//public: Functions and state variables declared as public can be accessed both internally (from within the contract itself)
//and externally (from outside the contract). This means they can be called by any other contract or external account.

//private: Functions and state variables declared as private are only accessible within the contract that defines them.
//They cannot be accessed or called from outside the contract.

//internal: Functions and state variables declared as internal are only accessible within the contract that defines them
//and contracts derived from it (i.e., contracts that inherit from it). They cannot be accessed externally.

//external: Functions declared as external are similar to public functions in that they can be called from outside the contract,
//but they can only be called externally (i.e., by other contracts or external accounts), not internal

//public view - Read only state changes\

//public pure -

//EVM can access and storre informtion in six places
// 1. Stack 2. Memory 3. Storage 4. Calldata  5. Code 6. Logs

contract SimpleStorage {
    //default intialization  = 0
    uint256 myFavoriteNumber;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    Person[] public listOfPeople;

    //Another way to create
    Person public person = Person({favoriteNumber: 7, name: "Kim DotCom"});

    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public virtual {
        myFavoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return myFavoriteNumber;
    }

    //calldata, memory, storage is temporary only exisit for the duration of the function call
    // calldata cannot be modified;
    //memory can be modified
    //storage permanent and can be modified

    //When passed as function parameters, structs, mappings, and arrays in Solidity need to use the explicit memory keyword.
    //Strings, considered an array of bytes, require explicit memory or calldata keyword.

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}

contract SimpleStorage2 {}

contract SimpleStorage3 {}

contract SimpleStorage4 {}
